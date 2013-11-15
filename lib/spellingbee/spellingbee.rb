class SpellingBee
  attr_accessor :dict_words, :dict_frequency

  DEFAULT_DICT = File.join(File.dirname(__FILE__), '..', '..', 'dict', 'default.txt')

  def initialize(opts = {})
    options = { :source_text => DEFAULT_DICT }.merge opts
    @dict_frequency = Hash.new(1)
    @dict_words = File.new(options[:source_text]).read.downcase.scan(/[a-z]+/)
    @dict_words.each { |word| @dict_frequency[word] += 1 }
  end

  # Returns the suggestion for the correction. If the word is found in the
  # dictionary, it is returned, otherwise the word closest to it is returned.
  # If there are no spelling suggestions, the same word is returned.
  #
  # Example:
  #
  #   s = Spellingbee.new
  #   s.correct "spelling"   #=> ["spelling"] -> word from dictionary
  #   s.correct "speling"    #=> ["spelling"] -> corrected spelling
  #   s.correct "qqqqqq"     #=> ["qqqqqq"]   -> no suggestions
  #
  def correct(word)
    known [word] or known(variation_words word) or [word]
  end

  private

  # Returns all the combinations of the word with one character removed.
  # Example: deletions("word") #=> ["ord", "wrd", "wod", "wor"]
  def deletions(word)
    n = word.length
    deletion = (0...n).collect {|i| word[0...i]+word[i+1..-1] }
  end

  # Returns all combinations of the word with adjacent words transposed.
  # Example: transpositions("word") #=> ["owrd", "wrod", "wodr"]
  def transpositions(word)
    n = word.length
    (0...n-1).collect {|i| word[0...i]+word[i+1,1]+word[i,1]+word[i+2..-1] }
  end

  # Returns all variations of the word with each character replaced by all
  # characters from 'a' to 'z'.
  # Example: replacements("word") #=> ["aord", "bord", "cord", ... "ward", "wbrd" ...]
  def replacements(word)
    n = word.length
    new_words = []
    n.times {|i| ('a'..'z').each {|l| new_words << word[0...i]+l.chr+word[i+1..-1] } }
    new_words
  end

  # Returns all variations of the word with an alphabet inserted between the characters.
  # Example: insertions("word") #=> ["aword", "bword", "cword" ... "waord", "wbord" ... ]
  def insertions(word)
    n = word.length
    new_words = []
    (n+1).times {|i| ('a'..'z').each {|l| new_words << word[0...i]+l.chr+word[i..-1] } }
    new_words
  end

  # Returns the variations of the given spelling. This set will contain all the
  # possible variations of the spelling havind edit distance = 1. (Edit
  # distance is the number of edits it takes to obtain the second word from
  # the first.)
  def variation_words(word)
    ( deletions(word) + transpositions(word) + replacements(word) + insertions(word) ).uniq
  end

  # Selects the words from the list that are present in the dictionary.
  # Example: known(["asdfgh", "known", "word", "qqqq"]) #=> ["known", "word"]
  #
  def known(words)
    known_words = words.find_all { |w| @dict_frequency.has_key? w }
    known_words.empty? ? nil : known_words
  end
end
