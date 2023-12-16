FactoryBot.define do
  factory :municipe do
    nome { Faker::Name.name }
    cpf { CPF.generate }
    cns { '101298217730000' }
    email { Faker::Internet.email(domain: 'example.com') }
    data_nascimento { Faker::Date.birthday(min_age: 18, max_age: 65) }
    telefone { '+55 (31) 99241-2430' }
    ativo { true }
  end
end
