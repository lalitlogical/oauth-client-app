class ShortUrlsController < ApplicationController
  def create
    short_url = ShortUrl.find_or_create_by(original_url: params[:original_url])
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Your shorten url: #{short_url_url(short_url.short_code)}" }
      format.json { render json: { short_url: short_url_url(short_url.short_code) }, status: :created }
    end
  end

  def show
    short_url = ShortUrl.find_by!(short_code: params[:code])
    short_url.increment!(:clicks)
    redirect_to short_url.original_url, allow_other_host: true
  end
end
