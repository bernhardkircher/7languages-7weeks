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
# self-study...
###################################
    
# 1. how to access files without code blocks? 

module ToFile_WithoutCodeBlock
  def filename
    "object_#{self.object_id}.txt"
  end
  
  def to_f
    # attention, when not using codeblocks, we would need to catch errors and close the file manually (but i don't od it because I am lazy)
    f = File.open(filename, 'w')
    f.write(to_s)
    f.close
  end
end

# 1.1 What is the benefit of the code block?
# My answer: blocks are more elegant, and in this case (files) it behaves like a using/Dispose in e.g. c#
# so a codeblock can be used to make sure resources are released, even in case of an exception etc. (but it depends how you wrap the codeblock)
# summary: codeblocks: add behaviour before/after user code, can be used for event driven programming (e.g. callbacks), are more elegant especially when iterating.

# 2. how to translate a hash to an array 
my_hash = { :benny => 22, :christina => 10 }
puts "hash: "; p my_hash

puts "array1: "; p my_hash.to_a
# output: [[:christina, 10], [:benny, 22]]

puts "array2: "; p my_hash.to_a.flatten
# output: [:christina, 10, :benny, 22]


# 2.1. can you translate a array to hashes
hash_array1 = my_hash.to_a
puts "array1 to hash again 1: "; p hash_array1.inject(Hash.new) { |memo, tuple| memo[tuple.first] = tuple.last; memo }
# output: {:christina=>10, :benny=>22}

puts "array1 to hash again 2: "; p Hash[hash_array1]
# output: {:christina=>10, :benny=>22}

hash_array2 = my_hash.to_a.flatten
puts "array2 to hash again 1: "; p Hash[hash_array2]
# output: {}

puts "array2 to hash again 2: "; p Hash[*hash_array2]
# output: {:christina=>10, :benny=>22}


# 3.1. Can you iterate through a hash?
hash_to_iterate = { :benny => 22, :christina => 10 }
hash_to_iterate.each { | key, value | puts "key: #{key} - value: #{value}" }


# 4. You can use Ruby arrays as stacks. What other common data structures to arrays support?
puts "queue:"
queue = [].push("1").push("2")
queue.unshift("a").unshift("b")
puts queue
puts queue.shift
puts queue.shift
puts queue.pop
puts queue.pop

puts "list: "
list = [1,2,3].insert(2, "c")
puts list
puts "removed: " + list.delete("c")

puts "bag/set:"
bag = [1,2,3,3,4,5]
puts bag
set = bag.uniq
other_set = [3,5]
puts set
puts set & other_set

puts "matrix:"
matrix = [[1,2,3],[4,5,6],[7,8,9]]
puts matrix
puts matrix.transpose


###################################
# self-study... DO
###################################

# 1.1 Print the contents of an array of sixteen numbers, four numbers at a time, using just each. 
numbers = (1..16).to_a
numbers.each do |number|
  p numbers[number-4...number] if number % 4 == 0
end

# 1.2. Now, do the same with each_slice in Enumerable
numbers.each_slice(4) { |four_numbers| p four_numbers }


# 3. The Tree class was interesting, but it did not allow you to specify a new tree with a clean user interface. Let the initializer accept a nested structure with hashes and arrays. You should be able to specify a tree like this: {'grandpa' => {'dad' => {'child 1' => {}, 'child 2' => {} }, 'uncle' => {'child 3' => {}, 'child 4' => {} } } }.

class AdvancedTree
  attr_accessor :children, :node_name
  
  def initialize(name, children=[])
  
    # if the 1. argument seems to be a hash, create structure from hash

    if name.respond_to?('keys') then
      # get 1. key value pair
      root = name.first
      # attention, we may get an index error, since we do not check if there are enough elements...      
      name = root[0]
      children = root[1]
    end
    
    if children.respond_to?('keys') then
      # convert sub hashes to Trees (key = name, value may be deeper hash
      children = children.map {|key, value| AdvancedTree.new(key, value)}
    end
  
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

tree_data = {'grandpa' => {'dad' => {'child 1' => {}, 'child 2' => {} }, 'uncle' => {'child 3' => {}, 'child 4' => {} } } }
advancedruby_tree_from_hash = AdvancedTree.new(tree_data)

advancedruby_tree = AdvancedTree.new("Ruby",
  [ AdvancedTree.new("Reia"),
  AdvancedTree.new("MacRuby")] )

advancedruby_tree_from_hash.visit_all { |node| p node.node_name }
advancedruby_tree.visit_all { |node| p node.node_name }


# 4. Write a simple grep that will print the lines of a file having any occurrences of a phrase anywhere in that line. you will need to do a simple regular expression match and read lines from a file. (This is surprisingly simple in Ruby.) If you want, include line numbers.

def grep(search, filename)
  regexp = Regexp.new(search)
  File.foreach(filename).with_index { |line, line_number|
    puts "#{line_number}: #{line}" if regexp =~ line
  }
end














