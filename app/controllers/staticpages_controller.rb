class StaticpagesController < ApplicationController
  require 'flickr'
  def index
    begin
      flickr = Flickr.new ENV["flikr_key"], ENV["flikr_secret"]
    unless params[:user_id].blank?
      begin
      @photos = flickr.people.getPhotos :user_id => params[:user_id]
      rescue Flickr::FlickrError => e
        handle_standard_error(e)
      end
    else
      @photos = flickr.photos.getRecent
    end
    rescue StandardError => e
      handle_standard_error(e)
    end
  end

  def handle_standard_error(error)
    flash[:alert] = "#{error.class}: #{error.message}"
    redirect_to root_path
  end
end
