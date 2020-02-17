require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    #raise
    @word = params[:word].upcase.split('')
    @letters = params[:letters].split
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    user_serialized = open(url).read
    @api_result = JSON.parse(user_serialized)
    # In html => <%= @api_result%>
    # {'found'=> true, "word"=> "hello", "length"=>5}

    in_grid = @word.all? { |letter| @word.count(letter) <= @letters.count(letter) }
    if in_grid && @api_result['found']
      @message = 'You won'
    elsif in_grid
      @message = 'This is not an English word'
    elsif @api_result['found']
      @message = 'This cannot be built out of the letters in the grid'
    else
      @message = 'Neither an English word, nor in the grid'
    end
  end
end
