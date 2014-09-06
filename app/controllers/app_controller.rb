class AppController < ApplicationController

  def index
    @cards = Card.where(is_archive: false)
    @archived_cards = Card.where(is_archive: true)
  end

end
