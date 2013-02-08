class AddFirstAdminUser < ActiveRecord::Migration
  def up
    Admin.create!(email:'pep@example.com', password: '123456')
  end

  def down
    Admin.find_by_email('pep@example.com').delete
  end
end
