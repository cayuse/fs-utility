class RenamesController < ApplicationController
skip_before_action :authenticate_user!


  def index
  respond_to do |format|
      format.html do
      render :layout => false
      end
  end

  end

#"symbol"=>{"site"=>"20", "line"=>"2", "wide"=>"0"}, "commit"=>"Save Symbol", "id"=>"1"}

  def show
    #a,b,c,d = request.remote_ip.split(".")
    sitenum = params[:site]
    sitenum ||= params[:symbol][:site]
    sitenum = sitenum.to_i
    @site = Site.where(number: sitenum).first
    @site ||= Site.first
    num = params[:line]
    wide = params[:wide]
    
    num ||= params[:symbol][:line]
    wide ||= params[:symbol][:wide]
    
    num = num.to_i
    wide = wide.to_i
    
    @identity = @site.identity
    @number = sprintf "%02d", num
    fullname = "#{@identity} line #{@number}"
    @filename = fullname.gsub(" ","")
    #system "cd /home/shared/renamer/public/images"

    if wide == 1
      system ("cd /var/www/fs-utility/public/system/renamers; convert wide.png -gravity south -font Courier -pointsize 80  -fill white -annotate 0,0,0,60 \'#{fullname}\' -channel rgba -matte bmp3\:#{@filename}.bmp")
    else
      system ("cd /var/www/fs-utility/public/system/renamers; convert square.png -gravity south -font Courier -pointsize 80  -fill white -annotate 0,0,0,60 \'#{fullname}\' -channel rgba -matte bmp3\:#{@filename}.bmp")
    end
    redirect_to "http://172.16.1.118/system/renamers/#{@filename}.bmp"
   
  end

end
