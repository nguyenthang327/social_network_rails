class PostNotificationMailer < ApplicationMailer
  def new_like(post, user)
    @post = post
    @user = user_id
    mail(to: @post.user.email, subject: 'New like!')
  end

  def new_comment(post, comment)
    @post = post
    @comment = comment
    mail(to: @post.user.email, subject: 'New comment!')
  end
end
