# frozen_string_literal: true
class Knight
  def in_board?(location)
    location.each { |i| return false unless (0..7).include?(i) }
    true
  end

  def generate_moves(source)
    moves = []
    adjustments = [[1, 2], [2, 1], [-1, 2], [2, -1], [-1, 2], [2, -1], [-1, -2], [-2, -1]]
    adjustments.each do |adjustment|
      moves.append(sum(source, adjustment))
    end
    moves.map { |move| move if in_board?(move) }.reject(&:nil?)
  end

  def sum(source, adjustment)
    [source[0] + adjustment[0], source[1] + adjustment[1]]
  end

  def knight_moves(source, destination, tree = Tree.new(Node.new(source)), root = tree.root)
    generate_moves(source).each do |move|
      root.children.append(Node.new(move))
    end
    solution = tree.find(destination)
    if solution.nil?
      tree.root.children.each do |child|
        knight_moves(child.position, destination, tree, child)
      end
    else
      p destination
      return tree
    end
  end
end
class Tree
  attr_accessor :root
  def initialize(root)
    @root = root
  end
  def find(value, root = @root)
    return nil if root == nil
    if root.position == value
      return root
    else
      root.children.each do |child|
        find(value, child)
      end
    end
  end
end
class Node
  attr_accessor :position, :children
  def initialize(position, children = [])
    @position = position
    @children = children
  end
end
knight = Knight.new
p knight.knight_moves([1,2], [7, 6])
