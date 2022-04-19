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
        expect(@record_address.errors.full_messages).to include "クレジットカード情報を入力してください"
      end
      it 'post_codeが空では購入できない' do
        @record_address.post_code = ''
        @record_address.valid?
        expect(@record_address.errors.full_messages).to include "郵便番号を入力してください"
      end
      it 'prefecture_idが空では購入できない' do
        @record_address.prefecture_id = '1'
        @record_address.valid?
        expect(@record_address.errors.full_messages).to include "都道府県を選択してください。"
      end
      it 'municipalitiesが空では購入できない' do
        @record_address.municipalities = ''
        @record_address.valid?
        expect(@record_address.errors.full_messages).to include "市区町村を入力してください"
      end
      it 'addressが空では購入できない' do
        @record_address.address = ''
        @record_address.valid?
        expect(@record_address.errors.full_messages).to include "番地を入力してください"
      end
      it 'phone_numberが空では購入できない' do
        @record_address.phone_number = ''
        @record_address.valid?
        expect(@record_address.errors.full_messages).to include "電話番号を入力してください"
      end
      it 'post_codeは3桁ハイフン4桁の半角文字列でないと購入できない' do
        @record_address.post_code = '1234567'
        @record_address.valid?
        expect(@record_address.errors.full_messages).to include "郵便番号はハイフン(-)を含めて入力してください。"
      end
      it 'phone_numberは10桁以上11桁以内の半角数値でないと購入できない' do
        @record_address.phone_number = '11112222'
        @record_address.valid?
        expect(@record_address.errors.full_messages).to include "電話番号は数字のみ入力してください。"
      end
      it 'phone_numberは12桁以上だと購入できない' do
        @record_address.phone_number = '000011112222333'
        @record_address.valid?
        expect(@record_address.errors.full_messages).to include "電話番号は数字のみ入力してください。"
      end
      it 'phone_numberは全角数字だと購入できない' do
        @record_address.phone_number = '０００１１１１２２２２'
        @record_address.valid?
        expect(@record_address.errors.full_messages).to include "電話番号は数字のみ入力してください。"
      end
      it 'userが紐付いていないと購入できない' do
        @record_address.user_id = nil
        @record_address.valid?
        expect(@record_address.errors.full_messages).to include "Userを入力してください"
      end
      it '商品情報が紐付いていないと購入できない' do
        @record_address.item_id = ''
        @record_address.valid?
        expect(@record_address.errors.full_messages).to include "Itemを入力してください"
      end
    end
  end
end
