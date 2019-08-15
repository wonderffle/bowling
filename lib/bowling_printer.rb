class BowlingPrinter
  def self.print(game)
    printer = FramePrinter.new(game.root)

    result = printer.border
    while printer.next_frame
      printer = printer.next_frame
      result += printer.border
    end
    result += "-\n"

    printer = FramePrinter.new(game.root)
    result += printer.delineator + printer.number
    while printer.next_frame
      printer = printer.next_frame
      result += printer.number
    end
    result += "\n"

    printer = FramePrinter.new(game.root)
    result += printer.border
    while printer.next_frame
      printer = printer.next_frame
      result += printer.border
    end

    result += "-\n"

    printer = FramePrinter.new(game.root)
    result += printer.delineator + printer.rolls
    while printer.next_frame
      printer = printer.next_frame
      result += printer.rolls
    end

    result += "\n"

    printer = FramePrinter.new(game.root)
    result += printer.delineator + printer.spacer
    while printer.next_frame
      printer = printer.next_frame
      result += printer.spacer
    end

    result += "\n"

    printer = FramePrinter.new(game.root)
    total = printer.running_total
    if printer.can_print_running_total?
      result += printer.delineator + total.to_s.center(11) + printer.delineator
    else
      result += printer.delineator + FramePrinter.new(printer.frame).spacer
    end
    while printer.next_frame
      printer = printer.next_frame
      total += printer.running_total
      if printer.can_print_running_total?
        result += total.to_s.center(printer.spacing_width) + printer.delineator
      else
        result += FramePrinter.new(printer.frame).spacer
      end
    end

    result += "\n"

    printer = FramePrinter.new(game.root)
    result += printer.border
    while printer.next_frame
      printer = printer.next_frame
      result += printer.border
    end

    puts result + "-"
  end
end
