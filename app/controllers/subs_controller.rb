class SubsController < ApplicationController

  before_action :ensure_moderator, only: [:edit, :update, :destroy]

  def new
    @sub = Sub.new
    5.times { @sub.links.build }
    render :new
  end

  def create
    @sub = current_user.subs.new(sub_params)
    new_links = @sub.links.new(link_params)
    new_links.each { |link| link.submitter_id = current_user.id }
    if @sub.save
      redirect_to sub_url(@sub)
    else
      (5 - @sub.links.length).times { @sub.links.build }
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def index
    @subs = Sub.all
    render :index
  end

  def destroy
    @sub = Sub.find(params[:id])
    @sub.try(:destroy)
    redirect_to root_url
  end

  private

  def sub_params
    params.require(:sub).permit(:name)
  end

  def link_params
    params.permit(links: [:title, :url, :text])
      .require(:links)
      .values
      .reject { |param| param.values.all?(&:blank?) }
  end

  def ensure_moderator
    sub = Sub.find(params[:id])
    unless sub.moderator == current_user
      flash[:errors] = ["You are not the moderator for this sub"]
      redirect_to sub_url(sub)
    end
  end
end
