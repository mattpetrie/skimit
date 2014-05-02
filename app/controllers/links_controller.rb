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

  def upvote
    vote(1)
  end

  def downvote
    vote(-1)
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

  def vote(dir)
    @link = Link.find(params[:id])
    @user_vote = UserVote.find_by_link_id_and_user_id(@link.id, current_user.id)

    if @user_vote
      if @user_vote.value == dir 
        @user_vote.update_attributes(value: 0)
      else
        @user_vote.update_attributes(value: dir)
      end
    else
      @link.user_votes.create(user: current_user, value: dir)
    end

    redirect_to @link
  end
end

