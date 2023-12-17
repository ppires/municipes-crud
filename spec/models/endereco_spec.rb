require 'rails_helper'

RSpec.describe Endereco, type: :model do
  describe 'validações' do
    describe 'cep' do
      it 'deve ser obrigatório' do
        [nil, ''].each do |invalid_cep|
          endereco = build(:endereco, cep: invalid_cep)
          expect(endereco).not_to be_valid
        end
      end

      it 'deve conter 8 algarismos' do
        ['1234567', '123456789'].each do |invalid_cep|
          endereco = build(:endereco, cep: invalid_cep)
          expect(endereco).not_to be_valid
        end
      end
    end

    describe 'numero' do
      it 'deve ser obrigatório' do
        [nil, ''].each do |invalid_numero|
          endereco = build(:endereco, cep: invalid_numero)
          expect(endereco).not_to be_valid
        end
      end
    end

    describe 'logradouro' do
      it 'deve ser obrigatório' do
        [nil, ''].each do |invalid_logradouro|
          endereco = build(:endereco, logradouro: invalid_logradouro)
          expect(endereco).not_to be_valid
        end
      end
    end

    describe 'bairro' do
      it 'deve ser obrigatório' do
        [nil, ''].each do |invalid_bairro|
          endereco = build(:endereco, bairro: invalid_bairro)
          expect(endereco).not_to be_valid
        end
      end
    end

    describe 'cidade' do
      it 'deve ser obrigatório' do
        [nil, ''].each do |invalid_cidade|
          endereco = build(:endereco, cidade: invalid_cidade)
          expect(endereco).not_to be_valid
        end
      end
    end

    describe 'uf' do
      it 'deve ser obrigatório' do
        [nil, ''].each do |invalid_uf|
          endereco = build(:endereco, uf: invalid_uf)
          expect(endereco).not_to be_valid
        end
      end

      it 'deve conter 2 letras' do
        ['abc', 'x'].each do |invalid_uf|
          endereco = build(:endereco, uf: invalid_uf)
          expect(endereco).not_to be_valid
        end
      end
    end

    describe 'municipe' do
      it 'deve ser obrigatório' do
        endereco = build(:endereco, :without_municipe)
        expect(endereco).not_to be_valid
        endereco = build(:endereco)
        expect(endereco).to be_valid
      end
    end
  end

  describe 'transformações' do
    describe 'cep' do
      it 'remove todos os caracteres não numéricos antes de salvar' do
        endereco = build(:endereco, cep: '1x2d3g4 5 6 7f8 j jk')
        expect(endereco).to be_valid
        expect(endereco.cep).to eq('12345678')
      end
    end

    describe 'uf' do
      it 'transforma os caracteres em letras maiúsculas antes de salvar' do
        endereco = build(:endereco, uf: 'ba')
        expect(endereco).to be_valid
        expect(endereco.uf).to eq('BA')
      end
    end
  end
end
