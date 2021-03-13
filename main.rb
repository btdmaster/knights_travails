# frozen_string_literal: true

class Knight
  def in_board?(location)
    location.each { |i| return false unless (0..7).include?(i) }
    true
  end

  def generate_moves(source)
    moves = []
    adjustments = [[1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-2, 1], [-1, 2]]
    adjustments.each do |adjustment|
      moves.append(sum(source, adjustment))
    end
    moves.map { |move| move if in_board?(move) }.reject(&:nil?)
  end

  def sum(source, adjustment)
    [source[0] + adjustment[0], source[1] + adjustment[1]]
  end

  def knight_moves(source, destination, root = Node.new(source), node = root)
    generate_moves(source).each do |child|
      node.children.append(Node.new(child, [], node))
    end
    solution = root.find_path(destination)
    return solution unless solution.nil?

    node.children.each do |child|
      current = knight_moves(child.position, destination, root, child)
      return current unless current.nil?
    end
  end
end

class Node
  attr_accessor :position, :children, :parent

  def initialize(position, children = [], parent = nil)
    @position = position
    @children = children
    @parent = parent
  end

  def find_path(destination)
    node = self
    queue = Queue.new << node
    until queue.empty?
      return locate(node) if node.position == destination
      node.children.each do |child|
        queue << child
      end
      node = queue.pop
    end
    nil
  end
  def locate(node)
    path = []
    until node.parent.nil?
      path.append(node.position)
      node = node.parent
    end
    path.append(node.position)
    path.reverse
  end
end

knight = Knight.new
p knight.knight_moves([1, 2], [7, 6])
