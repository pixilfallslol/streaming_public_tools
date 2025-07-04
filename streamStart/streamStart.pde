import processing.sound.*;

float xPos = 0;
float yPos = 0;
float xVel = 5;
float yVel = 5;
String text = "Stream starting soon!";
PImage img;
PFont font;
boolean drawCountdown = false;
int time = 0;
String finishSound = "ding.wav";
SoundFile sfx;
int previousMillis = 0;
int seconds = 0;
int minutes = 0;
int hours = 0;
int count1 = 5;

String timeStr(String n){
    int intN = int(n);
    int sec1 = intN%10;
    int sec10 = (intN/10)%6;
    int min1 = (intN/60)%10;
    int min10 = (intN/600)%6;
    int hrs = intN/3600;
    if(intN == 0){
        return "any moment";
    }
    else if(hrs >= 24){
        return "a long time";
    }
    else if(hrs >= 1){
        return str(hrs)+":"+str(min10)+str(min1)+":"+str(sec10)+str(sec1);
    }
    else if(min10 >= 1){
        return str(min10)+str(min1)+":"+str(sec10)+str(sec1);
    }
    else{
        return str(min1)+":"+str(sec10)+str(sec1);
    }
}

void setup(){
  img = loadImage("eeeeeee.png");
  font = createFont("OpenSans-CondLight.ttf",48);
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
  fill(0);
  textFont(font);
  text(text,width/2,50);
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
    drawCountdown = false;
  }
}
