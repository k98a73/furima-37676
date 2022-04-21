class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :days_to_ship
  belongs_to :user
  has_one :record
  has_many_attached :images

  with_options presence: true do
    validates :images
    validates :item_name, length: { maximum: 40 }
    validates :description, length: { maximum: 1000 }
    validates :price,
              numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                              message: "は¥300〜9,999,999の間で入力してください。" }
  end

  with_options numericality: { other_than: 1, message: "を選択してください。" } do
    validates :category_id
    validates :condition_id
    validates :postage_id
    validates :prefecture_id
    validates :days_to_ship_id
  end

  validates :price, numericality: { only_integer: true, message: "は半角数字を入力してください。" }
  validates :images, length: { minimum: 1, maximum: 5, message: "は1枚以上5枚以下にしてください" }
end
