import processing.sound.*;

float xPos = 0;
float yPos = 0;
float xVel = 5;
float yVel = 5;
String text = "Stream starting soon!";
PImage img;
PFont font;
boolean drawCountdown = true;
int previousMillis = 0;
int seconds = 0;
int minutes = 0;
int hours = 0;
int count1 = 5;
String finishSound = "ding.wav";
SoundFile sfx;
void setup(){
  img = loadImage("eeeeeee.png");
  font = loadFont("c.vlw");
  sfx = new SoundFile(this,finishSound);
  size(1920,1080);
}

void draw(){
  background(255);
  yPos += yVel;
  xPos += xVel;
  if(xPos>1920-100){
    xVel = -5;
    tint(random(0,255),random(0,255),random(0,255));
  }else if(xPos<0+25){
    xVel = 5;
    tint(random(0,255),random(0,255),random(0,255));
  }
  if(yPos>1080-200){
    yVel = -5;
    tint(random(0,255),random(0,255),random(0,255));
  }else if(yPos<0+25){
    yVel = 5;
    tint(random(0,255),random(0,255),random(0,255));
  }
  image(img,xPos,yPos,200,200);
  textAlign(CENTER,CENTER);
  strokeText(text, width/2, 50, color(255, 255, 255), color(0), 3, font);
  drawCountdown();
}

void strokeText(String txt,float x,float y,color fillColor,color strokeColor,int thickness,PFont font){
  fill(strokeColor);
  textFont(font);
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

void drawCountdown(){
  int currentMillis = millis();
  if(currentMillis-previousMillis >= 1000){
    previousMillis = currentMillis;
    seconds++;
    if(seconds == 60){
      minutes++;
      count1--;
      seconds = 0;
    }
    if(minutes == 60){
      hours++;
      minutes = 0;
    }
  }
  if(drawCountdown){
    strokeText(count1+":"+"0"+"0",width/2,100,color(255),color(0),3,font);
  }
  if(count1 == 0){
    sfx.play();
  }
}

void keyPressed(){
  if(key == 'r'){
    text = "Stream ending byee!";
    drawCountdown = false;
  }
  if(key == 's'){
    text = "Stream starting soon!";
    drawCountdown = true;
  }
}
