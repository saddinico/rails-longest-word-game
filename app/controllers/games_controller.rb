require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    alphabet = ("A".."Z").to_a
    10.times do
      @letters.push(alphabet.sample)
    end
  end

  def score
    @word = params[:word].to_s
    @letters = params[:letters]

    url = 'https://wagon-dictionary.herokuapp.com/'
    json = JSON.parse(open("#{url}#{@word}").read)

    word_array = @word.upcase.split('')
    letters_array = @letters.split('')

    if (word_array - letters_array) != []
      @result = "Sorry but #{@word.upcase} cannot be built out of #{@letters}"
    elsif json['found'] == false
      @result = "Sorry but #{@word.upcase} does not seem to be a valid English word..."
    else
      @result = "Congratulations! #{@word.upcase} is a valid english word"
    end

  end

end
