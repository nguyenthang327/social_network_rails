class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create :send_notification

  private

  def send_notification
    PostNotificationMailer.new_like(self.post, self.user).deliver_later
  end
end
