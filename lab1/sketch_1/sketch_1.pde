import java.util.ArrayList;
 
ArrayList shapes;
abstractSearchObject selectedShape = null;
abstractSearchObject ShapeBeingDragged;
int dragX;
int dragY;
color c = color(random(255), random(255), random(255));
PFont font;
 
void setup()
{
  ShapeBeingDragged = null;
  shapes = new ArrayList();
  size(800, 500);//window size
  smooth();
  font = loadFont("AmericanTypewriter-48.vlw");
  
  //create shapes
  shapes.add(new Shape("Rectangle", color(random(255), random(255), random(255)),width/2.0+100, height/5.0+100, 100, 20));
  shapes.add(new Shape("Triangle", color(random(255), random(255), random(255)),width+10, 4.0*height/5.0, 100, 20));
  shapes.add(new Shape("Ellipse", color(random(255), random(255), random(255)),width+30, 2.0*height/5.0, 100, 20));
  shapes.add(new Shape("Circle", color(random(255), random(255), random(255)),width/3, 1.0*height/5.0, 50, 20));
  shapes.add(new Shape("Diamond", color(random(255), random(255), random(255)),width, 4.0*height, 10, 20)); 
}

 void changeColor(){
  this.c = color(0,0,255);
  }
 
void draw()
{
  background(255);
  
  //Text
  textFont(font, 20);//font style + size)
  fill(0);//font color
  text("Mouse position: " + str(mouseX) + ", " + str(mouseY), 50, 50);
  
  textFont(font, 20);//font style + size)
  fill(0);//font color
  if(selectedShape == null){
    text("Selected: none", 400, 50);
  } else {
    text("Selected: " + selectedShape.type, 400, 50);
  }
  
  //Shapes
  for(int i = 0; i < shapes.size(); i++){
// note how I no longer assume it is only Shape that is being drawn.
    abstractSearchObject myShape1 = (abstractSearchObject)shapes.get(i);
    myShape1.display();
  }
}
 
void mousePressed(){
    println("Mouse pressed");
  for(int i = 0; i < shapes.size(); i++){ 
    abstractSearchObject myShape1 = (abstractSearchObject)shapes.get(i);
    evaluateShapeSelection(myShape1);
    myShape1.qc = color(random(255), random(255), random(255));
  }
}

void mouseReleased(){
  ShapeBeingDragged = null; 
} 
 
void mouseDragged(){
  if( ShapeBeingDragged != null){
     println("dragging" + ShapeBeingDragged.type);
    //moveShapeByMouse(ShapeBeingDragged);
    // note how I encapsulated the movement from directly affecting qx and qy
    ShapeBeingDragged.moveByMouseCoord(mouseX, mouseY);
   }
}

void keyPressed(){
  if (key == CODED){
    if(selectedShape != null){
       if (keyCode == UP){
         println("grow " + selectedShape.type);
       }
       if(keyCode == DOWN){
         println("shrink " + selectedShape.type);
       }
    }
  }
}


//=====================================================================
void evaluateShapeSelection(abstractSearchObject myShape1){ 
  if (myShape1.isOver(mouseX, mouseY) & ShapeBeingDragged==null){
    selectedShape = myShape1;
    println("Selected: " + myShape1.type);
    dragX = (int)myShape1.qx - mouseX;
    dragY = (int)myShape1.qy - mouseY;
    ShapeBeingDragged = myShape1;
  }
}

// This is how to use inheritance.  Use interface instead if you want even more flexibility.
abstract class abstractSearchObject{
  String type;
  
  color qc;
  float qx;
  float qy;
  int dQx;
  int dQy;
 
  abstractSearchObject(String type, color tempQc, float tempX, float tempY,int tempdQx, int tempdQy) {
    this.type = type;
     qc = tempQc;
     qx = tempX;
     qy = tempY;
     dQx = tempdQx;
     dQy = tempdQy;
  }
 
  void display() {
    stroke(0);
    fill(qc);
    rectMode(RADIUS);
    rect(qx,qy,dQx,dQy);
  }
  
  //is mouse inside shape
  boolean isOver(int x, int y){
    if((x > qx-dQx) & x < (qx+dQx)){
      if((y > qy-dQy)  & y < (qy+dQy)){
        return true;
      }
    }
    return false;
  }
  
  void moveByMouseCoord(int mausX, int mausY){
    this.qx = mausX + dragX;
    this.qy = mausY + dragY;
  }
}


//=====================================================================
class Shape extends abstractSearchObject{
  
  Shape(String type, color tempQc, float tempX, float tempY,int tempdQx, int tempdQy) {
// by convention, you cannot inherit the constructor.
    super( type,  tempQc,  tempX,  tempY, tempdQx,  tempdQy);
  }
  
  void display(){
//super is the keyword to refer to the parent class.
     super.display();
  } 
}