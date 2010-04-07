
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

    add_users(Account.find_by_name('calc'), @users)
    add_users(Account.find_by_name('calc-iva'), @users)
    add_users(Account.find_by_name('personal'), [User.find_by_name('Dani')])
  end

  def add_users(account, users)
    users.each do |user|
      account.users << user
    end
    account.save
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