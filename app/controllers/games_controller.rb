require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    @letters = generate_grid(10)
    @attempt = params[:word]
  end

  def score
    @letters = params[:letters].split
    @score = run_game(params[:word], @letters)
  end

  private

  def generate_grid(grid_size)
    # TODO: generate random grid of letters
    alphabet = ("A".."Z").to_a
    grid = []
    grid_size.times { grid << alphabet.sample }
    return grid
  end


  def run_game(attempt, grid)
  # TODO: runs the game and return detailed hash of result
  url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
  user_serialized = open(url).read
  user = JSON.parse(user_serialized)

  result = {
    message: ""
  }
  if user["found"] == true
    arr = attempt.upcase.scan(/\w/)
    if arr.all? { |letter| arr.count(letter) <= grid.count(letter) }
      result[:message] = "Well done"
      # result[:score] = (attempt.size * 30) / (result[:time])
    else
      result[:message] = "not in the grid"
      # result[:score] = 0
    end
  else
    result[:message] = "is not an english word"
    # result[:score] = 0
  end
  return "#{attempt} #{result[:message]}"
end
end
