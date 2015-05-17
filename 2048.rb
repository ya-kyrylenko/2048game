class Board
	attr_accessor :rows, :columns, :grid, :is_victory, :lines_check
	def initialize(rows = 4, columns = 4)
		@rows = rows
		@columns = columns
		# @score = 0
    @is_victory = false
		@grid = Array.new(rows) do |row|
							Array.new(columns) do |column|
								column = nil
		 					end
		 				end
    @lines_check = nil
    2.times { add_number }
	end

  # def left_move(lines)
  #   @lines_check = lines.flatten
  #   lines.each do |line|
  #     move(line)
  #   end
  # end

  # def right_move(lines)
  #   @lines_check = lines.flatten
  #   lines.each do |line|
  #     line.reverse!
  #     move(line)
  #     line.reverse!
  #   end
  # end

  # def up_move(lines)
  #   @grid = left_move(lines.transpose).transpose
  # end

  # def down_move(lines)
  #   @grid = right_move(lines.transpose).transpose
  # end

  # def add_number_if_changed_for_horizontal
  #   add_number if @lines_check != @grid.flatten
  # end

  # def add_number_if_changed_for_vertical
  #   add_number if @lines_check != @grid.transpose.flatten
  # end

  def victory?
    true if @grid.flatten.include?(2048)
  end

  def lose?
    arr = @grid.flatten.select {|value| value.nil?}
    if arr.empty?
      add_counter = 0
      add_counter = method_name(@grid, add_counter)
      add_counter = method_name(@grid.transpose, add_counter)
      if add_counter == 0
        @is_victory = true
        true
      end
    end
  end

  private

  # def move(line)
  #   counter = 0

  #   line.compact!
  #   while counter < 3
  #     if !line[counter].nil? && line[counter] == line[counter+1]
  #       merge(line, counter)
  #     end
  #     counter += 1
  #   end
  #   (4 - line.size).times { line << nil }
  #   line
  # end

  # def merge(line, index)
  #   line[index] *= 2
  #   @score += line[index]
  #   line.delete_at(index+1)
  # end

  def method_name(lines, add_counter)
    lines.each { |line|
      counter = 0
      while counter < 3
         if line[counter] !=nil && line[counter] == line[counter + 1]
           add_counter += 1
         end
        counter += 1
      end
    }
    add_counter
  end

  def add_number
    x = rand(4)
    y = rand(4)
    if @grid[x][y] == nil
      @grid[x][y] = rand > 0.1 ? 2 : 4
    else
      add_number
    end
  end
end