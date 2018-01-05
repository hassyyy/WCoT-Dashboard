class ContributionsController < ApplicationController
  before_filter :requires_login

  def create
    @contribution = current_user.contributions.build(params[:contribution])
    @contribution.status = "submitted"
    if @contribution.save
      flash[:success] = "Contribution Submitted!"
      redirect_to current_user #redirect to feed after it's deceloped
    else
      @user = current_user
      @contributions = @user.contributions.paginate(page: params[:page], :per_page => 10)
      @new_contribution = @contribution
      render 'users/show'
    end
  end

  def update
    @contribution = Contribution.find(params[:id])
    @contribution.update_attributes(status: "sent")
    redirect_to @contribution.user
  end

  def destroy
  end
end
