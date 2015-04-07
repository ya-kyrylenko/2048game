require 'gosu'
require_relative '2048.rb'

class GameWindow < Gosu::Window
  def initialize(height=420, width=420)
    @height = height
    @width = width
    super(height, width, false)
    self.caption = "2048     (¬_¬) press Escape to exit ^~^"

    @background = Gosu::Color.new(0xffbbf6e2)
    @color2 = Gosu::Color.new(0xffb6e3f0)
    @color4 = Gosu::Color.new(0xff96d7ea)
    @color8 = Gosu::Color.new(0xff75cae3)
    @color16 = Gosu::Color.new(0xff54bedd)
    @color32 = Gosu::Color.new(0xff34b1d6)
    @color64 = Gosu::Color.new(0xff269bbc)
    @color128 = Gosu::Color.new(0xff238dac)
    @color256 = Gosu::Color.new(0xff1f809c)
    @color512 = Gosu::Color.new(0xff1c728b)
    @color1024 = Gosu::Color.new(0xff19657b)
    @color2048 = Gosu::Color.new(0xff124a5a)
    @free = Gosu::Color.new(0xffe7f6fa)
    @dead_color = Gosu::Color.new(0xffffffff)
    @columns = width/100
    @rows = height/100
    @column_w = width/@columns
    @row_h = height/@rows
    @board = Board.new(@columns, @rows)
    @game = LogicGame.new(@board)
    # @game.board.rand_value
    @lines = [[2, 2, 4, 8],[4, 4, 8, nil],[4, 4, 4, 4],[2, nil, nil, 4]]
  end

  def update
  end

  def draw
    draw_quad(0, 0, @background,
              width, 0, @background,
              width, height, @background,
              0, height, @background)
    blabla(@lines)

  end
  def for_draw(color, counter_line, counter)
    draw_quad(counter * @column_w, counter_line * @row_h, color,
              (counter + 1) * @column_w - 2, counter_line * @row_h, color,
              (counter + 1) * @column_w - 2, (counter_line + 1) * @row_h - 2, color,
              counter * @column_w, (counter_line + 1) * @row_h - 2, color)
  end

  def blabla(lines)
    counter_line = 0
    while counter_line < 4
      counter = 0
      while counter < 4
        case
        when lines[counter_line][counter] == 2
          for_draw(@color2, counter_line, counter)
        when lines[counter_line][counter] == 4
          for_draw(@color4, counter_line, counter)
        when lines[counter_line][counter] == 8
          for_draw(@color8, counter_line, counter)
        when lines[counter_line][counter] == 16
          for_draw(@color16, counter_line, counter)
        when lines[counter_line][counter] == 32
          for_draw(@color32, counter_line, counter)
        when lines[counter_line][counter] == 64
          for_draw(@color64, counter_line, counter)
        when lines[counter_line][counter] == 128
          for_draw(@color128, counter_line, counter)
        when lines[counter_line][counter] == 256
          for_draw(@color256, counter_line, counter)
        when lines[counter_line][counter] == 512
          for_draw(@color512, counter_line, counter)
        when lines[counter_line][counter] == 1024
          for_draw(@color1024, counter_line, counter)
        when lines[counter_line][counter] == 2048
          for_draw(@color2048, counter_line, counter)
        when lines[counter_line][counter] == nil
          for_draw(@free, counter_line, counter)
        end
        counter += 1
      end
      counter_line += 1
    end
  end

  def needs_cursor?
    true
  end

  def button_down(id)
    case
    when id == Gosu::KbEscape
      close
    when id == Gosu::KbR
      @game.universe.randomly_recovery
    when id == Gosu::KbLeft
      left_all(@lines)
      add_value(@lines)
    when id == Gosu::KbRight
      right_all(@lines)
      add_value(@lines)
    when id == Gosu::KbUp
      @lines = up_all(@lines)
      add_value(@lines)
    when id == Gosu::KbDown
      @lines = down_all(@lines)
      add_value(@lines)
    end
  end

  def left(line)

    counter = 0
    while counter < 3
      if !line[counter].nil? && line[counter] == line[counter+1]
        merge(line, counter)
      end
      counter += 1
    end
    # line = (line.compact + Array.new(4))[0..3]
    line.compact!
    (4 - line.size).times { line << nil }
    line
  end

  def right(line)
    line.reverse!
    left(line)
    line.reverse!
  end

  def merge(line, index)
    line[index] *= 2
    line.delete_at(index+1)
    #line
  end

  def left_all(lines)
    # lines_cheak = lines.dup
    lines.each do |line|
      left(line)
    end
    # add_value(lines)
  end
  def add_value(lines)
    x = rand(3)
    y = rand(3)
    if lines[x][y] == nil
      lines[x][y] = rand > 0.1 ? 2 : 4
    else
      add_value(lines)
    end
  end
  def right_all(lines)
    lines.each do |line|
      line.reverse!
      left(line)
      line.reverse!
    end
  end
  def up_all(lines)
    transposed_lines = lines.transpose
    # transposed_lines.each do |line|
    #   left(line)
    # end
    left_all(transposed_lines)
    transposed_lines.transpose
  end

  def down_all(lines)
    transposed_lines = lines.transpose
    right_all(transposed_lines)
    transposed_lines.transpose
  end

end

window = GameWindow.new
window.show