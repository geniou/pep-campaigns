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
      answers.average('boolean_value::int') * 100
    end
  end
end
