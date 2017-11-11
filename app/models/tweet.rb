class Tweet < ApplicationRecord
  belongs_to :user

  validates :message, presence: true
  validates :message, length: {
    maximum: 140,
    too_long: "140 max, yo."
  }

end
