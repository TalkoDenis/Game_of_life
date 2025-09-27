class GameOfLife
  def initialize(rows, cols)
    @rows = rows
    @cols = cols
    @grid = Array.new(rows) { Array.new(cols) { rand(2) } }
  end

  def neighbors(x, y)
    deltas = [-1, 0, 1]
    deltas.product(deltas)
          .reject { |dx, dy| dx == 0 && dy == 0 }
          .count do |dx, dy|
      nx, ny = x + dx, y + dy
      nx.between?(0, @rows - 1) && ny.between?(0, @cols - 1) && @grid[nx][ny] == 1
    end
  end

  def step
    new_grid = Array.new(@rows) { Array.new(@cols, 0) }

    @rows.times do |x|
      @cols.times do |y|
        alive = @grid[x][y] == 1
        count = neighbors(x, y)

        if alive && (count == 2 || count == 3)
          new_grid[x][y] = 1
        elsif !alive && count == 3
          new_grid[x][y] = 1
        end
      end
    end

    @grid = new_grid
  end

  def display
    system("clear") || system("cls")
    @grid.each do |row|
      puts row.map { |cell| cell == 1 ? "⬛" : "⬜" }.join
    end
  end

  def run(generations, delay = 0.3)
    generations.times do
      display
      step
      sleep delay
    end
  end
end
