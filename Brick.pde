class Brick {
  int x;
  int y;
  
  Brick() {
    x = (int)random(6)*100;
    y = 50;
  }
  
  void show() {
    noStroke();
    fill(250,0,0,100);
    rect(x+5,y+5,95,45);
  }
  
}