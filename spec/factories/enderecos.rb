FactoryBot.define do
  factory :endereco do
    association :municipe
    cep { '30220000' }
    logradouro { 'Rua do Ouro' }
    numero { '457' }
    bairro { 'Serra' }
    cidade { 'Belo Horizonte' }
    uf { 'MG' }
  end
end
