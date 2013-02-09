class CreateTeamMembers < ActiveRecord::Migration
  def change
    create_table :team_members do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :role
      t.timestamps
    end
  end
end
