class StaticPagesController < ApplicationController
  before_filter :requires_login,     only: [:help]

  def help
  end
end
