class SmsService
  def initialize(municipe)
    @municipe = municipe
    @from_number = Rails.application.credentials.twilio.from_number
    account_sid = Rails.application.credentials.twilio.account_sid
    auth_token = Rails.application.credentials.twilio.auth_token
    @client = create_twilio_client(account_sid, auth_token)
  end

  def send(message)
    sms = @client.messages.create(
      body: message,
      from: @from_number,
      to: @municipe.telefone
    )
    sms.sid
  rescue Twilio::REST::RestError => e
    puts e.message
    raise e
  end

  private

  def create_twilio_client(account_sid, auth_token)
    client = Twilio::REST::Client.new(account_sid, auth_token)
    unless Rails.env.production?
      logger = Logger.new($stdout)
      logger.level = Logger::DEBUG
      client.logger = logger
    end
    client
  end
end
