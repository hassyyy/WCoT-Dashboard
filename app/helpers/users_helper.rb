module UsersHelper
  def account_admin_email
    User.find_by_account_admin(true).email
  end
end
