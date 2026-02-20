int W_W = 1920;
int W_H = 1080;

String msg;

PFont font;

int BOX_COL = 0xFFFFC744;

String[] data;
String[] drawing;
String allText = "";
int lastReload = 0;

boolean drawIt = false;

void setup(){
  rectMode(CENTER);
  textAlign(CENTER);
  noStroke();
  font = createFont("OpenSans-CondBold.ttf",48);
  textFont(font);
  reloadNow();
  size(1920,1080,P2D);
}

void draw(){
  background(0xff00);
  reloadData();
  drawCaptions();
}

void reloadData(){
  if(millis()-lastReload>=500){
    reloadNow();
    lastReload = millis();
  }
}

void reloadNow(){
  data = loadStrings("data.txt");
  drawing = loadStrings("draw.txt");
  if(data == null) return;
  allText = join(data,"\n");
  if(drawing[0].equals("yes")){
    drawIt = true;
  }else{
    drawIt = false;
  }
}

void drawCaptions(){
  if(!drawIt) return;
  msg = allText;
  int x = W_W/2;
  int y = W_H/2;
  int w = int(textWidth(msg)+50);
  int h = 150;
  fill(BOX_COL);
  rect(x,y,w,h,20);
  fill(0);
  text(msg,x,y+15);
}
