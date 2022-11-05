---
author: [Felicitas Pojtinger (fp036)]
date: "2022-10-24"
subject: "Uni Programming Languages Notes"
keywords: [hdm-stuttgart, programming-languages]
lang: en-US
csl: static/ieee.csl
---

# Uni Programming Languages Notes

## Introduction

### Contributing

These study materials are heavily based on [professor Ihler's "Aktuelle Programmiersprachen" lecture at HdM Stuttgart](https://www.hdm-stuttgart.de/studierende/abteilungen/sprachenzentrum/kursangebot/kursangebot/block?sgname=Medieninformatik+%28Bachelor%2C+7+Semester%29&sgblockID=2573358&blockname=Aktuelle+Programmiersprachen&sgang=550033).

**Found an error or have a suggestion?** Please open an issue on GitHub ([github.com/pojntfx/uni-programminglanguages-notes](https://github.com/pojntfx/uni-programminglanguages-notes)):

![QR code to source repository](./static/qr.png){ width=150px }

If you like the study materials, a GitHub star is always appreciated :)

### License

![AGPL-3.0 license badge](https://www.gnu.org/graphics/agplv3-155x51.png){ width=128px }

Uni Programming Languages Notes (c) 2021 Felicitas Pojtinger and contributors

SPDX-License-Identifier: AGPL-3.0
\newpage

## Overview

### General Design

- "A dynamic, open source programming language with a focus on simplicity and productivity. It has an elegant syntax that is natural to read and easy to write."
- Inspired by Perl, Smalltalk, Eiffel, Ada, Lips
- Multi-paradigm from the beginning: Functional, imperative and object-oriented
- Radical object orientation: Everything is an object, there are no primitive types like in Java (`5.times { print "We *love* Ruby -- it's outrageous!" }`)
- Very flexible, i.e. operators can be redefined
- Built-in blocks (closures) from the start, excellent mapreduce capabilities
- Prefers mixins over inheritance
- Syntax uses limited punctuation with some notable exceptions (instance variables with `@`, globals with `$` etc.)

### Implementation Details

- Exception handling similar to Java & Python, but no checked exceptions
- Garbage collection without reference counts
- Simple C/C++ extension interface
- OS independent threading & Fibers, even if OS is single-threaded (like MS-DOS)
- Cross-platform: Linux, macOS, Windows, FreeBSD etc.
- Many implementation (MRI/CRuby, JRuby for Ruby in the JVM, TruffleRuby on GraalVM, mruby for embedded uses, Artichoke for WebAssembly and Rust)

### Users

- Twitter
- Mastodon
- GitHub
- Airbnb
- Shopify
- Twitch
- Stripe
- Etsy
- Soundcloud
- Basecamp
- Kickstarter

### Timeline

- First concepts and prototypes ~1993
- First release ~1995, became most popular language in Japan by 2000
- Subsequent evolution and growth outside Japan
- Ruby 3.0 released ~2020, introducing a type system for static analysis, fibers (similar to Goroutines, asyncio etc.), and completing optimizations making it ~3x faster than Ruby 2.0 (from 2013)

## Syntax

### Logic

Typical logical operators:

```ruby
>> 2 < 3
=> true
```

```ruby
>> 1 == 2
=> false
```

Comparisons are type checked:

```ruby
>> 1 == "1"
=> false
```

Trip equals can be used to check if if an instance belongs to a class:

```ruby
>> String === "abc"
=> true
```

If, else, etc work as expected:

```ruby
if name == "Zigor"
  puts "#{name} is intelligent"
end
```

However Ruby also allows interesting variations of this, such as putting the comparions behind the block to execute:

```ruby
puts "#{name} is genius" if name == "Zigor"
```

We can also use `unless`, which is a more natural way to check for negated expressions:

```ruby
p "You are a minor" unless age >= 18
```

`switch` statements are known as `case` statements, but don't `fallthrough` by default like in Java:

```ruby
case a
  when 1
    spell = "one"
  when 2
    spell = "two"
  when 3
    spell = "three"
  when 4
    spell = "four"
  when 5
    spell = "five"
  else
    spell = nil
end
```

Since everything is an object, we can also use `case` statements to check if instances are of a class:

```ruby
a = "Zigor"
case a
when String
  puts "Its a string"
when Fixnum
  puts "Its a number"
end
```

As mentioned before, Ruby is a very flexible language. The case statement for example also allows to us to check regular expressions:

```ruby
case string
when /Ruby/
  puts "string contains Ruby"
else
  puts "string does not contain Ruby"
end
```

We can even use Lambdas in case statements, making long `if ... else` blocks unnecessary:

```ruby
case num
when -> (n) { n % 2 == 0 }
  puts "#{num} is even"
else
  puts "#{num} is odd"
end
```

And the object orientation becomes very clear; we can even define our own matcher classes:

```ruby
class Zigor
  def self.===(string)
    string.downcase == "zigor"
  end
end

name = "Zigor"

case name
when Zigor
  puts "Nice to meet you Zigor!!!"
else
  puts "Who are you?"
end
```

We can also assign values from a case statement:

```ruby
grade = case mark
        when 80..100  : 'A'
        when 60..79   : 'B'
        when 40..59   : 'C'
        when 0..39    : 'D'
        else "Unable to determine grade. Try again."
end
```

### Loops

Ruby does not have traditional for loops, but multiple, more general constructs that allow for the usecases.

Ruby has the `for` loop that we are all used to, but also more specialized constructs that allow for more expressive usecases:

```ruby
for i in 0..10
    p i
end
```

For example `upto` and `downto` methods:

```ruby
10.downto 1 do |num|
  p num
end
```

```ruby
17.upto 23 do |i|
  print "#{i}, "
end
```

Or the `times` method, which is much more readable:

```ruby
7.times do
  puts "I know something"
end
```

`while`, `until` and the infinite `loop` loops still exist however:

```ruby
i=1
while i<=10 do
  print "#{i}, "
  i+=1
end
```

```ruby
i=1
until i>10 do
  print "#{i}, "
  i+=1
end
```

```ruby
loop do
  puts "I Love Ruby"
end
```

We can also use `break`, `next` and `redo` within a loop's block:

```ruby
1.upto 10 do |i|
  break if i == 6
  print "#{i}, "
end
```

```ruby
10.times do |num|
  next if num == 6
  puts num
end
```

```ruby
5.times do |num|
  puts "num = #{num}"
  puts "Do you want to redo? (y/n): "
  option = gets.chop
  redo if option == 'y'
end
```

### Arrays

Arrays in Ruby can contain multiple types and work as expected; there is no array vs collection divide:

```ruby
my_array = ["Something", 123, Time.now]
```

Instead of loops you can use the `each` method to iterate:

```ruby
my_array.each do |element|
  puts element
end
```

We can use `<<` to add things to an array:

```ruby
>> countries << "India"
=> ["India"]
>> countries
=> ["India"]
>> countries.size
=> 1
>> countries.count
=> 1
```

And access elements with `[0]`:

```ruby
>> countries[0]
=> "India"
```

Thanks to the `..` syntax we can also access multiple elements at once in a very simple way:

```ruby
>> countries[4..9]
=> ["China", "Niger", "Uganda", "Ireland"]
```

And use the `includes?` method (note the `?`!) to check if elements are present:

```ruby
>> countries.include? "Somalia"
=> true
```

And `delete` to delete elements:

```ruby
>> countries.delete "USA"
=> "USA"
```

If we have a nested array, using `dig` fill allow us to find deeply nested elements in a simple way:

```ruby
>> array = [1, 5, [7, 9, 11, ["Treasure"], "Sigma"]]
=> [1, 5, [7, 9, 11, ["Treasure"], "Sigma"]]
>> array.dig(2, 3, 0)
=> "Treasure"
```

Another very useful set of features are set operations, allowing us to modify arrays in a simple way, for example we can use the `&` operator to find elements that are in two arrays:

```ruby
>> volleyball = ["Ashok", "Chavan", "Karthik", "Jesus", "Budha"]
=> ["Ashok", "Chavan", "Karthik", "Jesus", "Budha"]
>> cricket = ["Budha", "Karthik", "Ragu", "Ram"]
=> ["Budha", "Karthik", "Ragu", "Ram"]
>> volleyball & cricket
=> ["Karthik", "Budha"]
```

Or `+` to merge them:

```ruby
>> volleyball + cricket
=> ["Ashok", "Chavan", "Karthik", "Jesus", "Budha", "Budha", "Karthik", "Ragu", "Ram"]
```

Or use `|` to merge both, but de-duplicating at the same time:

```ruby
>> volleyball | cricket
=> ["Ashok", "Chavan", "Karthik", "Jesus", "Budha", "Ragu", "Ram"]
```

Finally, we can also use `-` to remove multiple elements at once:

```ruby
>> volleyball - cricket
=> ["Ashok", "Chavan", "Jesus"]
```

For those who are familiar with MapReduce, Ruby provides all of it in the language. For example `map`:

```ruby
>> array = [1, 2, 3]
=> [1, 2, 3]
>> array.map{ |element| element * element }
=> [1, 4, 9]
```

Note that this doesn't modify the array; we can use `map!` for that, which works for lots of Ruby methods:

```ruby
>> array.collect!{ |element| element * element }
=> [1, 4, 9]
>> array
=> [1, 4, 9]
```

The `filter` method for example can be used in the same way (named `keep_if`, with the opposite `delete_if` also existing), and works like how you already know if from JS:

```ruby
>> array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
=> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
>> array.keep_if{ |element| element % 2 == 0}
=> [2, 4, 6, 8, 10]
```

### Hashes

Hashes can be used to store mapped information:

```ruby
mark = {}
mark['English'] = 50
mark['Math'] = 70
mark['Science'] = 75
```

And we can define a default value:

```ruby
mark = {}
mark.default = 0
mark['English'] = 50
mark['Math'] = 70
mark['Science'] = 75
```

The hash literal `{}` also allows us to create hashes with pre-filled information:

```ruby
marks = { 'English' => 50, 'Math' => 70, 'Science' => 75 }
```

To loop over hashes, we can use the `each` method again:

```ruby
total = 0
mark.each { |key,value|
  total += value
}
puts "Total marks = "+total.to_s
```

A very interesting feature to use in combination with hashes are symbols; they are much more efficient than strings as they are global and thus use less memory:

```ruby
mark = {}
mark[:English] = 50
mark[:Math] = 70
mark[:Science] = 75
```

We can check this by getting their `object_id` (a kind of pointer):

```ruby
c = "able was i ere i saw elba"
d = "able was i ere i saw elba"
>> c.object_id
=> 21472860
>> .object_id
=> 1441620
```

```ruby
e = :some_symbol
f = :some_symbol
>> e.object_id
=> 1097628
>> f.object_id
=> 1097628
```

Just like accessing hash values is similar for arrays and hashes, we can use the same MapReduce functions on hashes:

```ruby
>> hash = {a: 1, b: 2, c: 3}
=> {:a=>1, :b=>2, :c=>3}
>> hash.transform_values{ |value| value * value }
=> {:a=>1, :b=>4, :c=>9}
```

### Ranges

Ranges are a cool concept in Ruby that we've used before. We can use them with the `..` notation:

```ruby
>> (1..5).each {|a| print "#{a}, " }
=> 1, 2, 3, 4, 5, => 1..5
```

We can also use them on strings:

```ruby
>> ("bad".."bag").each {|a| print "#{a}, " }
=> bad, bae, baf, bag, => "bad".."bag"
```

They can be very useful in `case` statements, where you can replace lots of `or` operators with them:

```ruby
grade = case mark
  when 80..100
    'A'
  when 60..79
    'B'
  when 40..59
    'C'
  when 0..39
    'D'
  else
    "Unable to determine grade. Try again."
end
```

In addition to using them in `case` statements as described before, they can also serve as conditions:

```ruby
print "Enter any letter: "
letter = gets.chop

puts "You have entered a lower case letter" if  ('a'..'z') === letter
puts "You have entered a upper case letter" if  ('A'..'Z') === letter
```

We can also use triple dots, which will remove the last value:

```ruby
>> (1..5).to_a
=> [1, 2, 3, 4, 5]
>> (1...5).to_a
=> [1, 2, 3, 4]
```

It is also possible to define endless ranges:

```ruby
print "Enter your age: "
age = gets.to_i

case age
when 0..18
  puts "You are a kid"
when (19..)
  puts "You are grownup"
end
```

### Functions

As mentioned before, Ruby draws a lot of inspiration from functional programming languages, and functions are a primary building block in the language as a result.

We can define functions with `def` and call them without parentheses:

```ruby
def print_line
  puts '_' * 20
end

print_line
```

It is also possible to define default arguments unlike in Java:

```ruby
def print_line length = 20
  puts '_'*length
end

print_line
print_line 40
```

Arguments are always passed by reference:

```ruby
def array_changer array
  array << 6
end

some_array = [1, 2, 3, 4, 5]
p some_array
array_changer some_array
p some_array

=> [1, 2, 3, 4, 5]
=> [1, 2, 3, 4, 5, 6]
```

There is no need for a `return` statements as returns are implicit (but optional for control flow support):

```ruby
def addition x, y
  x + y
end

addition 3, 5

=> 8
```

We can also define named arguments, with or without defaults:

```ruby
def say_hello name: "Martin", age: 33
  puts "Hello #{name} your age is #{age}"
end

say_hello name: "Joseph", age: 7
```

Arguments can also be variadic:

```ruby
def some_function a, *others
  puts a
  others.each do |x|
    puts x
  end
end

some_function 1,2,3,4,5
```

A very neat function is to use argument forwarding to call a function with all used parameters:

```ruby
def print_something string
  puts string
end

def decorate(...)
  puts "#" * 50
  print_something(...)
  puts "#" * 50
end

decorate "Hello World!"
```

We can also define a function in more consise way:

```ruby
def double(num) = num * 2
```
