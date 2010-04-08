class UserAccountsController < ApplicationController
  before_filter :require_user
  inherit_resources
  respond_to :html, :xml, :json, :js
  defaults :resource_class => Account, :collection_name => 'accounts', :instance_name => 'account'
  belongs_to :current_user

  def update
    update! do |success, failure|
      success.html { redirect_to user_account_path(@account)}
    end
  end
end
