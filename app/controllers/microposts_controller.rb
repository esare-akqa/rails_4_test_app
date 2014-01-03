class MicropostsController < ApplicationController
  before_action :signed_in_user

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = 'Micropost posted'
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      # render 'static_pages/home'
      flash[:error] = 'error with submitting'
      redirect_to root_path
    end
  end

  def destroy
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end
end