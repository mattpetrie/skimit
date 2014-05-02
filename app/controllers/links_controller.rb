class LinksController < ApplicationController
  before_action :ensure_submitter, only: [:edit, :update, :destroy]

  def new
    @link = Link.new
    @comment = Comment.new
    @subs = Sub.all
    render :new
  end

  def create
    @link = current_user.links.new(link_params)
    if @link.save
      redirect_to link_url(@link)
    else
      @subs = Sub.all
      flash.now[:errors] = @link.errors.full_messages
      render :new
    end
  end

  def destroy
    @link = Link.find(params[:id])
    @link.try(:destroy)
    redirect_to root_url
  end

  def show
    @link = Link.find(params[:id]).decorate
    @comment = Comment.new
    render :show
  end

  def edit
    @link = Link.find(params[:id])
    @subs = Sub.all
  end

  def update
    @link = Link.find(params[:id])

    if @link.update_attributes(link_params)
      redirect_to link_url(@link)
    else
      @subs = Sub.all
      flash.now[:errors] = @link.errors.full_messages
      render :new
    end
  end

  private

  def link_params
    params.require(:link).permit(:title, :url, :text, sub_ids: [])
  end

  def submitter
    link = Link.find(params[:id])
    unless current_user == link.submitter
      flash[:errors] = ["You didn't submit this link"]
      redirect_to link_url(link)
    end
  end
end

