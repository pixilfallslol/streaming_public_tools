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
  
  void newCoor(){
    targetX = random(W_W);
    targetY = coor[1];
  }
  
  void update(){
    if(millis()-lastChoose>=1500){
      newCoor();
      lastChoose = millis();
    }
    coor[0]+=(targetX-coor[0])*0.01;
    coor[1]+=(targetY-coor[1])*0.01;
  }
  
  void show(){
    text(name,coor[0],coor[1]);
  }
}
