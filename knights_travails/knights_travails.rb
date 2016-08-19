require_relative "../PolyTreeNode/lib/00_tree_node"
require 'byebug'

class KnightPathFinder
  DELTAS = [[2, -1], [2, 1], [1, -2], [1, 2], [-1, -2], [-1, 2],
   [-2, -1], [-2, 1]]

   attr_reader :root

  def initialize(start_pos = [0,0])
    @root = PolyTreeNode.new(start_pos)
    @visited_positions = [start_pos]
  end

  def build_move_tree(root = @root)
    queue = [root]

    until queue.empty?
      node = queue.pop
      new_move_positions(node.value).each do |new_pos|
        new_child = PolyTreeNode.new(new_pos)
        node.add_child(new_child)
        queue.unshift(new_child)
      end
    end
  end

  def new_move_positions(pos)
    new_moves = valid_moves(pos).reject do |move|
      @visited_positions.include?(move)
    end

    @visited_positions += new_moves
    new_moves
  end

  def valid_moves(pos)
    possible_moves = DELTAS.map do |shift|
      [pos[0] + shift[0], pos[1] + shift[1]]
    end

    possible_moves.select do |new_pos|
      new_pos[0].between?(0,7) && new_pos[1].between?(0,7)
    end
  end

  def find_path(end_pos)
    end_node = @root.bfs(end_pos)
    trace_path_back(end_node)
  end

  def trace_path_back(end_node)
    path = [end_node.value]
    node = end_node
    until node == @root
      # debugger
      node = node.parent
      path.unshift(node.value)
    end

    path
  end
end
