class AddFirstAdminUser < ActiveRecord::Migration
  def up
    Admin.create!(email:'pep@example.com', password: '123456')
  end

  def down
    admin = Admin.find_by_email('pep@example.com')
    admin.delete if admin
  end
end
