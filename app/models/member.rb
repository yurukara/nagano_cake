class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :cart_items
  has_many :addresses


  validates :last_name, presence:true
  validates :first_name, presence:true
  validates :last_name_kana, presence:true
  validates :first_name_kana, presence:true
  VALID_POSTAL_CODE_REGEX = /\A\d{7}\z/
  validates :postal_code, presence:true, format: { with: VALID_POSTAL_CODE_REGEX }
  validates :address, presence:true
  VALID_PHONE_REGEX = /\A\d{10}$|^\d{11}\z/
  validates :phone_number, presence:true, format: { with: VALID_PHONE_REGEX }

  def active_for_authentication?
    super && (is_deleted == false)
  end
end
