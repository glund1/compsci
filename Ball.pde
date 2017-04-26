class Ball {
  float x;
  float y;
  float theta;
  
  Ball(float theta) {
    x = width/2;
    y = height;
    this.theta = theta;
  }
  
  void show() {
    noStroke();
    fill(0,0,255);
    ellipse(x,y,15,15);
  }
  
  void update() {
    
    x = x + cos(theta);
    y = y + sin(theta);
    if(x>width-1 || x<1) {
      float ang = HALF_PI - theta;
      theta = ang + HALF_PI;
    } else if(y<1) {
      theta = -theta;
    }
    
  }
  
}