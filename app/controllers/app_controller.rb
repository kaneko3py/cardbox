class AppController < ApplicationController

  def index
    redirect_to controller: 'devise/sessions',action: :new unless user_signed_in?
  end

end
