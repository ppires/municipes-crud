FactoryBot.define do
  factory :endereco do
    association :municipe
    cep { Faker::Address.zip_code }
    logradouro { Faker::Address.street_name }
    numero { Faker::Address.building_number }
    complemento { (rand * 10).floor < 5 ? Faker::Address.secondary_address : nil }
    bairro { Faker::Address.community }
    cidade { Faker::Address.city }
    uf { Faker::Address.state_abbr }
    skip_create
    trait :without_municipe do
      association :municipe, strategy: :null
    end
  end
end
