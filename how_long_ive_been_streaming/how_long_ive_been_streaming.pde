color BG_COLOR = color(99,57,17);

int hours = 0;
int minutes = 0;
int seconds = 0;
int days = 0;
int timeBeforeNextSecond = 0;

PFont font;

void setup(){
  font = loadFont("ComicSansMS-48.vlw");
  size(1170,347);
}

void draw(){
  background(BG_COLOR);
  timeBeforeNextSecond++;
  if(timeBeforeNextSecond == 2){
    seconds += 1;
    timeBeforeNextSecond = 0;
  }
  if(seconds == 60){
    minutes += 1;
    seconds = 0;
  }
  if(minutes == 60){
    hours += 1;
    minutes = 0;
  }
  fill(255);
  strokeText(str(hours)+"hr "+str(minutes)+"m "+str(seconds)+"s",100,250,color(255,255,255),color(0),5,font,200);
  println("next second "+timeBeforeNextSecond);
  println("seconds "+seconds);
  println("minutes "+minutes);
  println("hours "+hours);
}

void strokeText(String txt,float x,float y,color fillColor,color strokeColor,int thickness,PFont font,int ts){
  fill(strokeColor);
  textFont(font);
  textSize(ts);
  for(int i = -thickness; i <= thickness; i++){
    for(int j = -thickness; j <= thickness; j++){
      if(i != 0 || j != 0){
        text(txt,x+i,y+j);
      }
    }
  }
  fill(fillColor);
  text(txt,x,y);
}
