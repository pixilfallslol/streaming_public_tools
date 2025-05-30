float xPos = 0;
float yPos = 0;
float xVel = 5;
float yVel = 5;
int timeNotStarted = 0;
String text = "Stream starting soon!";
PImage img;
PFont font;
void setup(){
  img = loadImage("eeeeeee.png");
  font = loadFont("c.vlw");
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
  strokeText("Stream Starting Soon!", width/2, 50, color(255, 255, 255), color(0), 3, font);
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
