import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.sound.*; 
import java.awt.FileDialog; 
import java.awt.Frame; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class pngtube extends PApplet {




AudioIn in;
Amplitude amp;

int W_W = 1920;
int W_H = 1080;

PImage img1;
PImage img2;
PImage curImg;

PImage g;
PImage h;

boolean glasses = false;
int glassesTime = 0;
boolean hat = false;
int hatTime = 0;

int randChance = PApplet.parseInt(random(0,5));
int lastTime = 0;
boolean canChange = true;

boolean speaking = false;

boolean hasFocus = true;

Button idle;
Button talking;

float NOISE_THRESHOLD = 10;

public void setup(){
  imageMode(CENTER);
  rectMode(CENTER);
  textAlign(CENTER);
  in = new AudioIn(this, 0);
  in.start();
  amp = new Amplitude(this);
  amp.input(in);
  g = loadImage("g.png");
  h = loadImage("hat.png");
  img1 = loadImage("0.png");
  img2 = loadImage("1.png");
  curImg = img1;
  float[] icoor = {W_W-100,100};
  float[] tcoor = {W_W-100,200};
  idle = new Button(icoor,"button1");
  talking = new Button(tcoor,"button2");
  
}

public void chooseRandom(){
  randChance = PApplet.parseInt(random(0,5));
}

public void newChoice(){
  if(millis()-lastTime>=1000 && canChange){
    chooseRandom();
    lastTime = millis();
  }
  if(randChance==3){
    glasses = true;
    glassesTime++;
    canChange = false;
  }else{
    glassesTime = 0;
  }
  if(glassesTime>=1000){
    canChange = true;
    glasses = false;
  }
  
  if(randChance==2){
    hat = true;
    hatTime++;
    canChange = false;
  }else{
    hatTime = 0;
  }
  if(hatTime>=1000){
    canChange = true;
    hat = false;
  }
}

public void drawGlasses(float x, float y, float w, float h){
  if(!glasses) return;
  image(g,x,y,w,h);
}

public void drawHat(float x, float y, float w, float hh){
  if(!hat) return;
  image(h,x,y,w,hh);
}

public void draw(){
  background(0xff00ff00);
  drawPixil();
  newChoice();
  idle.update();
  idle.show();
  talking.update();
  talking.show();
  handleClick();
}

public void openFile1(){
  try{
    Frame f = new Frame("Img Chooser");
    FileDialog d = new FileDialog((f),"Select file",0);
    d.setDirectory(this.sketchPath());
    d.setFile(".png");
    d.setMultipleMode(false);
    d.toFront();
    d.setMode(FileDialog.LOAD);
    d.setVisible(true);
    if (d.getFile() != null) {
      String file = d.getDirectory()+d.getFile();
      img1 = loadImage(file);
    }
    d.removeNotify();
    frame.removeNotify();
    d.dispose();
    f.dispose();
  }catch(Exception e){
    e.printStackTrace();
  }
}

public void openFile2(){
  Frame f = new Frame("Img Chooser");
  FileDialog d = new FileDialog((f),"Select file",0);
  d.setDirectory(this.sketchPath());
  d.setFile(".png");
  d.setMultipleMode(false);
  d.toFront();
  d.setMode(FileDialog.LOAD);
  d.setVisible(true);
  if (d.getFile() != null) {
    String file = d.getDirectory()+d.getFile();
    img2 = loadImage(file);
  }
  d.removeNotify();
  frame.removeNotify();
  d.dispose();
  f.dispose();
}

public void handleClick(){
  if(idle.clicked){
    openFile1();
    idle.clicked = false;
  }
  if(talking.clicked){
    openFile2();
    talking.clicked = false;
  }
}

public void drawPixil(){
  float level = amp.analyze();
  float b = level*1000;
  float anim = sin(frameCount*0.06f)*b;
  float xx = W_W/2;
  float yy = b+W_H/2;
  float ww = curImg.width; // anim-curImg.width; if you want the anim.
  float hh = curImg.height;
  if(b>NOISE_THRESHOLD){
    speaking = true;
  }else{
    speaking = false;
  }
  if(speaking){
    curImg = img2;
  }else{
    curImg = img1;
  }
  image(curImg,xx,yy,ww,hh);
  drawGlasses(xx,yy,ww+50,hh/2);
  drawHat(xx,yy-300,ww/2,hh/2);
}

public void keyPressed(){
  if(key=='h') hat = !hat;
  if(key=='g') glasses = !glasses;
}

public void mouseExited(){
  hasFocus = false;
  println("HI.");
}

public void mouseEntered(){
  hasFocus = true;
}
class Button{
  float[] coor;
  boolean clicked = false;
  String title;
  
  public Button(float[] _coor, String t){
    coor = _coor;
    title = t;
  }
  
  public boolean onButton(){
    return dist(mouseX,mouseY,coor[0],coor[1])<50;
  }
  
  public void update(){
    if(mousePressed && onButton()){
      clicked = true;
    }
  }
  
  public void show(){
    if(!hasFocus) return;
    fill(255);
    rect(coor[0],coor[1],textWidth(title)+10,50);
    fill(0);
    text(title,coor[0],coor[1]);
  }
}
  public void settings() {  size(1920,1080,P2D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "pngtube" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
