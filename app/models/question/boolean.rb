class Question
  class Boolean < Question

    def self.model_name
      Question.model_name
    end

    def field_name
      :boolean_value
    end

    def input_type
      :boolean
    end

    def summary_type
      :percentage
    end

    def summary(answers)
      {
        percentage: percentage,
        answers: answers.where(boolean_value: true)
      }
    end

    def formatted_value(value)
      I18n.t("question.boolean.#{value ? 'is_true' : 'is_false'}")
    end

    private

    def percentage
      answers.any? ? answers.average('boolean_value::int') * 100 : nil
    end
  end
end
