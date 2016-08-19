require 'byebug'

class PolyTreeNode
  attr_reader :parent, :children, :value
  def initialize(value, parent = nil, children = [])
    @value = value
    @parent = parent
    @children = children
  end

  def parent=(new_parent)
    @parent.children.delete(self) unless @parent == nil
    if new_parent == nil
      @parent = nil
    else
      @parent = new_parent
      @parent.children << self unless @parent.children.include?(self)
    end
  end

  def add_child(child)
    child.parent = self
  end

  def remove_child(child)
    raise "Not a child" unless @children.include?(child)
    child.parent = nil
  end

  def dfs(target)
    return self if self.value == target
    self.children.each do |child|
      search_result = child.dfs(target)
      return search_result if search_result
    end
    nil
  end

  def bfs(target)
    queue = [self]

    until queue.empty?
      current_node = queue.shift
      if current_node.value == target
        return current_node
      else
        current_node.children.each { |child| queue.push(child) }
      end
    end
    nil
  end
end
