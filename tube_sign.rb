require 'sinatra'
require 'RMagick'
include Magick

get '/' do
  erb :index
end

get '/list' do

  Dir.chdir("public/cache") do
    @signs = Dir.glob('*.png').sort{|a,b| File.mtime(b) <=> File.mtime(a)}
  end
  @count = @signs.size
  @signs = @signs[0..49]

  erb :list
end 

get '/image.png' do

date = params[:date] || nil
time = params[:time] || nil
text = params[:text].values.delete_if {|a|a.empty?}

filename = File.join("public/cache", Digest::MD5.hexdigest(params.to_s)+".png")

unless File.exists? filename 
  # create image
  img = ImageList.new("tube_sign2.png") 
  draw = Draw.new

  draw.annotate(img, 0,0, 244, 220, date){
    self.font = 'fonts/Reenie_Beanie/ReenieBeanie.ttf'
    self.fill = 'black'
    self.stroke = 'transparent'
    self.pointsize = 40
    self.rotation = 4
  } unless date.empty?


  draw.annotate(img, 0,0, 264, 259, time){
    self.font = 'fonts/Reenie_Beanie/ReenieBeanie.ttf'
    self.fill = 'black'
    self.stroke = 'transparent'
    self.pointsize = 30
    self.rotation = 3
  } unless time.empty?

  y = 257
  text.each_with_index do | t, i |
    pointsize = 32 + [*-1..4].sample
    pointsize = 38 if i == 0
    
    bit = i>4 ? 35 : 44
    y = y+bit
    
    x_fudge  = [*-4..4].sample
    x = 170 + x_fudge
    draw.annotate(img, 0,0,x,y, t) {
      self.font = 'fonts/Reenie_Beanie/ReenieBeanie.ttf'
      self.fill = 'black'
      self.stroke = 'transparent'
      self.pointsize = pointsize
      self.rotation = [*0..3].sample
    }
  end
  # save image
  img.write(filename) do
    self.compression = Magick::ZipCompression
  end
  
else

  # load image
  img = ImageList.new(filename)
end

  #serve image
  content_type 'image/png'
  img.format = "png"
  img.to_blob
end
