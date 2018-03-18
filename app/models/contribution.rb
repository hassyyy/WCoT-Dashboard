class Contribution < ActiveRecord::Base
  attr_accessible  :value, :month, :year, :status, :mode
  belongs_to :user

  validates :user_id, presence: true
  validates :value, presence: true,
                    numericality: {
                                    only_integer: true,
                                    greater_than: 0,
                                    less_than_or_equal_to: 50000
                                  }
  validates :year, presence: true,
                    numericality: {
                                    only_integer: true,
                                    greater_than: 2016,
                                    lesser_than: Date.today.year
                                  }
  validates :month, presence: true,
                    inclusion: { in: Date::ABBR_MONTHNAMES[1..12] }

  validates :status, presence: true,
                     inclusion: { in: ["submitted", "sent"] }

  default_scope order: 'contributions.created_at DESC'
end
