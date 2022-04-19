class RecordAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :municipalities, :address, :building, :phone_number, :item_id, :user_id, :token

  validates :prefecture_id, numericality: { other_than: 1, message: "を選択してください。" }

  with_options presence: true do
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "はハイフン(-)を含めて入力してください。" }
    validates :municipalities
    validates :address
    validates :phone_number, format: { with: /\A^(0{1}\d{9,10})$\z/, message: "は数字のみ入力してください。" }
    validates :item_id
    validates :user_id
    validates :token
  end

  def save
    record = Record.create(item_id: item_id, user_id: user_id)

    Address.create(post_code: post_code, prefecture_id: prefecture_id, municipalities: municipalities, address: address,
                   building: building, phone_number: phone_number, record_id: record.id)
  end
end
