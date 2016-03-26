class Permission
  extend Forwardable

  def_delegators :user,
    :admin?,
    :borrower?,
    :lender?

  def initialize(user, controller, action)
    @user = user || User.new
    @controller = controller
    @action = action
  end

  def allow?
    case
    when admin?
      platform_admin_permissions
    when borrower?
      borrower_permissions
    when lender?
      lender_permissions
    else
      general_permissions
    end
  end

private
  def user
    @user
  end

  def controller
    @controller
  end

  def action
    @action
  end

  def platform_admin_permissions
    return true if controller == 'home' && action.in?(%w(index))
  end

  def borrower_permissions
    return true if controller == 'home' && action.in?(%w(index))
    return true if controller == 'mailing_list_emails' && action.in?(%w(create))
    return true if controller == 'users' && action.in?(%w(show))
    return true if controller == 'borrower/users' && action.in?(%w(show))
    return true if controller == 'sessions' && action.in?(%w(new create destroy))
    return true if controller == 'projects' && action.in?(%w(index show))
    return true if controller == 'orders' && action.in?(%w(new create index show thanks))
    return true if controller == 'categories' && action.in?(%w(show))
    return true if controller == 'carts' && action.in?(%w(show))
    return true if controller == 'cart_projects' && action.in?(%w(create destroy update))
    return true if controller == 'borrower/projects' && action.in?(%w(new create index update))
  end

  def lender_permissions
    return true if controller == 'home' && action.in?(%w(index))
    return true if controller == 'mailing_list_emails' && action.in?(%w(create))
    return true if controller == 'users' && action.in?(%w(show))
    return true if controller == 'sessions' && action.in?(%w(new create destroy))
    return true if controller == 'projects' && action.in?(%w(index show))
    return true if controller == 'orders' && action.in?(%w(new create index show thanks))
    return true if controller == 'categories' && action.in?(%w(show))
    return true if controller == 'carts' && action.in?(%w(show))
    return true if controller == 'cart_projects' && action.in?(%w(create destroy update))
    return true if controller == 'borrowers' && action.in?(%w(new create))
  end

  def general_permissions
    return true if controller == 'home' && action.in?(%w(index))
    return true if controller == 'mailing_list_emails' && action.in?(%w(create))
    return true if controller == 'users' && action.in?(%w(new create))
    return true if controller == 'borrower/users' && action.in?(%w(new create))
    return true if controller == 'sessions' && action.in?(%w(new create destroy))
    return true if controller == 'projects' && action.in?(%w(index show))
    return true if controller == 'orders' && action.in?(%w(checkout_user checkout_login))
    return true if controller == 'categories' && action.in?(%w(show))
    return true if controller == 'carts' && action.in?(%w(show))
    return true if controller == 'cart_projects' && action.in?(%w(create destroy update))
  end
end
