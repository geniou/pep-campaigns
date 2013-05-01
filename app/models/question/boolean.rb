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
  end
end
