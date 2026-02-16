class User{
  float[] coor; // Current user pos.
  String name; // Current user name.
  // Target pos for the user for smooth movement.
  float targetX;
  float targetY;
  int lastChoose = 0; // Timer for when to pick a new pos.
  
  public User(String n){
    name = n; // Sets the username.
    // Stats the user at a random X at the bootom of the screen.
    coor = new float[2];
    coor[0] = random(W_W);
    coor[1] = W_H-200;
    // Targets are nothing at the start.
    targetX = coor[0];
    targetY = coor[1];
  }
  
  void newCoor(){
    // Chooses a new X pos.
    targetX = random(W_W);
    targetY = coor[1];
  }
  
  void update(){
    // Chooses a new pos every 1.5 seconds.
    if(millis()-lastChoose>=1500){
      newCoor();
      lastChoose = millis();
    }
    // Do a animation over to the pos.
    coor[0]+=(targetX-coor[0])*0.01;
    coor[1]+=(targetY-coor[1])*0.01;
  }
  
  void show(){
    text(name,coor[0],coor[1]); // Draws the user at the x and y pos.
  }
}
