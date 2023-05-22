require 'json'
require 'open-uri'

# filepath = 'https://wagon-dictionary.herokuapp.com/'
# serialized_words = File.read(filepath)
# words = JSON.parse(serialized_words)
class GamesController < ApplicationController
  def new
    alphabet = ('A'..'Z').to_a
    @letters = Array.new(10) { alphabet.sample }
  end

  def chars_from_grid?(guess)
    @guess.split.each do |letter|
      if @letters.split.include?(letter)
        @letters.split.delete_at(@letters.split.find_index(letter))
        true
      else
        false
        # "Sorry, but #{@guess.upcase} can't be built out of #{@letters.split.join(', ')}"
      end
    end
  end

  def score
    @guess = params[:guess]
    @letters = params[:letters] # @letters = Letter.all
    # @letter = Letter.find(params[:id])
    # if the guess comprises letters from original grid && is valid English word
    url = "https://wagon-dictionary.herokuapp.com/#{@guess}"
    @words = JSON.parse(URI.open(url).read)
    # Iterate over your guess.
    # For each letter check if its in your @letters.split
    # If so, look for the index it and delete it
    # other wise break the iterations, and say that results are wrong cuz breaking the rules.

    if @letters.split.sort.join.include?(@guess.chars.sort.join.upcase) && @words['found']
      "Congratulations! #{@guess.upcase} is a valid English word!"
                #   # if the guess is made up of letters from original grid but is not an english word
                # elsif (@letters.include? @guess)
                #   "Sorry, but #{@guess.upcase} can't be built out of #{@letters.split(', ')}"
                # elsif params[:guess]
                #   "Sorry but #{@guess.upcase} does not seem to be a valid English word."
                #  if the guess is an English word according to the API
        end
  end
end
