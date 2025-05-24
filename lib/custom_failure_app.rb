class CustomFailureApp < Devise::FailureApp
  def route(scope)
    :root_path # or :dashboard_path if defined
  end

  def respond
    if warden_message == :inactive
      flash[:alert] = i18n_message(:inactive_account)
      sign_out(scope) if scope
      redirect_to route(scope)
    else
      super
    end
  end
end
