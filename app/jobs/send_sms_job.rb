class SendSmsJob < ApplicationJob
  queue_as :default

  def perform(municipe_id, message)
    municipe = Municipe.find(municipe_id)
    SmsService.new(municipe).send(message)
  end
end
