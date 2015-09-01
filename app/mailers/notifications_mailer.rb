class NotificationsMailer < ApplicationMailer
  def new_user(user_params)
    mail(
      to:       user_params[:email],
      subject:  "Welcome to Farmers Market, #{user_params[:first_name]}!"
    )
  end
end
