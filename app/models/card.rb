class Card < ActiveRecord::Base
    has_many :answers
    before_save :calc_reliability
    before_update :update_tag
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
                if Tag.where({user_id: user_id, tag: tag_str}).count() == 0
                    _tag = Tag.new({user_id: user_id, tag: tag_str})
                    _tag.save()
                end
            }
        end
    end

    def update_tag
        _card = Card.find(id)
        return if _card.tag == tag

        card_tags = tag.split(" ")
        prv_card_tags = _card.tag.split(" ")
        user_tags = Tag.where({user_id: user_id})

        # 追加があればInsert
        (card_tags - prv_card_tags - user_tags).each{ |tag_str|
            if Tag.where({user_id: user_id, tag: tag_str}).count() == 0
                _tag = Tag.new({user_id: user_id, tag: tag_str})
                _tag.save()
            end
        }

        # 消えていて、かつ他のCardにもなさそうだったらDelete
        (prv_card_tags - card_tags).each{ |tag_str|
            if Card.where("user_id = ? and ' '||tag||' ' like ?", user_id, "% #{tag_str} %").count() == 1
                _tag = Tag.where({user_id: user_id, tag: tag_str}).first()
                _tag.destroy()
            end
        }
    end
end
