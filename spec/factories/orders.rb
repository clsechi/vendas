FactoryBot.define do
  factory :order do
    creation_date '2018-01-30'
    status 'MyString'
    seller 'MyString'
    customer nil
    product 'MyString'
  end
end
