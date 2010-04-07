
require 'yaml'

class Seeder
  USERS = YAML.load_file("#{RAILS_ROOT}/private/users.yml")
  ACCOUNTS = YAML.load_file("#{RAILS_ROOT}/private/accounts.yml")

  def initialize
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    @users = []
    @accounts = []
    
    USERS.each do |user|
      create_user user[1]
    end

    ACCOUNTS.each do |account|
      create_account account[1]
    end

    calc = @accounts[0]
    calc.users << @users
    calc.save!
    calc_iva = @accounts[1]
    calc_iva.users << @users
    calc_iva.save!
    dani = @accounts[2]
    dani.users << @users[0]
    dani.save!
  end

  def create_account(account)
    @accounts << Account.create!(account)
  end

  def create_user(user)
    user['password_confirmation'] = user['password']
    @users << User.create!(user)
  end
end

Seeder.new