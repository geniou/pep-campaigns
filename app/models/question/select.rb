class Question
  class Select < Question

    def self.model_name
      Question.model_name
    end

    def input_element
      [:text_value, {
        label: text,
        as: :radio,
        collection: options,
        required: true
      } ]
    end
  end
end
