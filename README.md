# Bowling

Go bowling in the Ruby console!

### Getting Started

    bin/console

### Make One Roll At A Time

    b = Bowling.new

    b.roll 7

    -------------
    |     1     |
    -------------
    |  7  |     |
    |           |
    |           |
    -------------

    b.roll 3

    -------------
    |     1     |
    -------------
    |  7  |  /  |
    |           |
    |           |
    -------------

    b.roll 9

    -------------------------
    |     1     |     2     |
    -------------------------
    |  7  |  /  |  9  |     |
    |           |           |
    |    19     |           |
    -------------------------

    b.roll 3

     => "Cannot roll anything less than zero or greater than 10"

    b.roll 0

    -------------------------------------------------------------
    |     1     |     2     |     3     |     4     |     5     |
    -------------------------------------------------------------
    |  7  |  /  |  9  |  0  |     X     |  7  |  /  |  9  |  0  |
    |           |           |           |           |           |
    |    19     |    28     |    48     |    67     |    76     |
    -------------------------------------------------------------

    b.roll 10

    -------------------------------------------------------------------------
    |     1     |     2     |     3     |     4     |     5     |     6     |
    -------------------------------------------------------------------------
    |  7  |  /  |  9  |  0  |     X     |  7  |  /  |  9  |  0  |     X     |
    |           |           |           |           |           |           |
    |    19     |    28     |    48     |    67     |    76     |           |
    -------------------------------------------------------------------------

### Make Multiple Rolls at a Time

    b = Bowling.new 8, 2, 10, 10, 5, 5, 6, 4, 7, 3, 9, 1, 8, 1, 10
    
    -------------------------------------------------------------------------------------------------------------
    |     1     |     2     |     3     |     4     |     5     |     6     |     7     |     8     |     9     |
    -------------------------------------------------------------------------------------------------------------
    |  8  |  /  |     X     |     X     |  5  |  /  |  6  |  /  |  7  |  /  |  9  |  /  |  8  |  1  |     X     |
    |           |           |           |           |           |           |           |           |           |
    |    20     |    45     |    65     |    81     |    98     |    117    |    135    |    144    |           |
    -------------------------------------------------------------------------------------------------------------

    b.roll 6, 3

    -----------------------------------------------------------------------------------------------------------------------------
    |     1     |     2     |     3     |     4     |     5     |     6     |     7     |     8     |     9     |      10       |
    -----------------------------------------------------------------------------------------------------------------------------
    |  8  |  /  |     X     |     X     |  5  |  /  |  6  |  /  |  7  |  /  |  9  |  /  |  8  |  1  |     X     |   6   |   3   |
    |           |           |           |           |           |           |           |           |           |               |
    |    20     |    45     |    65     |    81     |    98     |    117    |    135    |    144    |    163    |      172      |
    -----------------------------------------------------------------------------------------------------------------------------

Happy Bowling!
