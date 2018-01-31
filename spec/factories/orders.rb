FactoryBot.define do
  factory :order do
    creation_date '2018-01-30'
    status 'MyString'
    customer nil
    product 'MyString'
    seller
  end
end
