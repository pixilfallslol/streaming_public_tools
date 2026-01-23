class Button{
  float[] coor;
  boolean clicked = false;
  String title;
  
  public Button(float[] _coor, String t){
    coor = _coor;
    title = t;
  }
  
  boolean onButton(){
    return dist(mouseX,mouseY,coor[0],coor[1])<50;
  }
  
  void update(){
    if(mousePressed && onButton()){
      clicked = true;
    }
  }
  
  void show(){
    if(!hasFocus) return;
    fill(255);
    rect(coor[0],coor[1],textWidth(title)+10,50);
    fill(0);
    text(title,coor[0],coor[1]);
  }
}
