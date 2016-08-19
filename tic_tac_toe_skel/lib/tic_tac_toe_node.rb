require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return false if @board.winner == evaluator
    # return false if @board.over?

    # if @board[@prev_move_pos] == @next_mover_mark
    #   children.all? { |child| child.losing_node?(@next_mover_mark) }
    # else
    #   children.any? { |child| child.losing_node?(change_mark) }
    # end

    children.each do |child|
      return true if child.losing_node?(evaluator)
      # child.next_mover_mark == evaluator
      # child.losing_node?(evaluator)
      # end
    end

    true
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    opens = open_positions
    children = []
    opens.each do |empty_pos|
      next_board = @board.dup
      next_board[empty_pos] = @next_mover_mark
      children << TicTacToeNode.new(next_board, change_mark, empty_pos)
    end
    children
  end

  def change_mark
    @next_mover_mark == :x ? :o : :x
  end

  def open_positions
    array = []
    @board.rows.each.with_index do |row, i|
      row.each.with_index do |el, j|
        array << [i,j] if @board.empty?([i,j])
      end
    end

    array
  end
end
