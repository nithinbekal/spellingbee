
Spellingbee is a ruby gem that gives you spelling suggestions based on the
words present in a source file that acts as the dictionary. The alternate 
spelling suggestions are based on the frequency with which the words occur 
in the source file.

Usage
-----

Install the gem by using gem install spellingbee.

You can create a new spelling bee and call the correct method for a word. This
will return an array of suggestions.

  s = SpellingBee.new
  s.correct "speling" #=> ["spelling"]

The above example uses spellingbee's default dictionary text, which contains 
just a few words. To use your own text source:

  s = SpellingBee.new :source_text => 'my_file.txt'
  s.correct "speling" #=> ["spelling"]
  
The source can be any text file that contains all the words that you might expect 
the spelling corrector to be able to correct.

Credits
-------

This gem is based on the Python example in Peter Norvig's article "How to write
a spelling corrector". [http://norvig.com/spell-correct.html] 

Brian Adkins wrote a version of this code in ruby and the logic used within the
SpellingBee class is based on that code. 
[http://lojic.com/blog/2008/09/04/how-to-write-a-spelling-corrector-in-ruby/]

License
-------

Copyright (c) 2010 Nithin Bekal, released under the MIT license