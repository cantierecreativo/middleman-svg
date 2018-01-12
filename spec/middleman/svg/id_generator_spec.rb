require_relative '../../../lib/middleman/svg/id_generator'

describe Middleman::Svg::IdGenerator do
  it "generates a hexencoded ID based on a salt and a random value" do
    randomizer = -> { "some-random-value" }

    expect(Middleman::Svg::IdGenerator.generate("some-base", "some-salt", randomness: randomizer)).
      to eq("t2c17mkqnvopy36iccxspura7wnreqf")
  end
end
