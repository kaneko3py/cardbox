class CardsController < ApplicationController
  before_action :required_login
  before_action :set_card, only: [:show, :edit, :update, :destroy]

  def index
    @cards = Card.where({user_id: @current_user.id})
    render json: @cards.to_json({include: :activity})
  end

  # GET /cards/1
  def show
  end

  # GET /lottery
  def lottery
    @cards = Card.where({user_id: @current_user.id})
    _cards_h = @cards.to_a.sample(5).map{ |_card|
      _card = _card.attributes
      _card["answers"] = @cards.find(_card["id"]).answers.order(rate: :desc,count: :desc,created_at: :asc).limit(6).to_a
      _card
    }
    render json: _cards_h.to_json
    # render json: @cards.to_json(include: :answers)
  end

  # # GET /cards/new
  # def new
  #   @card = Card.new
  # end

  # # GET /cards/1/edit
  # def edit
  # end

  # POST /cards
  def create
    @card = Card.new(card_params)
    @card.user_id = @current_user.id
    begin
      @card.no = Card.maximum(:no, user_id: @current_user.id) + 1
    rescue
      @card.no = 1
    end

    if @card.save
      render json: @card.to_json({include: :activity})
    else
      render json: { status: :unprocessable_entity, errors: @card.errors }
    end
  end

  # PATCH/PUT /cards/1
  def update
    if @card.update(card_params)
      render json: { status: :ok, location: @card }
    else
      render json: { status: :unprocessable_entity, errors: @card.errors }
    end
  end

  # DELETE /cards/1
  def destroy
    @card.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def card_params
      params.require(:card).permit(:no, :tag, :question, :answer, :comment, :is_archive)
    end
end
