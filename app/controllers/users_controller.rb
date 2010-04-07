class UsersController < ApplicationController
  inherit_resources
  respond_to :html, :xml, :json, :js
  actions :show
end
