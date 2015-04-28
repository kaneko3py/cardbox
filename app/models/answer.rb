class Answer < ActiveRecord::Base
    belongs_to :card
    before_create :check_card_link
    after_create :update_card_status

    private
    def check_card_link
        card = Card.find(card_id)
        if card.is_link?
            self.card_id = card.original
        end
    end

    def update_card_status
        card = Card.find(card_id)

        # 回答回数を記録
        card.good_answers += 1 if rate >= 4
        card.total_answers += 1

        # もし★5で、cardのanswerが未設定なら上書き
        card.answer = answer if (rate >= 5 && card.answer == "")

        card.save()
    end

end
