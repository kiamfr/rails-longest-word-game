require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @starttime = Time.new
    @letters = []
    ('a'..'z').to_a.shuffle[0,10].each do |letter|
      @letters << letter
    end
    @letters
  end

  def score
    @endtime = Time.new - Time.parse(params[:time])
    @form_entry = params[:solution]
    filepath = "https://wagon-dictionary.herokuapp.com/#{@form_entry}"
    word_json = open(filepath).read
    @result = JSON.parse(word_json)
    @reply = checkword(@result)
  end

  private

  def checkword(word)
    if @result["found"] == true
      @reply = "Your entry was #{@form_entry} and it's actually a word!"
    else @reply = "Sorry, it's not a word."
    end
  end
end
