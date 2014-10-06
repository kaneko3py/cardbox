class CardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_card, only: [:show, :edit, :update, :destroy]

  # lottery const
  NUMBER_OF_TESTS = 5
  MAX_BEST_CARDS = 6

  def index
    @cards = Card.where({user_id: current_user.id})
    render json: @cards.to_json()
  end

  # GET /cards/1
  def show
  end

  # GET /lottery
  def lottery

    @cards = Card.where({user_id: current_user.id})
    cards_h = @cards.to_a.sample(NUMBER_OF_TESTS).map{ |card|
      card = card.attributes
      card["answers"] = @cards.find(card["id"]).answers.order(rate: :desc,count: :desc,created_at: :asc).limit(MAX_BEST_CARDS).to_a
      card
    }
    render json: cards_h.to_json
    # render json: @cards.to_json(include: :answers)
  end

  # GET /info
  def info
    good_cards = Card.where({user_id: current_user.id, reliability: "A"}).count()
    total_cards = Card.where({user_id: current_user.id}).count()
    persent = (total_cards !=0 ? (good_cards / total_cards).round(1) : 0)

    render json: { good_cards: good_cards, total_cards: total_cards, persent: persent}
  end

  # GET /tags
  def tags
    tags = Tag.where({user_id: current_user.id})

    render json: tags.to_json
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
    @card.user_id = current_user.id
    begin
      @card.no = Card.where(user_id: current_user.id).maximum(:no) + 1
    rescue
      @card.no = 1
    end
    @card.total_answers = 0
    @card.good_answers = 0

    if @card.save
      render json: @card.to_json()
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
