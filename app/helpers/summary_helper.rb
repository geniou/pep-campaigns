module SummaryHelper

  def summary_number(number)
    css_class = 'rate important' if number > 3.5
    content_tag(:span, class: css_class) do
      number_with_precision(number)
    end
  end
end
