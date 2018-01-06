class StaticPagesController < ApplicationController
  before_filter :requires_login,     only: [:home, :help]

  def home
  end

  def help
  end

  def about
  end
end
