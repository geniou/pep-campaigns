class Question
  class Text < Question

    def self.model_name
      Question.model_name
    end

    def input_element
      [:text_value, {
        label: text,
        as: :text,
        required: true
      }]
    end
  end
end
