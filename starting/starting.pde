int W_W = 1900;
int W_H = 1080;

PImage hg;
PImage art;

color c1 = color(96, 171, 247);
color c2 = color(64, 154, 245);
int[] DIMS = {20,20};
int MARGIN = 100;
int CELL_SIZE = 100;

PFont f;

int time = 5*60;
int startTime;

boolean flipping = false;
boolean doneAlready = false;
int fs = 0;
int fd = 900;
float rot = 0;
float SPEED = 2000;

boolean canDown = false;

void setup(){
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER);
  noStroke();
  f = createFont("OpenSans-CondBold.ttf",48);
  textFont(f);
  art = loadImage("art.png");
  hg = loadImage("glass.png");
  size(1900,1080,P2D);
}

void draw(){
  background(0xff);
  drawTiles();
  drawPixil();
  if(!canDown) return;
  drawHourGlass();
  drawTimer();
}

void drawTiles(){
  rectMode(BASELINE);
  for(int r = 0; r < DIMS[0]; r++){
    for(int c = 0; c < DIMS[1]; c++){
      if((r%2) == (c%2)){
        fill(c1);
      }else{
        fill(c2);
      }
      int xx = 0+c*MARGIN;
      int yy = 0+r*MARGIN;
      rect(xx,yy,CELL_SIZE,CELL_SIZE);
    }
  }
  rectMode(CENTER);
}

void drawPixil(){
  float animsin = sin(frameCount*0.06)*6;
  float animcos = cos(frameCount*0.06)*6;
  float xx = W_W-300;
  float yy = W_H-250;
  float w = animsin+art.width;
  float h = animcos-art.height;
  image(art,xx,yy,w,h);
}

void drawTimer(){
  float animsin = sin(frameCount*0.05)*6;
  int elapsed = (millis()-startTime)/1000;
  int rem = max(0,time-elapsed);
  int minutes = rem/60;
  int seconds = rem%60;
  String msg = "Stream starting in "+timeStr(minutes,seconds);
  fill(255);
  textSize(48+animsin);
  if(rem<=0){
    msg = "Waiting for pixil..";
  }
  text(msg,W_W/2,W_H/2);
}

void drawHourGlass(){
  float animsin = sin(frameCount*0.05)*6;
  float elapsed = (millis()-startTime)/1000.0;
  float rem = max(0,time-elapsed);
  if(rem>0){
    rot = elapsed*1.5;
  }else{
    rot = 0;
  }
  pushMatrix();
  translate(W_W/2,W_H/2);
  rotate(rot);
  image(hg,0,0,hg.width+animsin,hg.height+animsin);
  popMatrix();
}

String timeStr(int m, int s){
  return nf(m,1)+":"+nf(s,2);
}

void keyPressed(){
  if(key == 's') canDown = true; startTime = millis();
}
