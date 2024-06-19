class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content, presence: true

  after_create :send_notification

  private

  def send_notification
    PostNotificationMailer.new_comment(self.post, self).deliver_later
  end
end
