class MyDevise::RegistrationsController < Devise::RegistrationsController
  
  def create
    super
    session['devise.omniauth'] = nil unless @user.new_record?
  end

  def build_resource(*args)
    super
    if session['devise.omniauth']
      @user.apply_omniauth(session['devise.omniauth'])
      @user.valid?
    end
  end

  def update
    @user = User.find(current_user.id)

    if update_user?
      # crop profile image if present
      if profile_exists?
        render "crop"
      else
        bypass_sign_in resource, scope: resource_name
        redirect_to show_path
      end
    else
      render :edit
    end
  end

  private

  def update_user?
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)
    if account_update_params[:password].blank?
      params[:user].delete(:current_password)
      return @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
    else
      return @user.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
    end
  end

  def profile_exists?
    params[:user][:profile].present?
  end
end
