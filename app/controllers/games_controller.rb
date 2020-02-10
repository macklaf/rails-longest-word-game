require 'open-uri'
require 'json'
class GamesController < ApplicationController

  def new
    @letters = []
    counter = 0
    while counter < 10
      @letters << ('a'..'z').to_a.sample
      counter += 1
    end
    @letters
  end

  def verification(word)
    word = word.downcase
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    serialized_word = open(url).read
    word_verif = JSON.parse(serialized_word)
    if word_verif['found'] == false
      false
    else
      word_verif['length'].to_i
    end
  end

  def checkvalid(word, grid)
    word.chars.all? { |letter| word.count(letter) <= grid.count(letter) }
  end

  def run_game(attempt, grid)
    if verification(attempt) == false
      "not an english word"
    elsif checkvalid(attempt, grid) == false
      "not in the grid"
    else
      score = verification(attempt) * 4
      " well done your score is #{score}"
    end
  end

  def score
    @mot = params[:word]
    @letters = params[:grid].split
    grid = params[:grid]
    @score = run_game(@mot, grid)
  end
end
