class CardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_card, only: [:show, :edit, :update, :destroy]

  # lottery const
  NUMBER_OF_TESTS = 5
  MAX_BEST_CARDS = 6
  MAX_EXT_CARDS = 1

  def index
    @cards = Card.where({user_id: current_user.id})
    render json: @cards.to_json()
  end

  # GET /cards/1
  def show
  end

  # GET /lottery
  def lottery
    draw_cards = Card.where({user_id: current_user.id, is_archive: false}).to_a.sample(NUMBER_OF_TESTS)
    ext_cards = Card.where.not({user_id: current_user.id}).to_a.sample(MAX_EXT_CARDS)
    ext_cards.each{ |ext_card|
      flg = false
      draw_cards.each{ |card|
        if card.original == ext_card.id
          flg = true
          break
        end
      }
      unless flg
        draw_cards.push(ext_card)
      end
    }

    cards_hash = draw_cards.to_a.sample(NUMBER_OF_TESTS).map{ |card|
      card_attr = card.attributes
      card_attr[:answers] = if not card.is_link?
                              Card.find(card.id).answers.order(rate: :desc,count: :desc,created_at: :asc).limit(MAX_BEST_CARDS).to_a
                            else
                              Card.find(card.original).answers.order(rate: :desc,count: :desc,created_at: :asc).limit(MAX_BEST_CARDS).to_a
                            end
      card_attr[:is_ext] = (card.user_id != current_user.id)
      card_attr
    }

    render json: cards_hash.to_json
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
      params.require(:card).permit(:no, :tag, :question, :answer, :comment, :is_archive, :is_link, :original)
    end
end
