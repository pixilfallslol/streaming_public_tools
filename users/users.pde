import java.util.*; // For the ArrayList Util.

int W_W = 1920; // Screen Width.
int W_H = 1080; // Screen Height.

String[] users; // Stores the raw lines from the user file.

int lastReload = 0; // Stores the last time the file was reloaded.

List<User> uls; // A list of the User object.

void setup(){
  // Not sure if its a bad practice, but i just center everything by default.
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER);
  uls = new ArrayList<User>(0); // Creates an empty list of users.
  reloadNow(); // Reloads the file on startup.
  size(1920,1080,P2D); // Creates the window using the GPU.
}

void draw(){
  background(0xff00ff00); // Green background.
  reloadFile(); // Reloads the file.
  drawUsers(); // Draws the users.
}

void reloadFile(){
  // Reload the entire file if 1.5 seconds have passed and restarts.
  if(millis()-lastReload>=1500){
    println("RELOADED FILE!");
    reloadNow();
    lastReload = millis();
  }
}

void reloadNow(){
  // Reads the file into a string array and stops if the file doesnt exist.
  users = loadStrings("users.txt");
  if(users == null) return;
  for(int i = 0; i < users.length; i++){ // Gets every line from the file.
  // Skips null empty or whitespace lines.
    String data = users[i];
    if(data == null) continue;
    data = trim(data);
    if(data.length() == 0) continue;
    boolean exists = false; // Checks if user is already on screen.
    // Check if a User with the name already exists.
    for(int j = 0; j < uls.size(); j++){
      if(uls.get(j).name.equals(data)){
        exists = true;
        break;
      }
    }
    // If not found create a new User and display it.
    if(!exists){
      User newUser = new User(data);
      uls.add(newUser);
    }
  }
  // Checks if the user is no longer in the file and removes them.
  for(int i = uls.size()-1; i >= 0; i--){ // Loops backwards so removes dont break the index.
    // Tracks if the user still exists in the file.
    User cu = uls.get(i);
    boolean here = false;
    for(int j = 0; j < users.length; j++){ // Searches the file for the user.
      String data = users[j];
      if(data == null) continue;
      data = trim(data);
      if(data.length() == 0) continue;
      // If the user is found in the file they get to stay.
      if(cu.name.equals(data)){
        here = true;
        break;
      }
    }
    // But if they are not found they get removed.
    if(!here){
      uls.remove(i);
    }
  }
}

void drawUsers(){
  // Text color and text size.
  fill(0xff);
  textSize(48);
  // Updates the movement and draws all the users.
  for(int i = 0; i < uls.size(); i++){
    User cu = uls.get(i);
    cu.update();
    cu.show();
  }
}
