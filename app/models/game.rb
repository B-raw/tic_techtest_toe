class Game
  def initialize
    @board = Array.new(3) { Array.new(3) { '' } }
    @player_1_turn = true
    @over = false
  end

  def board
    @board.dup
  end

  def take_turn(x, y)
    check_for_errors(x, y)
    @board[x][y] = current_player_counter
    check_for_winner
    switch_player_turns
    board #return board so that return of method is not false or true which could be misleading
  end

  def game_over?
    @over
  end

private

  def current_player_counter
    @player_1_turn ? "X" : "O"
  end

  def switch_player_turns
    @player_1_turn = !@player_1_turn
  end

  def check_for_errors(x, y)
    raise_error_if_game_over
    raise_error_if_field_taken(x, y)
  end

  def raise_error_if_field_taken(x, y)
    raise "Field taken, choose another" if @board[x][y] != ""
  end

  def raise_error_if_game_over
    raise "Game Over" if game_over?
  end

  def check_for_winner
    check_for_vertical_line
    check_for_horizontal_line
    check_for_diagonal_line
  end

  def all_equal?(comparison, *elements)
    elements.all? { |x| x == comparison }
  end

  def check_for_vertical_line
    first_row = @board[0]
    first_row.each_with_index do |field, index|
      @over = true if ((field == current_player_counter) && field == @board[1][index] && field == @board[2][index])
    end
  end

  def check_for_horizontal_line
    @board.each do |row |
      if row.all? { |field| field == current_player_counter }
        @over = true
      end
    end
  end

  def check_for_diagonal_line
    if @board[0][0] == current_player_counter && @board[1][1] == current_player_counter && @board[2][2] == current_player_counter ||
       @board[0][2] == current_player_counter && @board[1][1] == current_player_counter && @board[2][0] == current_player_counter
       @over = true
     end
  end

end
