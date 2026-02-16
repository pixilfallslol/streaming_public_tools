int W_W = 1920;
int W_H = 1080;

String[] data;
String allText = "";
int lastReload = 0;
int TICKS_PER_RELOAD = 500;

int scrollY = 0;

void setup(){
  imageMode(CENTER);
  rectMode(CENTER);
  textAlign(CENTER);
  size(1920,1080,P2D);
}

void draw(){
  background(0xff00);
  reloadData();
  drawData();
}

void reloadData(){
  if(millis()-lastReload>=TICKS_PER_RELOAD){
    reloadNow();
    lastReload = millis();
  }
}

void reloadNow(){
  data = loadStrings("users.txt");
  if(data == null) return;
  allText = join(data,"\n");
}

void drawData(){
  if(data == null) return;
  fill(0);
  textSize(48);
  text(allText,W_W/2,W_H/2+scrollY);
}

void mouseWheel(processing.event.MouseEvent e){
  scrollY-=e.getCount()*40;
}
