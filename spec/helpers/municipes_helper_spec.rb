require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the MunicipesHelper. For example:
#
# describe MunicipesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe MunicipesHelper, type: :helper do
  describe 'municipe_ativo' do
    it 'deve retornar ativo quando municipe está ativo' do
      municipe = build(:municipe, ativo: true)
      expect(helper.municipe_ativo(municipe)).to eq('ativo')
    end

    it 'deve retornar inativo quando municipe está inativo' do
      municipe = build(:municipe, ativo: false)
      expect(helper.municipe_ativo(municipe)).to eq('inativo')
    end
  end

  describe 'data_nascimento' do
    it 'deve formatar uam no formato mes/dia/ano' do
      municipe = build(:municipe, data_nascimento: Date.new(1999, 4, 23))
      expect(helper.data_nascimento(municipe)).to eq('23/04/1999')
    end
  end

  describe 'radio_ativos_checked?' do
    it 'deve retornar true se o param for o mesmo do radio button' do
      expect(helper.radio_ativos_checked?('ativo', 'ativo')).to eq(true)
    end

    it 'deve retornar false se o param for diferente do radio button' do
      expect(helper.radio_ativos_checked?('inativo', 'ativo')).to eq(false)
    end

    it 'deve retornar true se o param estiver vazio e o radio button for todos' do
      expect(helper.radio_ativos_checked?('todos', nil)).to eq(true)
    end
  end
end
