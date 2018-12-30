class ContributionsController < ApplicationController
  include ContributionsHelper
  
  before_filter :requires_login

  def create
    @contribution = current_user.contributions.build(params[:contribution])
    @contribution.month = Date.today.strftime("%b")
    @contribution.year = Date.today.strftime("%Y")
    @contribution.status = "submitted"
    if @contribution.save
      flash[:success] = "Contribution Submitted!"
      redirect_to current_user
    else
      @user = current_user
      @previous_contributions = @user.contributions.where("month != ? or year != ?", Date.today.strftime("%b"), Date.today.strftime("%Y")).paginate(page: params[:page], :per_page => 10)
      @new_contribution = @contribution
      render 'users/show'
    end
  end

  def update
    store_location(request.referrer)
    @contribution = Contribution.find(params[:id])
    @contribution.update_attributes(status: "sent")
    send_received_email(@contribution)
    redirect_back_or @contribution.user
  end

  def index
    if request.xhr?
      @contributions_of_month = Contribution.where(:month => params[:month], :year => params[:year])
      @total_contributions_of_month = Contribution.where(:month => params[:month], :year => params[:year], :status => "sent").sum(:value)
      render partial: 'contributions_of_month'
    else
      @contributions_of_month = Contribution.where(:month => Time.now.getlocal("+05:30").strftime("%b"), :year => Time.now.getlocal("+05:30").strftime("%Y"))
      @total_contributions_of_month = Contribution.where(:month => Time.now.getlocal("+05:30").strftime("%b"), :year => Time.now.getlocal("+05:30").strftime("%Y"), :status => "sent").sum(:value)
      @donations = Donation.all.paginate(page: params[:page], :per_page => 5)
      render 'index'
    end
  end

end
