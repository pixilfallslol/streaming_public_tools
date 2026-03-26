import processing.sound.*;
import java.awt.FileDialog;
import java.awt.Frame;
AudioIn in;
Amplitude amp;

int W_W = 1920;
int W_H = 1080;

PImage img1;
PImage img2;
PImage curImg;

PImage g;
PImage h;
PImage headphones;
PImage processing;
PImage cat;

int active = 0;
int lastTime = 0;

boolean speaking = false;

boolean hasFocus = true;

float NOISE_THRESHOLD = 10;

float imageW;
float imageH;

void setup(){
  imageMode(CENTER);
  rectMode(CENTER);
  textAlign(CENTER);
  in = new AudioIn(this, 0);
  in.start();
  amp = new Amplitude(this);
  amp.input(in);
  g = loadImage("g.png");
  h = loadImage("hat.png");
  headphones = loadImage("phones.png");
  processing = loadImage("Processing_3_logo.png");
  cat = loadImage("giphy_s.gif");
  img1 = loadImage("0.png");
  img2 = loadImage("1.png");
  curImg = img1;
  imageW = curImg.width;
  imageH = curImg.height;
  size(1920,1080,P2D);
}

void newChoice(){
  if(millis()-lastTime>=10000){
    active = int(random(0,13));
    lastTime = millis();
  }
}

void draw(){
  background(0xff00ff00);
  drawPixil();
  newChoice();
}

void drawPixil(){
  float level = amp.analyze();
  float b = level*300;
  float xx = W_W/2;
  float yy = b+W_H/2;
  speaking = b>NOISE_THRESHOLD;
  if(speaking){
    curImg = img2;
  }else{
    curImg = img1;
  }
  image(curImg,xx,yy,imageW,imageH);
  if(active==1) image(g,xx,yy,imageW+50,imageH/2);
  if(active==2) image(h,xx,yy-300,imageW/2,imageH/2);
  if(active==3) image(headphones,xx,yy-60,imageW+100,imageH/2);
  if(active==4) image(processing,xx+160,yy+200,imageW/6-70,imageH/6);
  if(active==5) image(cat,xx,yy-200,imageW-100,imageH-100);
}

void mouseExited(){
  hasFocus = false;
  println("HI.");
}

void mouseEntered(){
  hasFocus = true;
}
