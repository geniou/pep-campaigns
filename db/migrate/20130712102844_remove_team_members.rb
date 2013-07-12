class RemoveTeamMembers < ActiveRecord::Migration
  def up
    drop_table :team_members
  end

  def down
    create_table :team_members do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :role
      t.timestamps
    end
  end
end
