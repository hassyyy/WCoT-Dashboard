class Donation < ActiveRecord::Base
  attr_accessible :resource_id, :value, :description, :bills, :date
  belongs_to :resource

  validates :resource_id, presence: true
  validates :value, presence: true,
                    numericality: {
                                    only_integer: true,
                                    greater_than: 0,
                                    less_than_or_equal_to: 50000
                                  }
  validates :description, presence: true
  validates :bills, presence: true
  validates :date, presence: true

  default_scope order: 'donations.created_at DESC'
end
