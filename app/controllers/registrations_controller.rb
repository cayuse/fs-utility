class RegistrationsController < Devise::RegistrationsController

  def sign_up_params
    allow = [:email, :password, :password_confirmation, :fullname, :name]
    params.require(resource_name).permit(allow)
  end

end

