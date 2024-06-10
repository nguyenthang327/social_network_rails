module Authentication
    extend ActiveSupport::Concern

    included do
        before_action :current_user
        helper_method :current_user
        helper_method :user_signed_in?
    end

    def login(user)
        reset_session
        session[:current_user_id] = user.id
    end

    def logout
        reset_session
    end

    def redirect_if_authenticated
        redirect_to posts_path, alert: "You are logged in" if user_signed_in? 
    end

    private

    def current_user
        Current.user ||= session[:current_user_id] && User.find_by(id: session[:current_user_id])
    end

    def user_signed_in?
        Current.user.present?
    end

    def require_user
        redirect_to login_path unless current_user
    end
end