require 'rubygems'
require 'RMagick'
include Magick


date = "today"
time = "midday"

text = ["first line this and that", 
        "second line that and this",
        "third line", 
        "fourth line",
        "fith line",
        "sixth line", 
        "sevent line"]

img = ImageList.new("tube_sign.png") 

draw = Draw.new

draw.annotate(img, 0,0, 237, 285, date){
  self.font = '/home/tim/projects/tube_sign/fonts/Reenie_Beanie/ReenieBeanie.ttf'
  self.fill = 'black'
  self.stroke = 'transparent'
  self.pointsize = 40
  self.rotation = 4
} if date

draw.annotate(img, 0,0, 273, 330, time){
   self.font = '/home/tim/projects/tube_sign/fonts/Reenie_Beanie/ReenieBeanie.ttf'
  self.fill = 'black'
  self.stroke = 'transparent'
  self.pointsize = 30
  self.rotation = 3
} if time

y = 344
text.each_with_index do | t, i |
  pointsize = 32 + [*-1..4].sample
  pointsize = 38 if i == 0
  y = y+36
  draw.annotate(img, 0,0,160,y, t) {
  self.font = '/home/tim/projects/tube_sign/fonts/Reenie_Beanie/ReenieBeanie.ttf'
  self.fill = 'black'
  self.stroke = 'transparent'
  self.pointsize = pointsize
  self.rotation = [*-2..1].sample
}

end

img.display
