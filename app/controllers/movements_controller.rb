class MovementsController < ApplicationController
  before_filter :require_user
  inherit_resources
  respond_to :html, :xml, :json, :js
  actions :edit, :update

  def edit
    edit!
  end

  def update
    update! do |success, failure|
      success.html { redirect_to user_account_path(@movement.account)}
    end
  end
end
