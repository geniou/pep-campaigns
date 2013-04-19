class AddApplicantIntroductionTextToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :applicant_introduction_text, :text, null: true
  end
end
