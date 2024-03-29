class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    helper_method :current_user

    def current_user
        if session[:user_id]
            @current_user ||= User.find(session[:user_id])
        end
    end

    def authorize
        if !current_user
            render :json => { :error => "Not authorized" }, :status => 401
        end
    end
end
