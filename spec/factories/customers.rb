FactoryBot.define do
  factory :customer do
    name 'MyString'
    address 'MyString'
    email 'MyString'

    trait :legal do
      cpf 'MyString'
      phone 'MyString'
      birth_date '2018-01-30'
    end

    trait :company do
      cnpj 'MyString'
      company_name 'MyString'
      contact 'MyString'
    end
  end
end
