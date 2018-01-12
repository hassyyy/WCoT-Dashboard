class Resource < ActiveRecord::Base
  attr_accessible :name, :address, :contact_details, :other_details
  has_many :donations, dependent: :destroy

  validates :name, presence: true
  validate :presence_of_address_or_contact

  private
    def presence_of_address_or_contact
      if address.blank? && contact_details.blank?
        errors[:base] << "Both address and contact details cannot be blank. Specify at least one"
      end
    end
end
