# 7 languages in 7 weeks: ruby, day 1

# just print a string
puts 'Hello, world'

# find index of "ruby" in "hello ruby"
puts 'Hello, Ruby'.index('Ruby')

# print your name 10 times (we can do this in very different ways, i just use blocks
10.times { puts "Bernhard" }

# print the string "this sentence is number x", where x is the number
(1..10).each do |number|
	puts "This is sentence number #{number}"
end


###################################
# bonus: write a program, that picks a random number and let the user guess....
###################################

# random generates random number (0..9)
number = rand(10)
guessed_nr = -1

# again, there are many ways to write this, I choose unless, because it seems clear
until guessed_nr == number 
  puts 'Guess the number from 0..9'
  guessed_nr = gets.chomp.to_i
  if guessed_nr > number
    puts "#{guessed_nr} is greater than the number to guess"
  elsif guessed_nr < number
    puts "#{guessed_nr} is smaller than the number to guess"
  end
end

puts "Yes, you did it! the number to guess was #{number}"

