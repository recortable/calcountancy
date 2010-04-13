
class Tagging < ActiveRecord::Base
  belongs_to :movement
  belongs_to :tag
  belongs_to :user

  after_create :increment_tag
  after_destroy :decrement_tag

  private
  def increment_tag
    self.tag.update_attribute(:size, self.tag.size + 1)
  end

  def decrement_tag
    self.tag.update_attribute(:size, self.tag.size - 1)
  end
end
