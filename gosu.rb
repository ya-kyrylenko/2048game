require 'gosu'
require_relative '2048.rb'

class GameWindow < Gosu::Window
  def initialize(height=430, width=406)
    @height = height
    @width = width
    @is_victory = false
    super(width, height, false)
    self.caption = "2048     (¬_¬) press Escape to exit ^~^"

    @background = Gosu::Color.new(0xffbbf6e2)
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)

    @color2    = Gosu::Color.new(0xff75cae3)
    @color4    = Gosu::Color.new(0xff238dac)
    @color8    = Gosu::Color.new(0xff124a5a)
    @color16   = Gosu::Color.new(0xff0c2f3a)
    @color32   = Gosu::Color.new(0xff91f22e)
    @color64   = Gosu::Color.new(0xff2df22c)
    @color128  = Gosu::Color.new(0xff0dc30c)
    @color256  = Gosu::Color.new(0xff087a07)
    @color512  = Gosu::Color.new(0xffe0c613)
    @color1024 = Gosu::Color.new(0xff74660a)
    @color2048 = Gosu::Color.new(0xffef19f1)
    @free      = Gosu::Color.new(0xffb6e3f0)
    # @columns = 
    # @rows = height/100
    @column_w = 100
    @row_h = 100
    @board = Board.new()
    # @board.grid = [[2, 4, 8, 16],[32, 64, 128, 256],[512, 1024, 512, 2],[4,8,16,32]]
    @board.grid = [[128, 128, 128, 128],[128, 128, 128, 128],[128, 128, 128, 128],[128, 128, 128, 128]]
    # 2.times { @board.add_value(@board.grid) }
    # @game = LogicGame.new(@board)
    # @game.board.rand_value
    # @lines = [[2, 4, 8, 16],[32, 64, 128, 256],[512, 1024, 2048, 1024],[2,2,4,8]]
    # @lines = [[2, 2, nil, nil],[nil,nil,nil,nil],[nil,nil,nil,nil],[nil,nil,nil,nil]]
    # @lines = [[2, 2, nil, nil, nil],[nil,nil,nil,nil, nil],[nil,nil,nil,nil,nil],[nil,nil,nil,nil,nil]]
  end
  module Coordinates
  Bla, UI = *0..3
  end

  def update
  end

  def draw
    draw_quad(0, 0, @background,
              width, 0, @background,
              width, height, @background,
              0, height, @background)
    for_display(@board.grid)
    @font.draw("Score: #{@board.score}", 10, 10, Coordinates::UI, 1.0, 1.0, 0xff7b1934)
    @font.draw("Press R to resrart", 250, 10, Coordinates::UI, 1.0, 1.0, 0xff7b1934)
    victory(@board.grid) unless @is_victory
    lose(@board.grid)
  end
  def for_draw(color, counter_line, counter)
    draw_quad(counter * @column_w + 4, counter_line * @row_h + 30, color,
              (counter + 1) * @column_w, counter_line * @row_h + 30, color,
              (counter + 1) * @column_w, (counter_line + 1) * @row_h - 4 + 30, color,
              counter * @column_w + 4, (counter_line + 1) * @row_h - 4 + 30, color)
    @font.draw(" #{@board.grid[counter_line][counter]}", counter * @column_w + (93 - @board.grid[counter_line][counter].to_s.size * 22)/2, counter_line * @row_h + 60, Coordinates::UI, 2.0, 2.0, 0xffffff00)
  end

  def for_display(lines)
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
      @board = Board.new()
      2.times { @board.add_value(@board.grid) }
    when id == Gosu::KbLeft
      @board.left_all(@board.grid)
    when id == Gosu::KbRight
      @board.right_all(@board.grid)
    when id == Gosu::KbUp
      @board.grid = @board.up_all(@board.grid)
    when id == Gosu::KbDown
      @board.grid = @board.down_all(@board.grid)
    when id == Gosu::KbSpace
      @is_victory = true
    end
  end

  def victory(lines)
    if lines.flatten.include?(2048)
      @font.draw("You Win", 100, 100, Coordinates::UI, 4.0, 4.0, 0xff0a7466)
      @font.draw("Press 'space' to continue ", 130, 230, Coordinates::UI, 1.0, 1.0, 0xff0a7466)
    end
  end

  def lose(lines)
    arr = lines.flatten.select {|value| value.nil?}
    if arr.empty?
      add_counter = 0
      lines.each { |line|
        counter = 0
        while counter < 3
          if !line[counter].nil? && line[counter] == line[counter + 1]
            add_counter += 1
          end
          counter += 1
        end
      }
      lines.transpose.each { |line|
        counter = 0
        while counter < 3
          if line[counter] !=nil && line[counter] == line[counter + 1]
            add_counter += 1
          end
          counter += 1
        end
      }
      if add_counter == 0
        @font.draw("Game Over", 80, 180, Coordinates::UI, 3.0, 3.0, 0xfff37686)
      end
    end
  end
end

window = GameWindow.new
window.show