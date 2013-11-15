class SpellingBee
  class WordVariations
    def initialize(word)
      @word = word || ''
    end

    # Returns the variations of the given word. This set will contain all the
    # possible variations of the word having edit distance = 1.
    def all
      (deletions + transpositions + replacements + insertions).uniq
    end

    private

    # Returns all the combinations of the word with one character removed.
    # Example: deletions("word") #=> ["ord", "wrd", "wod", "wor"]
    def deletions
      (0..length).map { |i| "#{@word[0...i]}#{@word[i+1..-1]}" }
    end

    # Returns all combinations of the word with adjacent words transposed.
    # Example: transpositions("word") #=> ["owrd", "wrod", "wodr"]
    def transpositions
      (0..length-1).map { |i| "#{@word[0...i]}#{@word[i+1, 1]}#{@word[i,1]}#{@word[i+2..-1]}" }
    end

    # Returns all variations of the word with each character replaced by all
    # characters from 'a' to 'z'.
    # Example: replacements("word") #=> ["aord", "bord", "cord", ... "ward", "wbrd" ...]
    def replacements
      new_words = []
      length.times do |i|
        ('a'..'z').each { |c| new_words << "#{@word[0...i]}#{c}#{@word[i+1..-1]}" }
      end
      new_words
    end

    # Returns all variations of the word with an alphabet inserted between the characters.
    # Example: insertions("word") #=> ["aword", "bword", "cword" ... "waord", "wbord" ... ]
    def insertions
      new_words = []
      (length + 1).times do |i|
        ('a'..'z').each { |c| new_words << "#{@word[0...i]}#{c}#{@word[i..-1]}" }
      end
      new_words
    end

    def length
      @word.length
    end
  end
end