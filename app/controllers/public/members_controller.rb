class Public::MembersController < ApplicationController
  before_action :authenticate_member!

  def show
  end

  def edit
    @member = current_member
  end

  def update
    @member = current_member
    if @member.update(member_params)
      flash[:alert] = '更新が完了しました。'
      redirect_to my_page_path
    else
      render :edit
    end
  end

  def confirm
  end

  def withdraw
    current_member.update(is_deleted: true)
    # 遷移先はルートパスであっている？
    reset_session
    flash[:alert] = '退会しました。'
    redirect_to root_path
  end


  private

  def member_params
    params.require(:member).permit(:last_name,:first_name,:last_name_kana,:first_name_kana,:postal_code,:address,:phone_number,:email,:is_deleted)
  end
end
