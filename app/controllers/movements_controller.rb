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

  def comentar
    @comment = "#{Date.today.fecha} - #{current_user.name}: #{params[:comment]}"
    @movement = Movement.find(params[:id])
    previous = @movement.comments.blank? ? '' : @movement.comments
    @movement.comments = previous + @comment + "\n"
    if !@movement.save
      @comment = "Error guardando el comentario!"
    end
  end
end
