class VideosController < ApplicationController

  def upload

    s3 = Aws::S3::Resource.new

    # reference an existing bucket by name
    bucket = s3.bucket(ENV['AWS_S3_BUCKET'])
    url = SecureRandom.uuid + "/" + params[:video].original_filename
    # enumerate every object in a bucket
    #bucket.objects.each do |obj|
     # puts "#{obj.key} => #{obj.etag}"
    #end

    # batch operations, delete objects in batches of 1k
    #bucket.objects(prefix: '/tmp-files/').delete

    # single object operations
    obj = bucket.object(url)
    obj.put(body: params[:video])
    #obj.etag
    #obj.delete


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
end