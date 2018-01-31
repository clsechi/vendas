FactoryBot.define do
  factory :order do
    status "MyString"
    seller nil
    customer nil
    product_id 1
  end
end
