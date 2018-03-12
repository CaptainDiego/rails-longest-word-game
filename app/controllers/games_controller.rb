class GamesController < ApplicationController
  def new
    @letters = generate_grid(10)
  end

  def score
  end

  private

  def generate_grid(grid_size)
    # TODO: generate random grid of letters
    alphabet = ("A".."Z").to_a
    grid = []
    grid_size.times { grid << alphabet.sample }
    return grid
  end
end
