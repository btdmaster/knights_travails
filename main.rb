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
      node.children.append(Node.new(child))
    end
    solution = root.path(destination)
    return solution if solution

    node.children.each do |child|
      knight_moves(child.position, destination, root, child)
    end
  end
end

class Node
  attr_accessor :position, :children

  def initialize(position, children = [])
    @position = position
    @children = children
  end
  def path(destination)
  end
end

knight = Knight.new
p knight.knight_moves([1, 2], [3, 7])
