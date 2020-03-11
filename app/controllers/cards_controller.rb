class CardsController < ApplicationController
  require "payjp"

  before_action :set_card

  def new 

  end

  def create

    # 秘密鍵の設定
    Payjp.api_key = 'sk_test_a2dd327111d09e322058d1c2'

    # トークンが取得できなかった場合、登録画面へ戻る
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      # トークンが正常に発行されていたら、顧客情報をPAY.JPに登録する。
      customer = Payjp::Customer.create(
        # トークンを設定
        card: params['payjp-token']
      )
      
      # カード情報をnewする
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      
      # 登録が成功した場合、購入確認画面へ遷移する
      if @card.save
        # セッションから購入手続き中の商品IDを取得する
        product_id = session[:product_id]
        
        # 購入確認画面へ遷移する
        redirect_to new_product_transaction_path(product_id)
      else
        redirect_to action: "new"
      end
    end
  end

  def

  private

  def set_card
    @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end
end
