class AnswersController < ApplicationController
  before_action :authenticate_user!

  # POST /cards
  def create
    sparams = answer_params
    if sparams[:answer] == ""
      render json: { status: :created, location: @answer }
      return
    end

    @answer = Answer.where(user_id: current_user.id, card_id: sparams[:card_id], answer: sparams[:answer]).first
    p @answer
    if @answer
      @answer.count = 0 unless @answer.count
      @answer.count += 1
    else
      @answer = Answer.new(sparams)
      @answer.user_id = current_user.id
      @answer.count = 1
    end

    if @answer.save
      render json: { status: :created, location: @answer }
    else
      render json: { status: :unprocessable_entity, errors: @answer.errors }
    end

  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:card_id, :answer, :rate)
    end

end
