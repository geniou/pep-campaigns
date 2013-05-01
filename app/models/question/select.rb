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
  end
end
