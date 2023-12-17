require 'rails_helper'

RSpec.describe SmsService, type: :service do
  describe 'enviando um SMS utilizando o cliente do Twilio' do
    let(:account_sid) { 'abc' }
    let(:auth_token) { '123' }
    let(:twilio_client) { instance_double(Twilio::REST::Client) }
    let(:from_number) { '987654321' }
    let(:telefone) { '123456789' }
    let(:message) { 'message' }
    let(:municipe) { build(:municipe, telefone:) }
    let(:sms) { double('sms', sid: 'xxx') }

    before(:each) do
      allow(Rails.application.credentials).to receive_message_chain(:twilio, :account_sid).and_return(account_sid)
      allow(Rails.application.credentials).to receive_message_chain(:twilio, :auth_token).and_return(auth_token)
      allow(Rails.application.credentials).to receive_message_chain(:twilio, :from_number).and_return(from_number)
    end

    it 'deve fazer uma chamada HTTP para enviar o SMS' do
      allow(twilio_client).to receive(:logger=)
      expect(Twilio::REST::Client).to receive(:new).with(account_sid, auth_token).and_return(twilio_client)
      sms_params = { body: message, from: from_number, to: telefone }
      expect(twilio_client).to receive_message_chain(:messages, :create).with(sms_params) { sms }
      SmsService.new(municipe).send(message)
    end

    describe 'quando não está em ambiente de produção' do
      let(:logger) { instance_double(Logger) }

      it 'deve ativar logger de debug' do
        allow(Rails.env).to receive(:production?).and_return(false)
        expect(Twilio::REST::Client).to receive(:new).with(account_sid, auth_token).and_return(twilio_client)
        allow(twilio_client).to receive_message_chain(:messages, :create) { sms }
        expect(Logger).to receive(:new).with($stdout).and_return(logger)
        expect(logger).to receive(:level=).with(Logger::DEBUG)
        expect(twilio_client).to receive(:logger=).with(logger)
        SmsService.new(municipe).send(message)
      end
    end

    describe 'quando está em ambiente de produção' do
      it 'não deve ativar logger de debug' do
        allow(Rails.env).to receive(:production?).and_return(true)
        expect(Twilio::REST::Client).to receive(:new).with(account_sid, auth_token).and_return(twilio_client)
        allow(twilio_client).to receive_message_chain(:messages, :create) { sms }
        expect(twilio_client).not_to receive(:logger=)
        SmsService.new(municipe).send(message)
      end
    end
  end
end
