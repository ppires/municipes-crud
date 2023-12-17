require 'rails_helper'

RSpec.describe Municipe, type: :model do
  describe 'validações' do
    describe 'nome' do
      it 'deve ser obrigatório' do
        [nil, '', ' '].each do |invalid_name|
          municipe = build(:municipe, nome: invalid_name)
          expect(municipe).not_to be_valid
        end
      end

      it 'deve ter pelo menos um sobrenome' do
        municipe = build(:municipe, nome: 'João')
        expect(municipe).not_to be_valid
      end
    end

    describe 'CPF' do
      it 'deve ser obrigatório' do
        [nil, '', ' '].each do |invalid_cpf|
          municipe = build(:municipe, cpf: invalid_cpf)
          expect(municipe).not_to be_valid
        end
      end

      it 'deve ser válido' do
        ['11111111111', 'asasasaq'].each do |invalid_cpf|
          municipe = build(:municipe, cpf: invalid_cpf)
          expect(municipe).not_to be_valid
        end
      end
    end

    describe 'CNS' do
      it 'deve ser obrigatório' do
        [nil, '', ' '].each do |invalid_cns|
          municipe = build(:municipe, cns: invalid_cns)
          expect(municipe).not_to be_valid
        end
      end

      it 'deve ser válido' do
        ['111111111111111', 'asasasaqghdjwud', '301298217730000'].each do |invalid_cns|
          municipe = build(:municipe, cns: invalid_cns)
          expect(municipe).not_to be_valid
        end
      end
    end

    describe 'email' do
      it 'deve ser obrigatório' do
        [nil, '', ' '].each do |invalid_email|
          municipe = build(:municipe, email: invalid_email)
          expect(municipe).not_to be_valid
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
        [nil, ''].each do |invalid_data_nascimento|
          municipe = build(:municipe, data_nascimento: invalid_data_nascimento)
          expect(municipe).not_to be_valid
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
        [nil, ''].each do |invalid_telefone|
          municipe = build(:municipe, telefone: invalid_telefone)
          expect(municipe).not_to be_valid
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
        end
      end
    end
  end

  describe 'alterações no registro' do
    it 'deve enviar um email sempre que um munícipe é criado' do
      expect { create(:municipe) }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'deve enviar um email sempre que um munícipe é atualizado' do
      municipe = create(:municipe)
      expect { municipe.update(nome: Faker::Name.name) }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
