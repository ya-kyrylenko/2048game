require 'gosu'
require_relative '2048.rb'
require_relative 'Command.rb'

class GameWindow < Gosu::Window
  def initialize(height=430, width=406)
    @height = height
    @width = width
    super(width, height, false)
    self.caption = "2048     (¬_¬) press Escape to exit ^~^"

    @background = Gosu::Color.new(0xffbbf6e2)
    @free       = 0xffb6e3f0
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)

    @colors_array = [ 0xff75cae3,
                      0xff238dac,
                      0xff124a5a,
                      0xff0c2f3a,
                      0xff91f22e,
                      0xff2df22c,
                      0xff0dc30c,
                      0xff087a07,
                      0xffe0c613,
                      0xff74660a,
                      0xffef19f1,
                      0xff780779,
                      0xff1d021d,
                      0xff1d021d,
                      0xff1d021d,
                      0xff1d021d ]

    @column_w = 100
    @row_h = 100
    @board = Board.new()
    # @board.grid = [[2, 4, 8, 16],[32, 64, 128, 256],[512, 1024, 2048, 4096],[8192,16384,32768,65536]]
    # @board.grid = [[128, 128, 128, 128],[128, 128, 128, 128],[128, 128, 128, 128],[128, 128, 128, 128]]
  end

  module Coordinates
  Bla, UI = *0..3
  end

  def update
  end

  def draw
    draw_quad(0,     0,      @background,
              width, 0,      @background,
              width, height, @background,
              0,     height, @background)

    for_display_cells(@board.grid)
    @font.draw("Score: #{@board.score}", 10, 10, Coordinates::UI, 1.0, 1.0, 0xff7b1934)
    @font.draw("Press R to resrart",    250, 10, Coordinates::UI, 1.0, 1.0, 0xff7b1934)

    for_display_victory(@board.victory?) unless @board.is_victory
    for_display_lose(@board.lose?)
  end

  def for_display_cells(lines)
    counter_line = 0
    while counter_line < 4
      counter = 0
      while counter < 4
        16.times do |degree|
          if lines[counter_line][counter] == 2**(degree + 1)
            for_draw_cell(Gosu::Color.new(@colors_array[degree]), counter_line, counter)
          end
        end
        for_draw_cell(@free, counter_line, counter) unless lines[counter_line][counter]
        counter += 1
      end
      counter_line += 1
    end
  end

  def needs_cursor?
    true
  end

  def button_down(id)
    case id
    when Gosu::KbEscape
      close
    when Gosu::KbR
      @board = Board.new()
    when Gosu::KbLeft
      launchMove Move
    when Gosu::KbRight
      launchMove RightMove
    when Gosu::KbUp
      launchMove UpMove
    when Gosu::KbDown
      launchMove DownMove
      # @board.grid = @board.down_move(@board.grid)
      # @board.down_move(@board.grid)
      # @board.add_number_if_changed_for_vertical
    when Gosu::KbSpace
      @board.is_victory = true
    end
  end

  def for_display_victory(win)
    if win
      @font.draw("You Win", 100, 180, Coordinates::UI, 3.0, 3.0, 0xff042b26)
      @font.draw("Press 'space' to skip message ", 100, 230, Coordinates::UI, 1.0, 1.0, 0xff042b26)
    end
  end

  def for_display_lose(lose)
    @font.draw("Game Over", 80, 180, Coordinates::UI, 3.0, 3.0, 0xff111f02) if lose
  end

  def launchMove(command)
    command.new(@board).execute
  end

  private

  def for_draw_cell(color, counter_line, counter)
    draw_quad(counter * @column_w + 4,   counter_line * @row_h + 30,           color,
              (counter + 1) * @column_w, counter_line * @row_h + 30,           color,
              (counter + 1) * @column_w, (counter_line + 1) * @row_h - 4 + 30, color,
              counter * @column_w + 4,   (counter_line + 1) * @row_h - 4 + 30, color)
    @font.draw(" #{@board.grid[counter_line][counter]}", counter * (@column_w + 1) + (90 - @board.grid[counter_line][counter].to_s.size * 22)/2, counter_line * @row_h + 60, Coordinates::UI, 2.0, 2.0, 0xffffff00)
  end
end

window = GameWindow.new
window.show