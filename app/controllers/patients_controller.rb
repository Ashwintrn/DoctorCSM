class PatientsController < ApplicationController
 
  attr_accessor :curr_token
  before_action :current_token, only: [:next_token]

  def dashboard
    @patients = Patient.order(:token)
  end

  def create
    @patient = Patient.new(patient_params)
    @patient.token = generate_token

    if @patient.save
      session[:current_token] = @patient.token if curr_token.nil?
      redirect_to root_path, notice: 'Patient was successfully added.'
    else
      @patients = Patient.order(:token)
      render :dashboard
    end
  end

  def next_token
    next_patient = Patient.where('token > ?', @curr_token).order(:token).first

    if next_patient
      @curr_token = next_patient.token
    end
    ActionCable.server.broadcast("patient_queue_channel", { token: @curr_token })

    redirect_to root_path, notice: 'Current token: #{token_in_q}'
  end

  def current_token
    current_patient = Patient.find_by(token: @curr_token) unless @curr_token.nil?
    current_patient = Patient.first if current_patient.nil?
    @curr_token = current_patient.token
  end

  private

  def patient_params
    params.permit(:name, :phone)
  end

  def generate_token
    last_patient = Patient.order(token: :desc).first
    if last_patient
      last_token = last_patient.token.match(/T-(\d+)/)[1].to_i
      new_token = "T-#{format('%03d', last_token + 1)}"
    else
      new_token = 'T-101'
    end
    new_token
  end
  
end
