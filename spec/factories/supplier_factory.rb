FactoryBot.define do
  factory :supplier do
    supplier_code { [*('A'..'Z')].sample(8).join }
    name { [*('A'..'Z')].sample(8).join }
  end
end