import java.util.*;

int W_W = 1920;
int W_H = 1080;

String[] users;

int lastReload = 0;

List<User> uls;

void setup(){
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER);
  uls = new ArrayList<User>(0);
  reloadNow();
  size(1920,1080,P2D);
}

void draw(){
  background(0xff00ff00);
  reloadFile();
  drawUsers();
}

void reloadFile(){
  if(millis()-lastReload>=1500){
    println("RELOADED FILE!");
    reloadNow();
    lastReload = millis();
  }
}

void reloadNow(){
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

void drawUsers(){
  fill(0xff);
  textSize(48);
  for(int i = 0; i < uls.size(); i++){
    User cu = uls.get(i);
    cu.update();
    cu.show();
  }
}
