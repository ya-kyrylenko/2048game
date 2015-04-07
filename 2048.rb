class Board
	attr_accessor :rows, :columns, :grid, :cells
	def initialize(rows = 4, columns = 4)
		@rows = rows
		@columns = columns
		@cells = []
		@grid = Array.new(rows) do |row|
							Array.new(columns) do |column|
								cell = Cell.new(column, row)
								cells << cell
								cell
		 					end
		 				end
		@cells.each do |cell|
			cell.value = rand > 0.4 ? 2 : nil
		end
	end

	def left(row)

	  counter = 0
	  while counter < 3
	    if !row[counter].nil? && row[counter] == row[counter+1]
	      row = merge(row, counter)
	    end
	    counter += 1
	  end

	  (row.compact + Array.new(4))[0..3]

	end


	def merge(row, index)
	  row[index] *= 2
		row.delete_at(index+1)
	  row
	end

	# def rewrite
	# left(row).each do |row|
	#   row.each do |element|
	#     sell.x.value = element
	# 		end
	# 	end
	# end

	def all_nil_cell
		cells.select { |cell| cell.nil?}
	end
	# def rand_value
	# 	all_nil_cell.sample =
	# end
	# def randomly_recovery
	# 	cells.each do |cell|
	# 		cell.alive =  rand > 0.6 ? 2 : false
	# 	end
	# end
end


class Cell
	attr_accessor :value, :x, :y
	def initialize(x = 0, y = 0)
		@x = x
		@y = y
		@value = nil
	end
end


class LogicGame
	attr_accessor :board, :fortestcells
	def initialize(board = Board.new, fortestcells = [])
		@board = board
	end
end