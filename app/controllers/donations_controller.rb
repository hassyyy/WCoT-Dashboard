class DonationsController < ApplicationController

  before_filter :requires_login

  def new
    @resource = Resource.find(params[:resource])
    @new_donation = @resource.donations.build
  end

  def create
    @new_donation = Donation.new(params[:donation])
    if @new_donation.save
      redirect_to resource_path(Resource.find(@new_donation.resource_id))
    else
      render 'new'
    end
  end

  def index
  end

  def edit
    @donation = Donation.find(params[:id])
  end

  def update
    @donation = Donation.find(params[:id])
    if @donation.update_attributes(params[:donation])
      flash[:success] = "Donation updated!"
      redirect_to resource_path(Resource.find(@donation.resource_id))
    else
      render 'edit'
    end
  end

end
