require File.join(File.expand_path("frame", File.dirname(__FILE__)))
require File.join(File.expand_path("bowling_printer", File.dirname(__FILE__)))
require File.join(File.expand_path("frame_printer", File.dirname(__FILE__)))

class Bowling
  attr_reader :root

  def initialize(*rolls)
    @root = Frame.new(1)
    roll(*rolls)
  end

  def roll(*rolls)
    rolls.each { |pins| root.roll(pins) }
    print if rolls.any?
  rescue => e
    e.message
  end

  def score
    root.total
  end

  def frame
    frame = root
    while frame.next_frame do
      frame = frame.next_frame
    end

    frame
  end

  def print
    BowlingPrinter.print(self)
  end
end
