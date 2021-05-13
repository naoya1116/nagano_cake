class Public::CustomersController < ApplicationController
   before_action :authenticate_customer!

  def show
   @customer = current_customer
  end

  def edit
   @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:success] = "個人情報を編集しました"
      redirect_to customers_my_page_path
    else
      flash[:danger] = '個人情報の編集に失敗しました'
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    @customer = current_customer
    #現在ログインしているユーザーを@customerに格納
    @customer.update(is_active: "退会済み" )
    #updateで登録情報を退会済みに変更
    reset_session
    #sessionIDのresetを行う
    redirect_to root_path
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    #指定されたrootへのpath
  end

  private

  def customer_params
    params.require(:customer).permit(:email,:last_name,:first_name,:last_name_kana,:first_name_kana,:postal_code,:address,:telephone_number,:is_active)
  end
end
