class VideosController < ApplicationController
  before_action :set_video, only: [:show]

  respond_to :html

  def index
    @videos = Video.all
    @videos = Video.order('created_at DESC')
    respond_with(@videos)
  end

  def show
    respond_to do |format|
      format.js{}
    end
    # respond_with(@video)
  end


  def new
    @video = Video.new
    respond_with(@video)
  end


  def create
    @video = Video.new(video_params)
    if @video.save
      flash[:success] = 'Video added!'
      redirect_to videos_url
    else
      render :new
    end
  end


  private
    def set_video
      @video = Video.find(params[:id])
    end

    def video_params
      params.require(:video).permit(:link, :video, :artist_id)
    end
end
