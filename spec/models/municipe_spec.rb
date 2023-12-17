require 'rails_helper'

RSpec.describe Municipe, type: :model do
  describe 'validações' do
    describe 'nome' do
      it 'deve ser obrigatório' do
        valid_name = Faker::Name.name
        [nil, '', ' '].each do |invalid_name|
          municipe = build(:municipe, nome: invalid_name)
          expect(municipe).not_to be_valid
          municipe.nome = valid_name
          expect(municipe).to be_valid
        end
      end

      it 'deve ter pelo menos um sobrenome' do
        municipe = build(:municipe, nome: 'João')
        expect(municipe).not_to be_valid
      end
    end

    describe 'CPF' do
      it 'deve ser obrigatório' do
        valid_cpf = CPF.generate
        [nil, '', ' '].each do |invalid_cpf|
          municipe = build(:municipe, cpf: invalid_cpf)
          expect(municipe).not_to be_valid
          municipe.cpf = valid_cpf
          expect(municipe).to be_valid
        end
      end

      it 'deve ser válido' do
        ['11111111111', 'asasasaq'].each do |invalid_cpf|
          municipe = build(:municipe, cpf: invalid_cpf)
          expect(municipe).not_to be_valid
        end
      end

      it 'deve ser único' do
        cpf = CPF.generate
        create(:municipe, cpf:)
        municipe = build(:municipe, cpf:)
        expect(municipe).not_to be_valid
        municipe.cpf = CPF.generate
        expect(municipe).to be_valid
      end
    end

    describe 'CNS' do
      it 'deve ser obrigatório' do
        valid_cns = '213 2588 7050 0007'
        [nil, '', ' '].each do |invalid_cns|
          municipe = build(:municipe, cns: invalid_cns)
          expect(municipe).not_to be_valid
          municipe.cns = valid_cns
          expect(municipe).to be_valid
        end
      end

      it 'deve ser válido' do
        ['111111111111111', 'asasasaqghdjwud', '301298217730000'].each do |invalid_cns|
          municipe = build(:municipe, cns: invalid_cns)
          expect(municipe).not_to be_valid
        end
      end

      it 'deve ser único' do
        cns = CNS.generate
        create(:municipe, cns:)
        municipe = build(:municipe, cns:)
        expect(municipe).not_to be_valid
        municipe.cns = CNS.generate
        expect(municipe).to be_valid
      end
    end

    describe 'email' do
      it 'deve ser obrigatório' do
        valid_email = Faker::Internet.email(domain: 'example.com')
        [nil, '', ' '].each do |invalid_email|
          municipe = build(:municipe, email: invalid_email)
          expect(municipe).not_to be_valid
          municipe.email = valid_email
          expect(municipe).to be_valid
        end
      end

      it 'deve ser válido' do
        ['abcde@', '@abcde', 'asbcgmail.com', 'email@example', 'email@example.😀'].each do |invalid_email|
          municipe = build(:municipe, email: invalid_email)
          expect(municipe).not_to be_valid
        end
      end
    end

    describe 'data de nascimento' do
      it 'deve ser obrigatória' do
        valid_data_nascimento = Date.current - 20.years
        [nil, ''].each do |invalid_data_nascimento|
          municipe = build(:municipe, data_nascimento: invalid_data_nascimento)
          expect(municipe).not_to be_valid
          municipe.data_nascimento = valid_data_nascimento
          expect(municipe).to be_valid
        end
      end

      it 'deve ser uma data de nascimeto válida' do
        ['1234', Date.tomorrow].each do |invalid_data_nascimento|
          municipe = build(:municipe, data_nascimento: invalid_data_nascimento)
          expect(municipe).not_to be_valid
        end
      end

      it 'idade deve ser entre 0 e 120 anos' do
        municipe = build(:municipe, data_nascimento: Date.current - 121.years)
        expect(municipe).not_to be_valid
      end
    end

    describe 'telefone' do
      it 'deve ser obrigatório' do
        valid_telefone = '+5511912345678'
        [nil, ''].each do |invalid_telefone|
          municipe = build(:municipe, telefone: invalid_telefone)
          expect(municipe).not_to be_valid
          municipe.telefone = valid_telefone
          expect(municipe).to be_valid
        end
      end

      it 'deve ser número válido' do
        ['+55 31 12345678', '912345678', '+999 91273485'].each do |invalid_telefone|
          municipe = build(:municipe, telefone: invalid_telefone)
          expect(municipe).not_to be_valid
        end
      end

      it 'deve aceitar telefones de vários países' do
        ['+55 31 992412430', '+351 912 046 479'].each do |valid_telefone|
          municipe = build(:municipe, telefone: valid_telefone)
          expect(municipe).to be_valid
        end
      end
    end

    describe 'ativo' do
      it 'deve ser obrigatório' do
        [nil, ''].each do |invalid_ativo|
          municipe = build(:municipe, ativo: invalid_ativo)
          expect(municipe).not_to be_valid
          municipe.ativo = false
          expect(municipe).to be_valid
        end
      end
    end

    describe 'endereço' do
      it 'deve ser obrigatório' do
        municipe = build(:municipe, endereco: nil)
        expect(municipe).not_to be_valid
        municipe.endereco = build(:endereco, :without_municipe)
        expect(municipe).to be_valid
      end
    end

    describe 'foto' do
      it 'deve ser obrigatória' do
        municipe = build(:municipe, foto: nil)
        expect(municipe).not_to be_valid
        municipe.foto = Rack::Test::UploadedFile.new('spec/fixtures/test.jpg', 'image/jpeg')
        expect(municipe).to be_valid
      end
    end
  end

  describe 'alterações no registro' do
    include ActiveJob::TestHelper

    describe 'email' do
      it 'deve adicionar um job para enviar um email sempre que um munícipe é criado' do
        assert_enqueued_with(job: ActionMailer::MailDeliveryJob) do
          create(:municipe)
        end
      end

      it 'deve adicionar um job para enviar um email sempre que o status de um munícipe é atualizado' do
        municipe = create(:municipe)
        assert_enqueued_with(job: ActionMailer::MailDeliveryJob) do
          municipe.update(ativo: !municipe.ativo)
        end
      end

      it 'não deve adicionar um job para enviar um email se o status de um munícipe não é atualizado' do
        municipe = create(:municipe)
        assert_no_enqueued_jobs do
          municipe.update(nome: Faker::Name.name)
        end
      end
    end

    describe 'sms' do
      it 'deve adicionar um job para enviar um sms sempre que um munícipe é criado' do
        assert_enqueued_with(job: SendSmsJob) do
          create(:municipe)
        end
      end

      it 'deve adicionar um job para enviar um sms sempre que o status de um munícipe é atualizado' do
        municipe = create(:municipe)
        assert_enqueued_with(job: SendSmsJob) do
          municipe.update(ativo: !municipe.ativo?)
        end
      end

      it 'não deve adicionar um job para enviar um sms se o status de um munícipe não é atualizado' do
        municipe = create(:municipe)
        assert_no_enqueued_jobs do
          municipe.update(nome: Faker::Name.name)
        end
      end
    end
  end

  describe 'apagar registro' do
    it 'deve apagar o endereço associado ao munícipe' do
      municipe = build(:municipe)
      expect { municipe.save }.to change { Municipe.count }.by(1).and change { Endereco.count }.by(1)
      expect { municipe.destroy }.to change { Municipe.count }.by(-1).and change { Endereco.count }.by(-1)
    end
  end
end
