FactoryBot.define do
  factory :sku do
    sku_code { [*('A'..'Z')].sample(8).join }
    price { rand(1..500) }
    supplier

  end
end