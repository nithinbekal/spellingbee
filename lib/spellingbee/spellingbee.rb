class SpellingBee
  attr_accessor :dict_words, :dict_frequency

  DEFAULT_DICT = File.join(File.dirname(__FILE__), '..', '..', 'dict', 'default.txt')

  def initialize(opts = {})
    options = { source_text: DEFAULT_DICT }.merge opts
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
    known([word]) || known(WordVariations.new(word).all) || [word]
  end

  private

  # Selects the words from the list that are present in the dictionary.
  # Example: known(["asdfgh", "known", "word", "qqqq"]) #=> ["known", "word"]
  #
  def known(words)
    known_words = words.find_all { |w| @dict_frequency.has_key? w }
    known_words.empty? ? nil : known_words
  end
end
