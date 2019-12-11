FactoryBot.define do
  factory :weapon do
    name { %w[faca machado espada].sample }
    description { FFaker::Lorem.word }
    power_base { FFaker::Random.rand(1..100) }
    power_step { FFaker::Random.rand(10..100) }
    level { FFaker::Random.rand(1..10) }
  end
end