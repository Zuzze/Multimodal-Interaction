import java.util.ArrayList;
 
ArrayList myShapes;
abstractSearchObject ShapeBeingDragged;


int dragX;
int dragY;
color c = color(random(255), random(255), random(255));
 
void setup()
{
  ShapeBeingDragged = null;
  myShapes = new ArrayList();
  
  size(800, 500);
  smooth();
  
  Shape q1 =  new Shape("myShape1",color(random(255), random(255), random(255)),width/2.0+100, height/5.0+100, 100, 20);
  Shape q2 =  new Shape("myShape2",color(random(255), random(255), random(255)),width, 4.0*height/5.0, 100, 20);
  Shape q3 =  new Shape("myShape2",color(random(255), random(255), random(255)),width, 2.0*height/5.0, 100, 20);
  Shape q4 =  new Shape("myShape2",color(random(255), random(255), random(255)),width/3, 1.0*height/5.0, 50, 20);
  Shape q5 =  new Shape("myShape2",color(random(255), random(255), random(255)),width, 4.0*height, 10, 20);
  
  
// note how I am stuffing everything into one array
  myShapes.add(q1 );
  myShapes.add(q2 );
  myShapes.add(q3 );
  myShapes.add(q4 );
  myShapes.add(q5 );
  
}

 void changeColor(){
  this.c = color(0,0,255);
  }
 
void draw()
{
  background(0);
  
  for(int i = 0; i < myShapes.size(); i++){

// note how I no longer assume it is only Shape that is being drawn.
    abstractSearchObject myShape1 = (abstractSearchObject)myShapes.get(i);
    myShape1.display();
  }
}
 
 
 
void mousePressed(){
  for(int i = 0; i < myShapes.size(); i++){ 
     // note how I made it generic 
    abstractSearchObject myShape1 = (abstractSearchObject)myShapes.get(i);
    evaluateShapeSelection(myShape1);
     myShape1.qc = color(random(255), random(255), random(255));
  }
  println("pressed");
  
}

void mouseReleased(){
  ShapeBeingDragged = null; 
} 
 
void mouseDragged(){
  if( ShapeBeingDragged != null){
     println("dragging" + ShapeBeingDragged.name);
    //moveShapeByMouse(ShapeBeingDragged);
    // note how I encapsulated the movement from directly affecting qx and qy
    ShapeBeingDragged.moveByMouseCoord(mouseX, mouseY);
   }
}  




void evaluateShapeSelection(abstractSearchObject myShape1){ 
  if (myShape1.inShape(mouseX, mouseY) & ShapeBeingDragged==null){ 
    dragX = (int)myShape1.qx - mouseX;
    dragY = (int)myShape1.qy - mouseY;
    ShapeBeingDragged = myShape1;
  }
}



// This is how to use inheritance.  Use interface instead if you want even more flexibility.
abstract class abstractSearchObject{
  String name;
  
  color qc;
  float qx;
  float qy;
  int dQx;
  int dQy;
 
  abstractSearchObject(String name, color tempQc, float tempQx, float tempQy,int tempdQx, int tempdQy) {
    this.name = name;
     qc = tempQc;
     qx = tempQx;
     qy = tempQy;
     dQx = tempdQx;
     dQy = tempdQy;
  }
 
  void display() {
    stroke(0);
    fill(qc);
    rectMode(RADIUS);
    rect(qx,qy,dQx,dQy);
  }
  
  boolean inShape(int x, int y){
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


// "extends" is what makes inheritance happen.
class Shape extends abstractSearchObject{
  
  Hit hit = null;
  
  Shape(String name, color tempQc, float tempQx, float tempQy,int tempdQx, int tempdQy) {
// by convention, you cannot inherit the constructor.
    super( name,  tempQc,  tempQx,  tempQy, tempdQx,  tempdQy);
  }
  
  void display(){
//super is the keyword to refer to the parent class.
        super.display();  // see how I'm calling the parent class's draw routine
    if(hit != null){
    // Draw the connector line

stroke(255);
   
    
    }
  
  }
  
  
}


class Hit extends abstractSearchObject{
  
  Hit(String name, color tempQc, float tempQx, float tempQy,int tempdQx, int tempdQy) {
    super( name,  tempQc,  tempQx,  tempQy, tempdQx,  tempdQy);
  }
}