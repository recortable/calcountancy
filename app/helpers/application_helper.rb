# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def title(title)
    content_for(:title) {title}
    "<h1>#{title}</h1>"
  end

  def mes(month_number)
    I18n.t "months.month-#{month_number}"
  end

  def icon_link_to(icon, text, url, params = {})
    clzz = params[:class] ? params[:class] : ''
    extra = params.merge({:class => "icon icon_#{icon} #{clzz}", :title => text})
    link_to text, url, extra
  end

  def euros(number, options={})
    # :currency_before => false puts the currency symbol after the number
    # default format: $12,345,678.90
    options = {:currency_symbol => " €", :delimiter => ".", :decimal_symbol => ",", :currency_before => false}.merge(options)

    # split integer and fractional parts
    int, frac = ("%.2f" % (number / 100)).split('.')
    # insert the delimiters
    int.gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1#{options[:delimiter]}")

    if options[:currency_before]
      options[:currency_symbol] + int + options[:decimal_symbol] + frac
    else
      int + options[:decimal_symbol] + frac + options[:currency_symbol]
    end
  end
end
