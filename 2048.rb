class Board
	attr_accessor :rows, :columns, :grid, :score
	def initialize(rows = 4, columns = 4)
		@rows = rows
		@columns = columns
		@score = 0
		@grid = Array.new(rows) do |row|
							Array.new(columns) do |column|
								column = nil
		 					end
		 				end
	end

  def left_all(lines)
    lines_check = lines.flatten
    lines.each do |line|
      move(line)
    end
    add_value(lines) if lines_check != lines.flatten
  end

  def add_value(lines)
    x = rand(4)
    y = rand(4)
    if lines[x][y] == nil
      lines[x][y] = rand > 0.1 ? 2 : 4
    else
      add_value(lines)
    end
  end

  def end_game(lines)
    lines.dup
  end

  def right_all(lines)
    lines_check = lines.flatten
    lines.each do |line|
      line.reverse!
      move(line)
      line.reverse!
    end
    add_value(lines) if lines_check != lines.flatten
  end

  def up_all(lines)
    transposed_lines = lines.transpose
    left_all(transposed_lines)
    transposed_lines.transpose
  end

  def down_all(lines)
    transposed_lines = lines.transpose
    right_all(transposed_lines)
    transposed_lines.transpose
  end

  private

  def move(line)
    counter = 0

    line.compact!
    while counter < 3
      if !line[counter].nil? && line[counter] == line[counter+1]
        merge(line, counter)
      end
      counter += 1
    end
    (4 - line.size).times { line << nil }
    line
  end

  def merge(line, index)
    line[index] *= 2
    @score += line[index]
    line.delete_at(index+1)
  end
end