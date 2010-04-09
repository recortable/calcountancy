class UserAccountTagsController < ApplicationController
  before_filter :require_user, :load_account
  inherit_resources
  respond_to :html, :xml, :json, :js
  defaults :resource_class => Tag, :collection_name => 'tags', :instance_name => 'tag'

  def index
    @tags = @account.tags
    index!
  end

  def new
    @tag = @account.tags.build
    new!
  end

  def create
    @tag = @account.tags.build(params[:tag])
    create! do |success, failure|
      success.html {redirect_to user_account_tags_path(@account)}
    end
  end

  def update
    update! do |success, failure|
      success.html {redirect_to user_account_tags_path(@account)}
    end
  end


  private
  def load_account
    @user = current_user
    @account = @user.accounts.find(params[:account_id])
  end
end
