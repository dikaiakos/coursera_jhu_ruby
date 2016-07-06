#Implement all parts of this assignment within (this) module2_assignment2.rb file

#Implement a class called LineAnalyzer.
class LineAnalyzer
  #Implement the following read-only attributes in the LineAnalyzer class.
  @highest_wf_count   # a number with maximum number of occurrences for a single word (calculated)
  @highest_wf_words   # an array of words with the maximum number of occurrences (calculated)
  @content            # the string analyzed (provided)
  @line_number        # the line number analyzed (provided)

  attr_reader :highest_wf_count, :highest_wf_words,  :content, :line_number

  # taking a line of text (content) and a line number
  def initialize(line, num)
    @content = line
    @line_number = num
    calculate_word_frequency line
  end


  # calculates result
  def calculate_word_frequency(line)
    # word_frequencies = Hash.new {|hash, key| hash[key] = 0}

    word_frequencies = Hash.new()

    line.split.each  do |word|
      if word_frequencies.has_key?(word)
        word_frequencies[word] += 1
      else
        word_frequencies[word] = 1
      end
    end
    @highest_wf_count = word_frequencies.values.max
    @highest_wf_words = word_frequencies.select { |k, v| v == word_frequencies.values.max}.keys

    puts "[#{@highest_wf_count}]: #{word_frequencies}" #MDD
  end

  # beautify printing LineAnalyzer objects
  def to_s
    "#{@line_number}: #{@highest_wf_words}[#{@highest_wf_count}]\n #{@content}"
  end
end



#  Implement a class called Solution.
class Solution

  attr_reader :analyzers, :highest_count_across_lines

  # Implement the following read-only attributes in the Solution class.
  #* analyzers - an array of LineAnalyzer objects for each line in the file
  @analyzers
  # a number with the maximum value for highest_wf_words attribute in the analyzers array.
  @highest_count_across_lines

  # a filtered array of LineAnalyzer objects with the highest_wf_words attribute
  # equal to the highest_count_across_lines determined previously.
  @highest_count_words_across_lines

  def initialize
    @analyzers = Array.new(0)
    @highest_count_across_lines=0
    @highest_count_words_across_lines = Array.new(0)
  end

  # processes 'test.txt' intro an array of LineAnalyzers and stores them in analyzers
  def analyze_file

    if File.exist? 'test.txt'
      ccount = 0
      File.foreach('test.txt') do | line |
        @analyzers << LineAnalyzer.new(line,ccount)
        ccount += 1
      end
    end
  end

  # calculate_line_with_highest_frequency() - determines the highest_count_across_lines and
  #  highest_count_words_across_lines attribute values
  def calculate_line_with_highest_frequency
    @analyzers.each do |line|
      @highest_count_across_lines= line.highest_wf_count if line.highest_wf_count > @highest_count_across_lines
    end
    puts "MAX: #{@highest_count_across_lines}" #MDD
    @analyzers.each do |line|
      if line.highest_wf_count == @highest_count_across_lines
        puts "#{line} ==> #{line.highest_wf_words}" #MDD
        @highest_count_words_across_lines << line
        puts "@@>#{line.highest_wf_count}: #{line.highest_wf_words}"  #MDD
      end
    end
  end


  #  prints the values of LineAnalyzer objects in
  #  highest_count_words_across_lines in the specified format
  def  print_highest_word_frequency_across_lines
    puts "The following words have the highest word frequency per line:"
    @highest_count_words_across_lines.each do |elt|
      puts "#{elt.highest_wf_words} (appears in line \# #{elt.line_number})"
    end

  end

  # Implement the analyze_file() method() to:
  #* Read the 'test.txt' file in lines
  #* Create an array of LineAnalyzers for each line in the file

  # Implement the calculate_line_with_highest_frequency() method to:
  #* calculate the maximum value for highest_wf_count contained by the LineAnalyzer objects in analyzers array
  #  and stores this result in the highest_count_across_lines attribute.
  #* identifies the LineAnalyzer objects in the analyzers array that have highest_wf_count equal to highest_count_across_lines
  #  attribute value determined previously and stores them in highest_count_words_across_lines.

  #Implement the print_highest_word_frequency_across_lines() method to
  #* print the values of objects in highest_count_words_across_lines in the specified format
end


ss = Solution.new
ss.analyze_file
ss.calculate_line_with_highest_frequency
ss.print_highest_word_frequency_across_lines
