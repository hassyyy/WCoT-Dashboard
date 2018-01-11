class ResourcesController < ApplicationController
  before_filter :requires_login

  def new
    @resource = Resource.new
  end

  def create
    @resource = Resource.new(params[:resource])
    if @resource.save
      redirect_to @resource
    else
      render 'new'
    end
  end

  def index
    @resources = Resource.order(:id).paginate(page: params[:page], :per_page => 10)
  end

  def show
    @resource = Resource.find(params[:id])
  end

  def edit
    unless request.referrer.nil?
      store_location(request.referrer) if request.referrer.end_with? resources_path
    end
    @resource = Resource.find(params[:id])
  end

  def update
    @resource = Resource.find(params[:id])
    if @resource.update_attributes(params[:resource])
      flash[:success] = "Resources updated!"
      redirect_back_or @resource
    else
      render 'edit'
    end
  end
end
