class AnswersController < ApplicationController
  before_action :required_login

  # POST /cards
  def create
    @answer = Answer.new(answer_params)
    @answer.user_id = @current_user.id

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
