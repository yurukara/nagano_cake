# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController

  before_action :member_state, only:[:create]

  def after_sign_in_path_for(resource)
    flash[:alert] = 'ログインしました。'
    root_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def member_state
    @member = Member.find_by(email: params[:member][:email])
    return if !@member
      if @member.valid_password?(params[:member][:password]) && @member.is_deleted == false
        elsif unless @member.valid_password?(params[:member][:password])
          flash[:alert] = 'パスワードが違います'
          redirect_to new_member_session_path
        end
      else
        flash[:alert] = '退会済みです。再度新規登録を行なってください。'
        redirect_to root_path
      end
  end


  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
