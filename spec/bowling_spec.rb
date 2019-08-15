require 'spec_helper'

RSpec.describe Bowling do
  let(:game) { Bowling.new }

  it 'accepts an array of rolls' do
    game = Bowling.new 8,2,10,10,5,5,6,4,7,3,9,1,8,1,10,6,3

    expect(game.score).to eq(172)
    expect(game.frame.number).to eq(10)
  end

  it 'calculates a perfect game' do
    game = Bowling.new *21.times.map{ 10 }

    expect(game.score).to eq(300)
  end

  it 'calculates a game of zero' do
    game = Bowling.new *20.times.map{ 0 }

    expect(game.score).to eq(0)
  end

  it 'accepts multiple rolls at a time' do
    game.roll 8,2,10,5,3

    expect(game.score).to eq(46)
    expect(game.frame.number).to eq(3)
  end

  it 'declares a strike on the first roll of a frame' do
    game.roll 10

    expect(game.frame.strike?).to be(true)
  end

  it 'declares a spare on the 2nd roll of a frame' do
    game.roll 6
    game.roll 4

    expect(game.frame.spare?).to be(true)
    expect(game.frame.strike?).to be(false)
  end

  it 'fails if a roll is greater than 10' do
    expect(game.roll(12)).to eq(Frame::ERROR_MESSAGE)
  end

  it 'fails if a roll is less than 0' do
    expect(game.roll(-4)).to eq(Frame::ERROR_MESSAGE)
  end

  it 'accepts no further rolls after the last frame' do
    game = Bowling.new 8,2,10,10,5,5,6,4,7,3,9,1,8,1,10,6,3

    expect(game.score).to eq(172)
    expect(game.frame.final_frame?).to eq(true)

    game.roll(4)

    expect(game.score).to eq(172)
    expect(game.frame.final_frame?).to eq(true)

    game.roll(6)

    expect(game.score).to eq(172)
    expect(game.frame.final_frame?).to eq(true)
  end
end
