class CurrentUserConstraint
  # def matches?(request)
  #   Rails.logger.info "ENV: #{request.env}"
  #   request.session[:current_user_id].present?
  # end

  def matches?(request)
    request.session[:current_user_id].present?
    # request.session.key?(:current_user_id)
  end
end