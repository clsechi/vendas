FactoryBot.define do
  factory :customer do
    name 'Lucca'
    address 'MyString'
    email '123@teste.com'

    trait :legal do
      cpf '987.952.930-86'
      phone 'MyString'
      birth_date '2018-01-30'
    end

    trait :company do
      cnpj '38.195.177/0001-63'
      company_name 'MyString'
      contact 'MyString'
    end
  end
end
