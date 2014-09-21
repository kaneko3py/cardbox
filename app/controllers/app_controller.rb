class AppController < ApplicationController

  def index
    @cards = Card.all
  end

end
