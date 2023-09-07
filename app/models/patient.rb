class Patient < ApplicationRecord
  validates :name, presence: true
  validates_format_of :phone, presence: true, :with =>  /\d{10}/, :allow_nil => false, :allow_blank => false, :message => "Only positive number without spaces are allowed"
  validates :token, presence: true, uniqueness: true
  # validates :is_current_token

  scope :current_token, -> { where(:is_current_token => true) }

  def self.change_token_to(patient_id)
    Patient.current_token.update({:is_current_token => false})
    Patient.where("id = ?",patient_id).update({:is_current_token => true})
  end
end 