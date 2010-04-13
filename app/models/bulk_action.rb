
class BulkAction
  def initialize(user, params = {})
    @user = user
    @action = params[:action]
    @label_id = params[:label]
    @movement_ids = params[:movement_ids].split(',')
  end

  def save
    Tagging.transaction do
      self.movements.each do |movement|
        Tagging.create!(:tag_id => tag.id, :movement_id => movement.id, :user_id => @user.id)
      end
    end
  end

  def tag
    @tag = Tag.find(@label_id)
  end

  def size
    @movement_ids.size
  end

  def movements
    @movements ||= Movement.find(:all, :conditions => {:id => @movement_ids})
  end
end
