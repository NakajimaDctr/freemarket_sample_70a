# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  after_action :create_address, only: :create

  def new
    @user = User.new
    @user.build_address
  end

  def create
    super

    if current_user
      @address = Address.new(address_params)
      if @address.save
        redirect_to  root_path
        return
      else
        render  new_user_registration_path
      end
    end
  end

  def address_params
    params.require(:user).require(:address).permit(:prefecture_id, :municipalities,:family_name_kanji,:first_name_kanji,:family_name_kana,:first_name_kana,
                                    :postal_code,:block_number,:building_name,:room_number,:phone_number).merge(user_id: current_user.id)
  end
end
