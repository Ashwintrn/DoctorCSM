class PatientQueueChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'patient_queue_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
