class Question
  class Text < Question

    def input_element
      [:text_value, {
        label: text,
        as: :text,
        required: true
      }]
    end
  end
end
