class Export::Base

  def to_csv
    CSV.generate(col_sep: ";", force_quotes: true) do |csv|
      data(csv)
    end
  end
end
