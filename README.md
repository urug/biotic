## Biotic: a multi-player version of Conway's game of life

### Terms

    biotic
      A word that sounds cool
      The condition of living organisms
      The the study of organisms
      All the interacting organisms living together in a specific habitat

    morphogen
      A word that sounds cool
      A substance that causes an organism to develop its shape

### Rules for Conway's game of life

    1. Any live cell with fewer than two live neighbors dies, as if by under population.
    2. Any live cell with two or three live neighbors lives on to the next generation.
    3. Any live cell with more than three live neighbors dies, as if by overpopulation.
    4. Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.

### Biotic rule variations

    1. A live cell with exactly two neighbors of the same type becomes that type.
    2. A dead cell with exactly three live neighbors becomes a live cell of the majority type. If there is no majority it does not come to life.

### Installation

This simulator requires simple2D to run. Installation details can be found [here](http://www.ruby2d.com/learn/get-started/).

#### MacOS

    brew tap simple2d/tap
    brew install simple2d

#### Linux

    url='https://raw.githubusercontent.com/simple2d/simple2d/master/bin/simple2d.sh'; which curl > /dev/null && cmd='curl -fsSL' || cmd='wget -qO -'; bash <($cmd $url) install

#### Windows

[Full instructions](http://www.ruby2d.com/learn/windows/)

Clone the repo

    git clone git@github.com:urug/biotic.git

Then

    cd biotic
    bundle install

### Playground

    ruby playground.rb

This is a testing ground for strategies. Left-click to place green player cells.
Right-click to place orange player cells. Press space bar to pause/continue.
Press 'c' to clear all of the cells.

### Execution

    ruby app.rb

### Creating your own "Morphogen"

Create a new class in the "morphogens" directory. Include the "Morphogen" module (see
other morphogen classes for examples). Define your own `color`, `seed`, and `moves`
methods. The `color` should return a hex color string. The `seed` should return an array
with 8 strings of length 8 with 'X' for live cells and ' ' for dead cells (this will be
your start). The `moves` takes an instance of `WorldState` and should return an array of
two positions where you want to make your moves.
