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
      .setPosition(80, 340)
      .setSize(60, 30)
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

  void radioButton(int a) {
    mesh = a;
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
}