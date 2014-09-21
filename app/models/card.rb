class Card < ActiveRecord::Base
    has_one  :activity
    has_many :answers
    after_create :create_answer
    after_create :create_activity

    def create_activity
        activity = Activity.new({card_id: id, good_answers: 0, total_answers: 0})
        activity.save()
    end

    def create_answer
        if answer
            _answer = Answer.new({card_id: id, answer: answer, rate: 5})
            _answer.save()
        end
    end
end
