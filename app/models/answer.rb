class Answer < ActiveRecord::Base
    belongs_to :card, foreign_key: :card_no
    after_create :update_activity

    def update_activity
        _activity = Activity.find_by_card_id(card_id)
        return unless _activity
        _activity.good_answers += 1 if rate >= 4
        _activity.total_answers += 1
        _activity.save()
    end

end
