
class Ability
  include CanCan::Ability

  def initialize(user)
    can(:read, Account) do |account|
      !user.nil?
    end

    can(:manage, User) do |action, document|
      !user.nil?
    end
  end
end