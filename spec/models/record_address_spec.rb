require 'rails_helper'

RSpec.describe RecordAddress, type: :model do
  describe '商品購入' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @record_address = FactoryBot.build(:record_address, user_id: @user.id, item_id: @item.id)
    end

    context '商品購入できる時' do
      it 'すべての値が正しく入力されていれば購入できる' do
        expect(@record_address).to be_valid
      end
      it 'buildingは空でも購入できる' do
        @record_address.building = ''
        expect(@record_address).to be_valid
      end
    end

    context '商品購入できない時' do
      it 'tokenが空では購入できない' do
        @record_address.token = ''
        @record_address.valid?
        expect(@record_address.errors.full_messages).to include "Token can't be blank"
      end
      it 'post_codeが空では購入できない' do
        @record_address.post_code = ''
        @record_address.valid?
        expect(@record_address.errors.full_messages).to include "Post code can't be blank"
      end
      it 'prefecture_idが空では購入できない' do
        @record_address.prefecture_id = '1'
        @record_address.valid?
        expect(@record_address.errors.full_messages).to include "Prefecture can't be blank"
      end
      it 'municipalitiesが空では購入できない' do
        @record_address.municipalities = ''
        @record_address.valid?
        expect(@record_address.errors.full_messages).to include "Municipalities can't be blank"
      end
      it 'addressが空では購入できない' do
        @record_address.address = ''
        @record_address.valid?
        expect(@record_address.errors.full_messages).to include "Address can't be blank"
      end
      it 'phone_numberが空では購入できない' do
        @record_address.phone_number = ''
        @record_address.valid?
        expect(@record_address.errors.full_messages).to include "Phone number can't be blank"
      end
      it 'post_codeは3桁ハイフン4桁の半角文字列でないと購入できない' do
        @record_address.post_code = '1234567'
        @record_address.valid?
        expect(@record_address.errors.full_messages).to include 'Post code is invalid. Include hyphen(-)'
      end
      it 'phone_numberは10桁以上11桁以内の半角数値でないと購入できない' do
        @record_address.phone_number = '11112222'
        @record_address.valid?
        expect(@record_address.errors.full_messages).to include 'Phone number is invalid. Input only number'
      end
      it 'phone_numberは12桁以上だと購入できない' do
        @record_address.phone_number = '000011112222333'
        @record_address.valid?
        expect(@record_address.errors.full_messages).to include 'Phone number is invalid. Input only number'
      end
      it 'phone_numberは全角数字だと購入できない' do
        @record_address.phone_number = '０００１１１１２２２２'
        @record_address.valid?
        expect(@record_address.errors.full_messages).to include 'Phone number is invalid. Input only number'
      end
      it 'userが紐付いていないと購入できない' do
        @record_address.user_id = nil
        @record_address.valid?
        expect(@record_address.errors.full_messages).to include "User can't be blank"
      end
      it '商品情報が紐付いていないと購入できない' do
        @record_address.item_id = ''
        @record_address.valid?
        expect(@record_address.errors.full_messages).to include "Item can't be blank"
      end
    end
  end
end
