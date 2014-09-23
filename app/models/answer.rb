class Answer < ActiveRecord::Base
    belongs_to :card, foreign_key: :card_no
    after_create :update_card_status

    def update_card_status
        card = Card.find(card_id)
        card.good_answers += 1 if rate >= 4
        card.total_answers += 1
        card.save()
    end

end
