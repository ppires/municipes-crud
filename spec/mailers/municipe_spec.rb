require 'rails_helper'

RSpec.describe MunicipeMailer, type: :mailer do
  describe 'new_registration' do
    let(:municipe) { create(:municipe) }
    let(:mail) { MunicipeMailer.with(municipe:).new_registration }

    it 'renderiza os cabeçalhos' do
      expect(mail.subject).to eq('Suas informações foram cadastradas')
      expect(mail.to).to eq([municipe.email])
      expect(mail.from).to eq(['no-reply@municipes-crud.example.com'])
    end

    it 'renderiza mensagem inicial correta' do
      body_content = 'Foi feito um novo registro de munícipe em seu nome na plataforma Munícipe CRUD.'
      expect(mail.body.encoded).to match(body_content)
    end

    it 'renderiza uma lista com todos os atributos do munícipe' do
      municipe.attributes.reject_keys('id', 'telefone', 'created_at', 'updated_at').each do |attribute, value|
        expect(mail.body.encoded).to match("#{attribute}: #{value}")
      end
    end
  end

  describe 'status_updated' do
    before(:all) do
      create(:municipe, nome: 'Nome Inicial')
    end

    let(:municipe) do
      municipe = Municipe.last
      municipe.update(ativo: !municipe.ativo?)
      municipe
    end
    let(:saved_changes) { municipe.saved_changes[:ativo] }
    let(:mail) { MunicipeMailer.with(municipe:, saved_changes:).status_updated }

    it 'renderiza os cabeçalhos' do
      expect(mail.subject).to eq("Seu cadastro foi #{saved_changes.last ? 'ativado' : 'desativado'}")
      expect(mail.to).to eq([municipe.email])
      expect(mail.from).to eq(['no-reply@municipes-crud.example.com'])
    end

    it 'renderiza mensagem inicial correta' do
      body_content = "Seu cadastro foi #{saved_changes.last ? 'ativado' : 'desativado'} na plataforma Munícipe CRUD."
      expect(mail.body.encoded).to match(body_content)
    end
  end
end
