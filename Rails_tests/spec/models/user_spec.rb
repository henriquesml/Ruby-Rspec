require 'rails_helper'

RSpec.describe User, type: :model do
  it "is invalid if the level is not between 1 and 99" do

    # Gerando um um User com level maior que o permitido
    user = build(:user, level: FFaker::Random.rand(100..9999))
    expect(user).to_not be_valid
  end

  it "return the correct hero title" do
    nickname = FFaker::Name.first_name
    kind = %i[knight wizard].sample
    level = FFaker::Random.rand(1..99)

    user = create(:user, nickname: nickname, kind: kind, level: level )
    expect(user.title).to eq("#{kind} #{nickname} ##{level}")

  end

end

=begin

# TESTE SEM FACTORY_BOT

RSpec.describe User, type: :model do
  it "is invalid if the level is not between 1 and 99" do
    nickname = FFaker::Name.first_name
    kind = %i[knight wizard].sample
    level = FFaker::Random.rand(100..9999)
    user = User.new(nickname: nickname, kind: kind, level: level )

    expect(user).to_not be_valid
  end

  it "return the correct hero title" do
    nickname = FFaker::Name.first_name
    kind = %i[knight wizard].sample
    level = FFaker::Random.rand(1..99)

    user = User.new(nickname: nickname, kind: kind, level: level )
    expect(user.title).to eq("#{kind} #{nickname} ##{level}")

  end

end
  
=end