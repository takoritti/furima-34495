class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
  validates :nickname
  validates :birth_day
  end
  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥]+\z/ } do
  validates :name_family
  validates :name_first
  end
  with_options presence: true, format: { with: /\A[ァ-ヶー－]+\z/ } do
  validates :name_family_kana
  validates :name_first_kana
  end
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i }

  has_many :items
  has_many :comments
  has_many :purchase_records
end
