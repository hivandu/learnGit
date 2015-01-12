puts "Seconds/day: #{24*60*60}"
puts "#{"Ho! "*3}Merry Christmas!"
puts "This is line #$."

puts "Now is #{
def the(a)
  'the ' + a
end
the('time')
} for all good coders..."

puts %q/general single-quoted string/
puts %Q!general double-quoted string!
puts %Q{Seconds/day: #{24*60*60}}

string  = <<END_OF_STRING
  The body of the string
  is the input lines up to
  one ending with the same
  text that followed the '<<'
END_OF_STRING

puts string

print <<-STRING1, <<-STRING2
  Concat
  STRING1
    enate
    STRING2

puts "I change branch to master"

puts 'I change branch to testing'
class Song
  include Comparable
  @@plays = 0
  attr_reader :name, :artist, :duration
  attr_writer :duration
  def initialize(name, artist, duration)
    @name = name
    @artist = artist
    @duration = duration
    @plays = 0
  end
end

class Button
  def initialize(label)
  end
end

class WordIndex
  def initialize
    @index = {}
  end
  def add_to_index(obj, *phrases)
    phrases.each do |phrase|
      phrase.scan(/w[-\w']+/) do |word|
        word.downcase!
        @index[word] = [] if @index[word].nil?
        @index[word].push(obj)
      end
    end
  end
  def lookup(word)
    @index[word.downcase]
  end
end
