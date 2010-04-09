class TaggingsController < ApplicationController
  before_filter :require_user
  inherit_resources
  respond_to :js
  actions :create, :destroy

  def create
    @tag = Tag.find(params[:tag_id])
    @movement = Movement.find(params[:movement_id])
    if can? :manage, @movement
      if @movement.tags.include?(@tag)
        render :text => ''
      else
        @tagging = Tagging.new(:tag => @tag, :user => @user, :movement => @movement)
        create! do |success, failure|
          success.js { render :action => 'create.js'}
          failure.js { render :action => 'failure.js'}
        end
      end
    else
      render :action => 'not_authorized.js'
    end
  end

  def destroy
    destroy!
  end

end
