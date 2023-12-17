FactoryBot.define do
  factory :municipe do
    nome { Faker::Name.name }
    cpf { CPF.generate }
    cns { CNS.generate }
    email { Faker::Internet.email(domain: 'example.com') }
    data_nascimento { Faker::Date.birthday(min_age: 18, max_age: 65) }
    telefone { '+55 (31) 99241-2430' }
    ativo { true }
    foto { Rack::Test::UploadedFile.new('spec/fixtures/test.jpg', 'image/jpeg') }
    association :endereco, :without_municipe

    trait :without_foto do
      foto { nil }
    end
  end
end
