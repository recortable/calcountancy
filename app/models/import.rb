
class Import
  attr_reader :account_number, :account_name, :initial_balance, :movements, :end_balance
  attr_reader :errors, :records_to_import, :records_duplicated
  def initialize(account, text)
    @account = account
    @text = text
    @movements = []
    @errors = []
    @current = nil
    @records_to_import = 0
    @records_duplicated = 0
    parse
    validate
  end

  def valid?
    @errors.size == 0 && @records_to_import > 0
  end

  def movements?
    @movements.size > 0
  end

  def begin_date
    @begin_date
  end

  def end_date
    @end_date
  end

  def errors?
    @errors.size > 0
  end

  private
  def add_error(message)
    @errors << message
  end

  def parse
    @text.each do |line|
      code = line[0..1]
      parse_header(line) if code == '11'
      parse_movement_main(line) if code == '22'
      parse_movement_optional(line) if code == '23'
      parse_end(line) if code == '33'
      return if errors?
    end
    @movements << @current if @current
  end

  def parse_header(line)
    @account_number = line[2..19]
    @begin_date = Date.from_nor43(line[20..25])
    @end_date = Date.from_nor43(line[26..31])
    @initial_balance = line[33..46].to_i
    @current_balance = @initial_balance
    @account_name = line[51..76]
    add_error I18n.t('import.errors.different_accounts') if @account_number != @account.account_number
  end

  def parse_movement_main(line)
    add_error I18n.t('import.errors.no_header') unless @account_number
    @movements << @current if @current
    date = Date.from_nor43(line[10..15]).to_db
    operation = parse_operation(line[27..27])
    ammount = parse_ammount(line[28..41])
    ammount = ammount * -1 if operation == '-'
    @current_balance = @current_balance + ammount
    @current = Movement.new(:account_id => @account.id, :ammount => ammount, :balance => @current_balance, :date => date)
  end

  def parse_movement_optional(line)
    @current.concept = line[4,79].strip
  end

  def parse_end(line)
    @end_balance = line[59..72].to_i
  end

  def parse_operation(value)
    return '-' if value == '1'
    return '+' if value == '2'
  end

  def parse_ammount(value)
    value.to_i
  end

  def validate
    @stored = @account.movements_between(@begin_date, @end_date).all
    by_code = {}
    @stored.each {|m| by_code[m.code] = m}

    @movements.each do |movement|
      code = movement.generate_code
      state = by_code[code].nil? ? 'import' : 'duplicate'
      movement.import = state
      @records_to_import += 1 if state == 'import'
      @records_duplicated += 1 if state == 'duplicate'
    end
  end

end
