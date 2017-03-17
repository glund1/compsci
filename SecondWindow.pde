float red = 255;
float green = 0;
float blue = 0;
float alpha;
int mesh = 1;
boolean slider = false;
boolean adv = false;
Range uRange,vRange;
ControlP5 cp5;
RadioButton r1,r2;

public class Grapher extends PApplet {

  public void settings() {
    size(600, 400);
  }

  void setup() {
    PFont font = createFont("arial", 18);
    cp5 = new ControlP5(this);

    cp5.addTextfield("X Equation")
      .setPosition(20, 40)
      .setSize(200, 30)
      .setFont(font)
      .setFocus(true)
      .setColor(255)
      .setAutoClear(false);

    cp5.addTextfield("Y Equation")
      .setPosition(20, 140)
      .setSize(200, 30)
      .setFont(font)
      .setFocus(true)
      .setColor(255)
      .setAutoClear(false);

    cp5.addTextfield("Z Equation")
      .setPosition(20, 240)
      .setSize(200, 30)
      .setFont(font)
      .setFocus(true)
      .setColor(255)
      .setAutoClear(false);

    cp5.addButton("Run")
      .setPosition(40, 340)
      .setSize(60, 30)
      .setFont(font);
      
    cp5.addButton("Clear")
      .setPosition(140, 340)
      .setSize(80, 30)
      .setFont(font);

    r1 = cp5.addRadioButton("radioButton")
      .setPosition(300, 40)
      .setSize(40, 30)
      .setColorForeground(color(120))
      .setColorActive(color(255))
      .setColorLabel(color(255))
      .setNoneSelectedAllowed(false)
      .setItemsPerRow(1)
      .setSpacingRow(10)
      .addItem("Mesh", 1)
      .addItem("Fill", 2)
      .activate(0)
      ;
      
    r2 = cp5.addRadioButton("Advance")
      .setPosition(400, 40)
      .setSize(40, 30)
      .setColorForeground(color(120))
      .setColorActive(color(255))
      .setColorLabel(color(255))
      .setItemsPerRow(1)
      .setSpacingRow(10)
      .addItem("Advanced", 1)
      ;

    cp5.addSlider("Red")
      .setPosition(320, 120)
      .setRange(0, 255)
      .setValue(255.00)
      .setVisible(false);

    cp5.addSlider("Green")
      .setPosition(320, 140)
      .setRange(0, 255)
      .setVisible(false);

    cp5.addSlider("Blue")
      .setPosition(320, 160)
      .setRange(0, 255)
      .setVisible(false);
      
    cp5.addSlider("Alpha")
      .setPosition(320, 180)
      .setRange(0, 255)
      .setValue(255)
      .setVisible(false);
      
    cp5.addSlider("Resolution")
      .setPosition(260,300)
      .setRange(1,100)
      .setValue(35)
      .setColorForeground(color(255,40))
      .setColorBackground(color(255,40))
      .setSize(200,20)
      .setVisible(false)
      ;
      
    cp5.addRange("Range for u rotation")
      .setBroadcast(false)
      .setPosition(260,220)
      .setSize(200,20)
      .setHandleSize(20)
      .setRange(0,TWO_PI)
      .setRangeValues(0,TWO_PI)
      .setBroadcast(true)
      .setColorForeground(color(255,40))
      .setColorBackground(color(255,40))
      .setVisible(adv)
      ;
      
    cp5.addRange("Range for v rotation")
      .setBroadcast(false)
      .setPosition(260,260)
      .setSize(200,20)
      .setHandleSize(20)
      .setRange(0,TWO_PI)
      .setRangeValues(0,TWO_PI)
      .setBroadcast(true)
      .setColorForeground(color(255,40))
      .setColorBackground(color(255,40))
      .setVisible(adv)
      ;
  }
  void draw() {
    background(0);
    fill(0);
    ellipse(100, 50, 10, 10);
    if (mesh == 2) {
      slider = true;
    } else {
      slider = false;
    }
    
    cp5.getController("Red").setVisible(slider);
    cp5.getController("Green").setVisible(slider);
    cp5.getController("Blue").setVisible(slider);
    cp5.getController("Alpha").setVisible(slider);
    cp5.getController("Range for v rotation").setVisible(adv);
    cp5.getController("Range for u rotation").setVisible(adv);
    cp5.getController("Resolution").setVisible(adv);
  }


  void Run() {
    xEq = cp5.get(Textfield.class, "X Equation").getText();
    yEq = cp5.get(Textfield.class, "Y Equation").getText();
    zEq = cp5.get(Textfield.class, "Z Equation").getText();
    println(xEq);
    println(yEq);
    println(zEq);
    r = true;
  }
  
  void Clear() {
    cp5.get(Textfield.class, "X Equation").clear();
    cp5.get(Textfield.class, "Y Equation").clear();
    cp5.get(Textfield.class, "Z Equation").clear();
    xEq = "";
    yEq = "";
    zEq = "";
  }
  void Resolution(int a) {
    res = a;
  }
  void radioButton(int a) {
    mesh = a;
  }
  
  void Advance(int a) {
    if(a==1)
      adv = true;
    if(a==-1)
      adv = false;
  }
  
  void Red(float col) {
    red = col;
  }
  
  void Green(float col) {
    green = col;
  }
  
  void Blue(float col) {
    blue = col;
  }
  
  void Alpha(float col) {
    alpha = col;
  }
  
  void controlEvent(ControlEvent theControlEvent) {
    if(theControlEvent.isFrom("Range for u rotation")) {
      uMin = theControlEvent.getController().getArrayValue(0);
      uMax = theControlEvent.getController().getArrayValue(1);
    }
    if(theControlEvent.isFrom("Range for v rotation")) {
      vMin = theControlEvent.getController().getArrayValue(0);
      vMax = theControlEvent.getController().getArrayValue(1);
    }
  }
  
}