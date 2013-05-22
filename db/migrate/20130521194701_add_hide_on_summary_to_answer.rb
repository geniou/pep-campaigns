class AddHideOnSummaryToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :hide_on_summary, :boolean, default: false, nil: false
  end
end
