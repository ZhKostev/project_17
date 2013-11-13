module SignInHelper
  def sign_in_admin
    admin = AdminUser.find_by_email('admin@admin.com') || FactoryGirl.create(:admin_user, :email => 'admin@admin.com')
    sign_in admin
  end
end
