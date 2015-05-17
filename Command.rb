class Move
	attr_accessor :lines, :score
	def initialize(lines)
		@lines = lines
    @score = 0
	end
  def execute
    lines_check = @lines.flatten
    lines.each do |line|
      move(line)
    end
    add_number if lines_check != @lines.flatten
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

  def add_number
    x = rand(4)
    y = rand(4)
    if @lines[x][y] == nil
      @lines[x][y] = rand > 0.1 ? 2 : 4
    else
      add_number
    end
  end
end

class LeftMove < Move
	def execute
    super
	end
end

class RightMove < Move
	def execute
		@lines.each { |line| line.reverse!}
    super
    @lines.each { |line| line.reverse!}
	end
end

class UpMove < Move
	def execute
    @lines = @lines.transpose
		super
    @lines.transpose
	end
end

class DownMove < RightMove
	def execute()
    @lines = @lines.transpose
    super
    @lines.transpose
	end
end