import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class users extends PApplet {



int W_W = 1920;
int W_H = 1080;

String[] users;

int lastReload = 0;

List<User> uls;

public void setup(){
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER);
  uls = new ArrayList<User>(0);
  reloadNow();
  
}

public void draw(){
  background(0xff00ff00);
  reloadFile();
  drawUsers();
}

public void reloadFile(){
  if(millis()-lastReload>=1500){
    println("RELOADED FILE!");
    reloadNow();
    lastReload = millis();
  }
}

public void reloadNow(){
  users = loadStrings("users.txt");
  if(users == null) return;
  for(int i = 0; i < users.length; i++){
    String data = users[i];
    if(data == null) continue;
    data = trim(data);
    if(data.length() == 0) continue;
    boolean exists = false;
    for(int j = 0; j < uls.size(); j++){
      if(uls.get(j).name.equals(data)){
        exists = true;
        break;
      }
    }
    if(!exists){
      User newUser = new User(data);
      uls.add(newUser);
    }
  }
  for(int i = uls.size()-1; i >= 0; i--){
    User cu = uls.get(i);
    boolean here = false;
    for(int j = 0; j < users.length; j++){
      String data = users[j];
      if(data == null) continue;
      data = trim(data);
      if(data.length() == 0) continue;
      if(cu.name.equals(data)){
        here = true;
        break;
      }
    }
    if(!here){
      uls.remove(i);
    }
  }
}

public void drawUsers(){
  fill(0xff);
  textSize(48);
  for(int i = 0; i < uls.size(); i++){
    User cu = uls.get(i);
    cu.update();
    cu.show();
  }
}
class User{
  float[] coor;
  String name;
  float targetX;
  float targetY;
  int lastChoose = 0;
  
  public User(String n){
    name = n;
    coor = new float[2];
    coor[0] = random(W_W);
    coor[1] = W_H-200;
    targetX = coor[0];
    targetY = coor[1];
  }
  
  public void newCoor(){
    targetX = random(W_W);
    targetY = coor[1];
  }
  
  public void update(){
    if(millis()-lastChoose>=1500){
      newCoor();
      lastChoose = millis();
    }
    coor[0]+=(targetX-coor[0])*0.01f;
    coor[1]+=(targetY-coor[1])*0.01f;
  }
  
  public void show(){
    text(name,coor[0],coor[1]);
  }
}
  public void settings() {  size(1920,1080,P2D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "users" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
