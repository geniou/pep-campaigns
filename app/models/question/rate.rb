class Question
  class Rate < Question

    def self.model_name
      Question.model_name
    end

    def field_name
      :numeric_value
    end

    def input_element
      [field_name, {
        label:        text,
        as:           :radio,
        collection:   (1..5).map{ |i| [i, i.to_f] },
        wrapper_html: { class: 'rate'},
        required:     required,
        hint:         hint
      }]
    end

    def summary_type
      :number
    end

    def summary(answers)
      answers.average(:numeric_value)
    end
  end
end
