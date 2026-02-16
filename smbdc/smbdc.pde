int W_W = 565;
int W_H = 201;

PFont font;

PImage meat;

String[] data;
int count = 0;
int lastCount;
int lastReload = 0;
int TICKS_PER_RELOAD = 500;

int anim = 0;

void setup(){
  imageMode(CENTER);
  textAlign(CENTER);
  meat = loadImage("base.png");
  font = createFont("meat.ttf",48);
  reloadNow();
  size(565,201,P2D);
}

void draw(){
  background(0xff00);
  reloadData();
  drawBG();
  drawData();
}

void drawBG(){
  image(meat,W_W/2,W_H/2);
}

void reloadData(){
  if(millis()-lastReload>=TICKS_PER_RELOAD){
    reloadNow();
    if(lastCount<count){
      anim = 50-(anim/3);
    }
    lastReload = millis();
  }
}

void reloadNow(){
  data = loadStrings("count.txt");
  if(data == null) return;
  lastCount = count;
  count = int(data[0]);
}

void drawData(){
  if(data == null) return;
  anim*=0.9;
  textFont(font);
  fill(0xff);
  text("Deaths: "+count,W_W/2,anim+W_H-50);
}
