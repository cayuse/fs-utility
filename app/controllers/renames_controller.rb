class RenamesController < ApplicationController
before_filter :authenticate_user!, :except => :show
  def show
    #a,b,c,d = request.remote_ip.split(".")
    sitenum = params[:site].to_i
    @site = Site.where(number: sitenum).first
    @site ||= Site.first
    num = params[:line].to_i

    @identity = @site.identity
    @number = sprintf "%02d", num
    fullname = "ana#{@identity}lin#{@number}"
    #system "cd /home/shared/renamer/public/images"

    system ("cd /var/www/fs-utility/public/system/renamers; convert test.jpg -gravity south -font Courier -pointsize 80  -fill white -annotate 0,0,0,60 \'#{fullname}\' -channel rgba -matte bmp3\:#{fullname}.bmp")
    respond_to do |format|
      format.txt
    end
  end

end
