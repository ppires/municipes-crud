require 'rails_helper'

RSpec.describe SendSmsJob, type: :job do
  include ActiveJob::TestHelper

  describe '#perform' do
    describe 'quando o munícipe não existe' do
      it 'deve lançar uma exceção' do
        perform_enqueued_jobs do
          expect { SendSmsJob.perform_later(0, 'message') }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    describe 'quando o munícipe existe' do
      let(:sms_service) { instance_double(SmsService) }
      let(:municipe) { instance_double(Municipe) }
      let(:municipe_id) { 1 }
      let(:message) { 'message' }

      before(:each) do
        allow(Municipe).to receive(:find).with(municipe_id).and_return(municipe)
      end

      it 'deve enviar um SMS usando o service SmsService' do
        perform_enqueued_jobs do
          expect(SmsService).to receive(:new).with(municipe).and_return(sms_service)
          expect(sms_service).to receive(:send).with(message)
          SendSmsJob.perform_later(municipe_id, message)
        end
      end
    end
  end
end
