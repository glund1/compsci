ArrayList<Ball> balls;
ArrayList<Brick> bricks;
Brick bb;
int level = 1;
int pl = 0;

void setup() {
  size(600,600);
  frameRate(600);
  bb = new Brick();
  balls = new ArrayList<Ball>();
  bricks = new ArrayList<Brick>();
  
}

void draw() {
  background(255);
  stroke(0);
  line(width/2,height,mouseX,mouseY);
  newBricks();
  
  for(Ball b: balls) {
    b.show();
    b.update();
  }
  for(Brick b: bricks) {
    b.show();
  }
  hit();
  pl = level;
}

void mousePressed() {
  for(int i = 0; i<level; i++) {
  float x = 0;
  float y = 0;
  float theta = 0;
  if(mouseX<width/2) {
    x = width/2-mouseX;
    y = height - mouseY;
    theta = atan(y/x) + PI;
  } else {
    x = -mouseX + width/2;
    y = height - mouseY;
    theta = atan(y/x);
  }
  Ball b = new Ball(theta);
  b.x-=20*i*cos(theta);
  b.y-=20*i*sin(theta);
  balls.add(b);
  }
}

void newBricks() {
  if(pl!=level) {
    int ran = (int)random(8) + 1;
    for(int i = 0; i < ran; i++) {
      Brick b = new Brick();
      boolean same = false;
      for(Brick b2 : bricks) {
        if(b2.x==b.x&&b2.y==b.y) {
          same = true;
        }
      }
      if(same) {
        i--;
      } else {
      bricks.add(new Brick());
      }
    }
  }
}

void hit() {
  for(Ball ball: balls) {
    for(Brick brick: bricks) {
      if(ball.x>=brick.x && ball.y>=brick.y && ball.x<=brick.x+95 && ball.y<=brick.y+45) {
        
        if(ball.y>=brick.y-1 && ball.y<=brick.y+1 || ball.y<brick.y+46 && ball.y>brick.y+44) {
          ball.theta = -ball.theta;
        } else if(ball.x<=brick.x+101 && ball.x>=brick.x+99 || ball.x>=brick.x-1 && ball.x<=brick.x+1) {
          ball.theta = PI - ball.theta;
        }
        bricks.remove(brick);
        break;
      }
    }
  }
}