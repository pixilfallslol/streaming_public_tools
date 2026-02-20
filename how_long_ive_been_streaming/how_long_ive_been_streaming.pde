color BG_COLOR = color(99,57,17);

int start;

PFont font;

void setup(){
  font = createFont("OpenSans-CondBold.ttf",48);
  start = millis();
  textAlign(CENTER);
  size(1170,347,P2D);
}

void draw(){
  background(BG_COLOR);
  int elapsed = (millis()-start)/1000;
  int seconds = elapsed%60;
  int minutes = (elapsed/60)%60;
  int hours = (elapsed/3600);
  fill(255);
  strokeText(str(hours)+"hr "+str(minutes)+"m "+str(seconds)+"s",width/2,height-100,color(255,255,255),color(0),5,font,200);
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
