module SpecAdmin

  def admin_exists_and_is_logged_in
    create(:admin).tap do |admin|
      visit '/admin'
      fill_in 'admin_email', with: admin.email
      fill_in 'admin_password', with: admin.password
      click_button('Sign in')
    end
  end
end
