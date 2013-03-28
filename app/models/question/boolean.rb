class Question
  class Boolean < Question

    def self.model_name
      Question.model_name
    end

    def input_element
      [:boolean_value, {
        label:    text,
        as:       :boolean,
        required: required
      }]
    end
  end
end
