require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品商品できる時' do
      it 'images, item_name, description, category, condition, postage, prefecture, days_to_ship, price, userが正しければ出品できる' do
        expect(@item).to be_valid
      end
    end

    context '商品出品できない時' do
      it 'imagesが空では出品できない' do
        @item.images = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "商品画像を入力してください"
      end
      it 'item_nameが空では出品できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "商品名を入力してください"
      end
      it 'descriptionが空では出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "商品の説明を入力してください"
      end
      it 'category_idが空では出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "カテゴリーを選択してください。"
      end
      it 'condition_idが空では出品できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "商品の状態を選択してください。"
      end
      it 'postage_idが空では出品できない' do
        @item.postage_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "配送料の負担を選択してください。"
      end
      it 'prefecture_idが空では出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "発送元の地域を選択してください。"
      end
      it 'days_to_ship_idが空では出品できない' do
        @item.days_to_ship_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "発送までの日数を選択してください。"
      end
      it 'priceが空では出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "販売価格を入力してください"
      end
      it 'priceが300未満では出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include "販売価格は¥300〜9,999,999の間で入力してください。"
      end
      it 'priceが9_999_999より多いと出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include "販売価格は¥300〜9,999,999の間で入力してください。"
      end
      it 'priceが全角では出品できない' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include "販売価格は半角数字を入力してください。"
      end
      it 'userが紐付いていないと出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Userを入力してください"
      end
    end
  end
end
