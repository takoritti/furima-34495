class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :name_family, presence: true, format:{with: /\A[ぁ-んァ-ヶ一-龥]+\z/ }
  validates :name_family_kana, presence: true, format:{with:  /\A[ァ-ヶー－]+\z/}
  validates :name_first, presence: true, format:{with: /\A[ぁ-んァ-ヶ一-龥]+\z/ }
  validates :name_first_kana, presence: true, format:{with:  /\A[ァ-ヶー－]+\z/}
  validates :birth_day, presence: true
  validates :password,format:{with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i}

  has_many :items
  has_many :comments
  has_many :purchase_records

end