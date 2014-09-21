class Activity < ActiveRecord::Base
    belongs_to :cards ,foreign_key: :card_id
    before_save :update_reliability

    private
    def update_reliability
        if total_answers < 5 then
            _reliability = "-"
        else
            _reliability = case
                           when (good_answers / total_answers > 90) then "A"
                           when (good_answers / total_answers > 80) then "B"
                           when (good_answers / total_answers > 70) then "C"
                           when (good_answers / total_answers > 50) then "D"
                           else "D"
                           end
        end

        self.reliability = _reliability
    end
end
