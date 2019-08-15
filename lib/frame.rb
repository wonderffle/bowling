class Frame
  ERROR_MESSAGE = "Cannot roll anything less than zero or greater than 10".freeze

  attr_accessor :number, :first_roll, :second_roll, :final_roll, :next_frame

  def initialize(number, pins=nil)
    @number = number
    @first_roll = pins
  end

  def final_frame?
    number == 10
  end

  def strike_in_final_frame?
    strike? && final_frame?
  end

  def two_strikes_in_final_frame?
    final_frame? && first_roll == 10 && second_roll == 10
  end

  def strike?
    first_roll == 10 && second_roll.nil?
  end

  def spare?
    !!second_roll && first_roll + second_roll == 10
  end

  def spare_in_final_frame?
    spare? && final_frame?
  end

  def roll(pins)
    raise ArgumentError.new(ERROR_MESSAGE) if pins > 10 || pins < 0

    if first_roll.nil?
      self.first_roll = pins
    elsif first_roll < 10 && second_roll.nil?
      raise ArgumentError.new(ERROR_MESSAGE) if first_roll + pins > 10

      self.second_roll = pins
    elsif spare_in_final_frame?
      self.final_roll = pins
    elsif strike_in_final_frame?
      self.second_roll = pins
    elsif final_frame? && first_roll + second_roll > 10 && final_roll.nil?
      self.final_roll = pins
    elsif two_strikes_in_final_frame?
      self.final_roll = pins
    elsif next_frame
      next_frame.roll(pins)
    elsif !final_frame?
      self.next_frame = Frame.new(number+1, pins)
    end
  end

  def running_total
    result = first_roll.to_i + second_roll.to_i
    if strike? && next_frame
      result += next_frame.first_roll + next_frame.second_roll.to_i
      if next_frame.strike? && next_frame.next_frame
        result += next_frame.next_frame.first_roll
      end
    elsif spare? && next_frame
      result += next_frame.first_roll
    elsif final_frame?
      result += final_roll.to_i
    end
    result
  end

  def total
    result = running_total

    if next_frame
      result += next_frame.total
    end

    result
  end
end
