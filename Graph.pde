import controlP5.*;
import peasy.*;
import java.util.*;
import java.lang.*;

float red = 255;
float green = 0;
float blue = 0;
float alpha;
int mesh = 1;
boolean slider = false;
ControlP5 cp5;
RadioButton r1;
PeasyCam cam;
int res = 35;
PVector[][] points;
String xEq = "";
String yEq = "";
String zEq = "";
boolean r = false;

void settings() {
  size(800, 800, P3D);
  
}
void setup() {
  
  cam = new PeasyCam(this, 0);
  points = new PVector[res][res];
  String[] args = {"YourSketchNameHere"};
  Grapher sa = new Grapher();
  PApplet.runSketch(args, sa);
}
 
void draw() {
  background(0);
  lights();
  if(mesh==1) {
    noFill();
    stroke(255);
  } else if(mesh==2) {
    noStroke();
    fill(red,green,blue,alpha);
  }
  if(r) {
    Sphere();
    show();
  }
}     
 
void Sphere() {
  for (int i = 0; i<res; i++) {
    double u = map(i, 0, res, 0, TWO_PI+.25);
    for (int j = 0; j<res; j++) {
      double v = map(j, 0, res, 0, TWO_PI+.25);
      float x = (float)eval(postFix(xEq,u,v));
      float y = (float)eval(postFix(yEq,u,v));
      float z = (float)eval(postFix(zEq,u,v));
      points[i][j] = new PVector(x, y, z);
    }
  }
}



void show() {
  for (int i = 0; i<res-1; i++) {
    beginShape(TRIANGLE_STRIP);
    for (int j = 0; j<res; j++) {
      PVector p = points[i][j];
      vertex(p.x, p.y, p.z);
      PVector p1 = points[i+1][j];
      vertex(p1.x, p1.y, p1.z);
    }
    endShape();
  }
}

Stack postFix(String eq, double u, double v) {
  Stack ops = new Stack();
  Stack post = new Stack();
  String pi = String.valueOf(Math.PI);
  String e = String.valueOf(Math.E);
  eq = eq.replace("e", e).replace("v", String.valueOf(v)).replace("u", String.valueOf(u)).replace("pi", pi).replace("sin", "s").replace("cos", "c").replace("tan", "t");

  char[] op = {'+', '-', '*', '/', '^', '(', ')'};

  for (int i = 0; i<eq.length(); i++) {
    if (Character.isDigit(eq.charAt(i))) {
      int ii = i;
      while (i+1 < eq.length() && (Character.isDigit(eq.charAt(i+1)) || eq.charAt(i+1)=='.')) {
        i++;
      }
      String b = eq.substring(ii, i+1);
      double num = Double.parseDouble(b);

      post.push(num);
    } else if (eq.charAt(i)=='s' || eq.charAt(i)=='c' || eq.charAt(i)=='t') {
      int a = -1;
      if (eq.charAt(i)=='s')
        a = 0;
      if (eq.charAt(i)=='c')
        a = 1;
      if (eq.charAt(i)=='t')
        a = 2;
      if (eq.charAt(i+1)=='(') {
        int ii = i+2;

        while (i+1 < eq.length() && eq.charAt(i+1)!=')') {
          i++;
        }

        String b = eq.substring(ii, i+1);
        i++;
        double num = eval(postFix(b, u, v));
        if (a==0)
          post.push(Math.sin(num));
        else if (a==1)
          post.push(Math.cos(num));
        else if (a==2)
          post.push(Math.tan(num));
      } else if (Character.isDigit(eq.charAt(i+1))) {
        int ii = i+1;
        while (i+1 < eq.length() && (Character.isDigit(eq.charAt(i+1)) || eq.charAt(i+1)=='.')) {
          i++;
        }
        String b = eq.substring(ii, i+1);
        double num = eval(postFix(b, u, v));
        if (a==0)
          post.push(Math.sin(num));
        else if (a==1)
          post.push(Math.cos(num));
        else if (a==2)
          post.push(Math.tan(num));
      }
    } else if (contains(op, eq.charAt(i))) {
      char a = eq.charAt(i);
      if (a=='(' || ops.empty() || (char)ops.peek()=='(') {
        ops.push(a);
      } else if (a==')') {
        while (!ops.empty() && (char)ops.peek()!='(') {
          post.push(ops.pop());
        }
        ops.pop();
      } else if (prec(a)>prec((char)ops.peek())) {
        ops.push(a);
      } else if (prec(a)<prec((char)ops.peek())) {
        while (!ops.empty() && prec(a)<prec((char)ops.peek())) {
          post.push(ops.pop());
        }
        ops.push(a);
      } else if (prec(a)==prec((char)ops.peek())) {
        while (!ops.empty() && prec(a)==prec((char)ops.peek())) {
          post.push(ops.pop());
        }
        ops.push(a);
      }
    }
  }
  while (!ops.empty()) {
    post.push(ops.pop());
  }
  post = rev(post);
  return post;
}

int prec(char a) {
  if (a=='+'||a=='-') {
    return 2;
  } else if (a=='*'||a=='/') {
    return 3;
  } else if (a=='^') {
    return 4;
  } else if (a=='c' || a=='c' || a=='t') {
    return 5;
  } else {
    return 0;
  }
}

boolean contains(char[] a, char b) {
  for (int i = 0; i<a.length; i++) {
    if (a[i]==b)
      return true;
  }
  return false;
}

Stack rev(Stack s) {
  Stack r = new Stack();
  while (!s.empty()) {
    r.push(s.pop());
  }
  return r;
}

double eval(Stack s) {
  Stack r = new Stack();

  while (!s.empty()) {

    while (!s.empty() && s.peek() instanceof Double) {
      r.push(s.pop());
    }

    if (!s.empty() && s.peek() instanceof Character) {
      if ((char)s.peek()=='*') {
        s.pop();
        double x = 0;
        double y = 0;
        if (r.peek() instanceof Character) {
          x = (double)Character.digit((char)r.pop(), 10);
        } else if (r.peek() instanceof Double) {
          x = (double)r.pop();
        }
        if (r.peek() instanceof Character) {
          y = (double)Character.digit((char)r.pop(), 10);
        } else if (r.peek() instanceof Double) {
          y = (double)r.pop();
        }

        r.push(x*y);
      } else if ((char)s.peek()=='/') {
        s.pop();
        double x = 0;
        double y = 0;
        if (r.peek() instanceof Character) {
          x = (double)Character.digit((char)r.pop(), 10);
        } else if (r.peek() instanceof Double) {
          x = (double)r.pop();
        }
        if (r.peek() instanceof Character) {
          y = (double)Character.digit((char)r.pop(), 10);
        } else if (r.peek() instanceof Double) {
          y = (double)r.pop();
        }
        r.push(y/x);
      } else if ((char)s.peek()=='+') {
        s.pop();
        double x = 0;
        double y = 0;
        if (r.peek() instanceof Character) {
          x = (double)Character.digit((char)r.pop(), 10);
        } else if (r.peek() instanceof Double) {
          x = (double)r.pop();
        }
        if (r.peek() instanceof Character) {
          y = (double)Character.digit((char)r.pop(), 10);
        } else if (r.peek() instanceof Double) {
          y = (double)r.pop();
        }
        r.push(x+y);
      } else if ((char)s.peek()=='-') {
        s.pop();
        double x = 0;
        double y = 0;
        if (r.peek() instanceof Character) {
          x = (double)Character.digit((char)r.pop(), 10);
        } else if (r.peek() instanceof Double) {
          x = (double)r.pop();
        }
        if (r.peek() instanceof Character) {
          y = (double)Character.digit((char)r.pop(), 10);
        } else if (r.peek() instanceof Double) {
          y = (double)r.pop();
        }
        r.push(x*y);
      } else if ((char)s.peek()=='^') {
        s.pop();
        double x = 0;
        double y = 0;
        if (r.peek() instanceof Character) {
          x = (double)Character.digit((char)r.pop(), 10);
        } else if (r.peek() instanceof Double) {
          x = (double)r.pop();
        }
        if (r.peek() instanceof Character) {
          y = (double)Character.digit((char)r.pop(), 10);
        } else if (r.peek() instanceof Double) {
          y = (double)r.pop();
        }
        r.push(Math.pow(y, x));
      }
    }
  }
  return (double)r.pop();
}