class VideosController < ApplicationController

  def upload

    s3 = Aws::S3::Resource.new
    bucket = s3.bucket(ENV['AWS_S3_BUCKET'])
    url = SecureRandom.uuid + "/" + params[:video].original_filename
    obj = bucket.object(url)
    obj.put(body: params[:video])

    video = Video.create(
      title: params["title"],
      description: params["description"],
      user_id: session[:user_id],
      url: url
    )

    if video
      render json: {
        status: :created,
        video: video
      }
    else
      render json: {
        status: 500
      }
    end
  end

  # return all videos in db

  def all_videos
    videos = Video.all

    if videos
      render json: {
        videos: videos
      }
    else
      render json:{
        status: 500
      }
    end
  end

  # return all videos from session user id

  def user_videos
    if params[:user_id] == session[:user_id]
      videos = Video.where(user_id: session[:user_id])
    end
    if videos
      render json: {
        videos: videos
      }
    else
      render json:{
        status: 500
      }
    end
  end

  # get video from s3 by video id

  def get_video
    video = Video.find(params[:video_id])
    if video
      render json: {
        videos: video
      }
    else
      render json:{
        status: 500
      }
    end
  end

  # delete video from s3 and db, takes video id

  def destroy
    video = Video.find(params[:video_id])
    if params[:user_id] == session[:user_id] && params[:user_id] == video.user_id
      s3 = Aws::S3::Resource.new
      bucket = s3.bucket(ENV['AWS_S3_BUCKET'])
      obj = bucket.object(video.url)
      obj.delete
      video.destroy
      render json: {
        video_deleted: true
      }
    else
      render json: {
        video_deleted: false
      }
    end
  end
end