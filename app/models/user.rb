class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :name_family, presence: true
  validates :name_family_kana, presence: true
  validates :name_first, presence: true
  validates :name_first_kana, presence: true
  validates :birth_day, presence: true

  has_many :items
  has_many :comments
  has_many :purchase_records

end
