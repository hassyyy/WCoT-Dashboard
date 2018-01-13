# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :phone, :password, :password_confirmation, :avatar
  has_secure_password
  has_many :contributions, dependent: :destroy
  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>' },
    default_url: '/assets/Profile.png'


  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  after_validation { self.errors.messages.delete(:password_digest) }

  VALID_EMAIL_REGEX = /\A[\w+\.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :name, presence: true,
                   length: { minimum: 3, maximum: 50 }
  validates :phone, length: { is: 10, message: "number should be 10 digits" },
                    numericality: { only_integer: true }
  validates :password, presence: true,
                       length: { minimum: 8 },
                       on: :create
  validates :password_confirmation, presence: true,
                                    on: :create
  validates_attachment :avatar, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
