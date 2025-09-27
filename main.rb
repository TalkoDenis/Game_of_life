require_relative "scr/gol"

game = GameOfLife.new(20, 40)
game.run(10, 0.2)
