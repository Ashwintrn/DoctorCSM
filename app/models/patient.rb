class Patient < ApplicationRecord
  validates :name, presence: true
  validates_format_of :phone, presence: true, :with =>  /\d{10}/, :allow_nil => false, :allow_blank => false, :message => "Only positive number without spaces are allowed"
  validates :token, presence: true, uniqueness: true
end 