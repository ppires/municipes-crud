FactoryBot.define do
  factory :endereco do
    association :municipe
    cep { '30220000' }
    logradouro { 'Rua do Ouro' }
    numero { '457' }
    bairro { 'Serra' }
    cidade { 'Belo Horizonte' }
    uf { 'MG' }
    skip_create
    trait :without_municipe do
      association :municipe, strategy: :null
    end
  end
end
