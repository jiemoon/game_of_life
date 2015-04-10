class Game
  def initialize(grid)
    @grid = grid

	init_length
	init_result_grid
  end

  def tick
    #0.upto(@y_length - 1).each do |i|
	@y_length.times do |i|
	  @x_length.times do |j|
	    if alive?(i, j) && has_2_or_3_alive_neighbors?(i, j)
	      set_alive(i, j)
		end
		
		if !alive?(i, j) && has_3_alive_neighbors?(i, j)
		  set_alive(i, j)
		end
	  end
	end

    @next_tick_grid
  end

  def play
	show
	tick
	@grid = @next_tick_grid
  end

  def show
	@grid.length.times do |i|
	  @grid[i].length.times do |j|
	    print @grid[i][j], "\t"
	  end
	  print "\n"
	end
	print "\n"
  end

  private

  def init_result_grid
	#Array.new(@y_length) { [0] }
	@next_tick_grid = @y_length.times.map { [0] * @x_length }
  end

  def init_length
	@y_length = @grid.length
	@x_length = @grid[0].length
  end

  def alive?(i, j)
	@grid[i][j] == 1
  end

  def set_alive(i, j)
	@next_tick_grid[i][j] = 1
  end

  def has_2_or_3_alive_neighbors?(i, j)
	count = count_alive_neighbors(i, j)
	count == 2 || count == 3
  end

  def has_3_alive_neighbors?(i, j)
	count_alive_neighbors(i,j) == 3
  end

  def count_alive_neighbors(i, j)
	count = 0
	count += 1 if left_cell_alive?(i, j)
	count += 1 if right_cell_alive?(i, j)
	count += 1 if up_cell_alive?(i, j)
	count += 1 if down_cell_alive?(i, j)

	count += 1 if left_down_cell_alive?(i, j)
	count += 1 if right_up_cell_alive?(i, j)
	count += 1 if left_up_cell_alive?(i, j)
	count += 1 if right_down_cell_alive?(i, j)

	count
  end

  def left_cell_alive?(i, j)
	j > 0 && alive?(i, j-1)
  end

  def right_cell_alive?(i, j)
	j < @x_length - 1 && alive?(i, j+1)
  end

  def up_cell_alive?(i, j)
	i > 0 && alive?(i-1, j)
  end

  def down_cell_alive?(i, j)
	i < @y_length - 1 && alive?(i+1, j)
  end

  def left_down_cell_alive?(i, j)
	j > 0 && i < @y_length -1 && alive?(i+1, j-1)
  end

  def right_up_cell_alive?(i, j)
	i > 0 && j < @x_length -1 && alive?(i-1, j+1)
  end

  def left_up_cell_alive?(i, j)
	i > 0 && j > 0 && alive?(i-1, j-1)
  end

  def right_down_cell_alive?(i, j)
	i < @y_length - 1 && j < @x_length -1 && alive?(i+1, j+1)
  end
end

init_grid = [[ 0, 1, 0], [ 0, 1, 0], [ 1, 1, 0]]
game = Game.new init_grid

10.times do |i|
	# sleep(1)
	game.play
end
