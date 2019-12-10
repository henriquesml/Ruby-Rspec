require 'rails_helper'

RSpec.describe Weapon, type: :model do
  it "generate weapon level valid" do

    # Gerando Weapon valida
    name = %i[faca machado espada].sample
    description = FFaker::Lorem.word
    power_base = FFaker::Random.rand(1..100) 
    power_step = FFaker::Random.rand(10..100) 
    level = FFaker::Random.rand(1..10) 

    weapon = create(:weapon, name: name, description: description, power_base: power_base, power_step: power_step, level: level )
    
    # Validando level
    expect(weapon.current_power).to eq("#{power_base + ((level - 1) * power_step )}")

  end

  it "generate weapon title valid" do

    # Gerando Weapon valida
    name = %i[faca machado espada].sample
    description = FFaker::Lorem.word
    power_base = FFaker::Random.rand(1..100) 
    power_step = FFaker::Random.rand(10..100) 
    level = FFaker::Random.rand(1..10) 

    weapon = create(:weapon, name: name, description: description, power_base: power_base, power_step: power_step, level: level )

    # Validando titulo
    expect(weapon.title).to eq("#{name} ##{level}")

  end

end
