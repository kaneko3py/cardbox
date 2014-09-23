class Card < ActiveRecord::Base
    has_many :answers
    before_save :calc_reliability
    after_create :create_answer
    after_create :create_tag

    private
    def calc_reliability
        self.reliability = case
           when total_answers < 5 then "-"
           when (good_answers / total_answers > 0.9) then "A"
           when (good_answers / total_answers > 0.8) then "B"
           when (good_answers / total_answers > 0.7) then "C"
           when (good_answers / total_answers > 0.5) then "D"
           else "E"
        end
    end

    def create_answer
        if answer
            _answer = Answer.new({card_id: id, answer: answer, rate: 5})
            _answer.save()
        end
    end

    def create_tag
        if tag
            tag.split(" ").each{ |tag_str|
                _tag = Tag.new({user_id: user_id, tag: tag_str})
                _tag.save()
            }
        end
    end
end
