class CustomDeviseMailer < Devise::Mailer
  default template_path: 'devise/mailer' # needed for Devise views

  # def reset_password_instructions(record, token, opts = {})
  #   # Change the reset password URL to point to the frontend
  #   opts[:redirect_url] ||= "http://localhost:5173/reset-password?token=#{token}"
  #   super
  # end
  # def reset_password_instructions(record, token, opts = {})
  #   # Override Devise's default URL method by injecting your own link
  #   @token = token
  #   @resource = record

  #   # Use your frontend URL in the message body
  #   mail(
  #     to: record.email,
  #     subject: 'Reset password instructions'
  #   ) do |format|
  #     format.html {
  #       render inline: <<-HTML
  #         <p>Hello #{@resource.email}!</p>
  #         <p>You can reset your password by clicking the link below:</p>
  #         <p><a href="http://localhost:5173/reset-password?token=#{@token}">Reset My Password</a></p>
  #         <p>If you didn't request this, please ignore this email.</p>
  #       HTML
  #     }
  #   end
  # end
  def reset_password_instructions(record, token, opts = {})
    # Manually override the link helper Devise uses inside the default template
    @token = token
    @resource = record

    frontend_url = Rails.env.production? ? 
    "https://cipher-genius.onrender.com" : 
    "http://localhost:8080"  # or whatever port your Vue dev server uses
  
    # Inject a custom URL into the email template via instance var
    @custom_reset_link = "#{frontend_url}/reset-password?token=#{token}"


    devise_mail(record, :reset_password_instructions, opts)
  end
end
