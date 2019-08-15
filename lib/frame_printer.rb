class FramePrinter
  attr_reader :frame

  def initialize(frame)
    @frame = frame
  end

  def next_frame
    if frame.next_frame
      return FramePrinter.new(frame.next_frame)
    end
  end

  def running_total
    frame.running_total
  end

  def first_roll_display
    frame.first_roll == 10 ? "X" : frame.first_roll
  end

  def second_roll_display
    frame.second_roll == 10 ? "X" : (frame.first_roll + frame.second_roll == 10 ? "/" : frame.second_roll)
  end

  def final_roll_display
    frame.final_roll == 10 ? "X " : (frame.second_roll + frame.final_roll == 10 ? "/ " : frame.final_roll)
  end

  def delineator
    "|"
  end

  def spacing_width
    frame.final_frame? ? 15 : 11
  end

  def half_spacing_width
    spacing_width/2
  end

  def third_spacing_width
    4
  end

  def number
    frame.number.to_s.center(spacing_width) + delineator
  end

  def border
    frame.final_frame? ? "----------------" : "------------"
  end

  def spacer
    " ".center(spacing_width) + delineator
  end

  def can_print_running_total?
    not_spare_or_strike? || next_roll_after_spare_complete? || spare_on_last_frame? ||
      strike_followed_by_two_rolls_in_next_frame? || strike_followed_by_a_strike_and_roll? ||
      !frame.final_roll.nil?
  end

  def rolls
    result = ""

    if frame.final_roll.nil?
      result += if frame.strike? || frame.strike_in_final_frame?
                  "X".center(spacing_width)
                elsif frame.two_strikes_in_final_frame?
                  "X".center(half_spacing_width) + delineator + "X".center(half_spacing_width)
                elsif frame.spare? || frame.spare_in_final_frame?
                  "#{frame.first_roll}".center(half_spacing_width) + delineator + "/".center(half_spacing_width)
                else
                  "#{frame.first_roll}".center(half_spacing_width) + delineator + "#{frame.second_roll}".center(half_spacing_width)
                end
    else
      result += " " + "#{first_roll_display}".center(third_spacing_width) +
        delineator + "#{second_roll_display}".center(third_spacing_width) +
        delineator + "#{final_roll_display}".center(third_spacing_width)
    end

    result += delineator
  end

  private

    def not_spare_or_strike?
      !!frame.second_roll && frame.first_roll.to_i + frame.second_roll.to_i < 10
    end

    def next_roll_after_spare_complete?
      frame.spare? && frame.next_frame
    end

    def spare_on_last_frame?
      frame.spare? && frame.number == 10
    end

    def strike_followed_by_two_rolls_in_next_frame?
      frame.strike? && frame.next_frame &&
        frame.next_frame.first_roll && frame.next_frame.second_roll
    end

    def strike_followed_by_a_strike_and_roll?
      frame.strike? && frame.next_frame && frame.next_frame.next_frame
    end
end
