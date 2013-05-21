class AddHideOnSummaryToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :hide_on_summary, :boolean, default: false, nil: false
  end
end
