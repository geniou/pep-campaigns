class Question
  class Select < Question

    def self.model_name
      Question.model_name
    end

    def field_name
      :text_value
    end

    def input_type
      :radio
    end

    def summary_type
      :key_value
    end

    def summary(answers)
      Answer
        .select("text_value, count(*) as count")
        .where("text_value IS NOT NULL and id IN (?)", answers)
        .group(:text_value).map { |a|
          [a.text_value, a.count.to_i ]
        }
    end
  end
end
