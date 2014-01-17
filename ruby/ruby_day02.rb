# 7 languages in 7 weeks: ruby, day 2

###################################
# some tests from the book...
###################################

#array
[1].class

# indexer is a method of the array
[1].methods.include?('[]')

a = [1]
a.push(2)

# hashes
numbers = { 1 => 'one', 2 => 'two' }

puts 'string'.object_id
puts 'string'.object_id

# symbols
puts :string.object_id
puts :string.object_id

# hashes as named parameters
def tell_the_truth(options={})
    if options[:profession] == :lawyer
        'it could be believed that this is almost certainly not false'
    else
        true
    end
end

tell_the_truth

tell_the_truth(:profession => :lawyer)

# code blocks
3.times {puts 'test' }

# convention, use braces {} for 1 line blocks, otherwise  use do/end
animals = ['lions and ', 'tigers and ' , 'bears', 'oh my']
animals.each {|a| puts a }

# custom implementation of times... - extend existing class
class Fixnum
  def my_times
    i = self
    while i > 0
      i = i - 1
      yield
    end
  end
end
3.my_times { puts 'my test' }


def call_block(&block)
  block.call
end

def pass_block(&block)
  call_block(&block)
end

pass_block {puts 'hello, block' }


puts 4.class
puts 4.class.superclass

4.class.class
4.class.class.superclass


class Tree
  attr_accessor :children, :node_name
  
  def initialize(name, children=[])
    @children = children
    @node_name = name
  end
  
  def visit_all(&block)
    visit &block
    children.each {|c| c.visit_all &block}
  end
  
  def visit(&block)
    block.call self
  end
end

ruby_tree = Tree.new( "Ruby",
  [ Tree.new("Reia"),
  Tree.new("MacRuby")] )
  
puts 'visiting a node'
ruby_tree.visit {|node| puts node.node_name}
puts

puts 'visiting complete tree'
ruby_tree.visit_all {|node| puts node.node_name}


#######################
# mixins

module ToFile
  def filename
    "object_#{self.object_id}.txt"
  end
  
  def to_f
    File.open(filename, 'w') {|f| f.write(to_s)}
  end
end

class Person
  include ToFile
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
  
  def to_s
    name
  end
end

Person.new("benny").to_f

###################################
# some tests from the book...
###################################
    



