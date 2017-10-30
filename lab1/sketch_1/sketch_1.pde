Shape s1;
Shape s2;

void setup() {
  size(200,200);
  // Parameters go inside the parentheses when the object is constructed.
  s1 = new Shape(color(255,0,0),0,100,2); 
  s2 = new Shape(color(0,0,255),0,10,1);
}

void draw() {
  background(255);
  s1.drive();
  s1.display();
  s2.drive();
  s2.display();
}

// Even though there are multiple objects, we still only need one class. 
// No matter how many cookies we make, only one cookie cutter is needed.
class Shape { 
  color c;
  float xpos;
  float ypos;
  float xspeed;

  // The Constructor is defined with arguments.
  Shape(color tempC, float tempXpos, float tempYpos, float tempXspeed) { 
    c = tempC;
    xpos = tempXpos;
    ypos = tempYpos;
    xspeed = tempXspeed;
  }

  void display() {
    stroke(0);
    fill(c);
    rectMode(CENTER);
    rect(xpos,ypos,20,10);
  }

  void drive() {
    xpos = xpos + xspeed;
    if (xpos > width) {
      xpos = 0;
    }
  }
}
/*size(640, 360);
background(0);
noStroke();

fill(204);
triangle(18, 18, 18, 360, 81, 360);

fill(102);
rect(81, 81, 63, 63);

fill(204);
quad(189, 18, 216, 18, 216, 360, 144, 360);

fill(255);
ellipse(252, 144, 72, 72);

fill(204);
triangle(288, 18, 351, 360, 288, 360); 

fill(255);
arc(479, 300, 280, 280, PI, TWO_PI);*/