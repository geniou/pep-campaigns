class Question
  class Rate < Question

    def input_element
      [:numeric_value,
        { label: text,
          as: :radio,
          collection: [1,2,3,4,5],
          wrapper_html: { class: 'rate'}
        }
      ]
    end
  end
end
