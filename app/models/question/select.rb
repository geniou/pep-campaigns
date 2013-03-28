class Question
  class Select < Question
    serialize :options, Array

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
