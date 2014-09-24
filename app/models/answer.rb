class Answer < ActiveRecord::Base
    belongs_to :card, foreign_key: :card_no
    after_create :update_card_status

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
