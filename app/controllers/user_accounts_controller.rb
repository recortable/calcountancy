class UserAccountsController < ApplicationController
  inherit_resources
  respond_to :html, :xml, :json, :js
  defaults :resource_class => Account, :collection_name => 'accounts', :instance_name => 'account'
  before_filter :require_user
  belongs_to :current_user
end
