class UsersController < ApplicationController
  before_filter :require_user
  inherit_resources
  respond_to :html, :xml, :json, :js
  actions :show
end
