
class Tagging < ActiveRecord::Base
  belongs_to :movement
  belongs_to :tag
  belongs_to :user

  after_create :update_tag

  private
  def update_tag
    self.tag.update_attribute(:size, self.tag.size + 1)
  end
end
