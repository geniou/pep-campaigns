class Question
  class Rate < Question

    def input_element
      [:numeric_value, {
        label: text,
        as: :radio,
        collection: (1..5).map{ |i| [i, i.to_f] },
        wrapper_html: { class: 'rate'},
        required: true,
      }]
    end
  end
end
