import java.util.ArrayList;
 
ArrayList myShapes;
abstractSearchObject queryBeingDragged;


int dragX;
int dragY;
color c = color(random(255), random(255), random(255));
 
void setup()
{
  queryBeingDragged = null;
  myShapes = new ArrayList();
  
  size(800, 500);
  smooth();
  
  Hit h1 = new Hit("myHit1",c,width/2.0+100,height/5.0+50,100,20);
  Query q1 =  new Query("myQuery1",color(random(255), random(255), random(255)),width/2.0+100,height/5.0+100,100,20);
  Query q2 =  new Query("myQuery2",color(random(255), random(255), random(255)),width/2.0,4.0*height/5.0,100,20);
  

// here is where the q1 "connects" to h1
  q1.hit = h1; 
  
// note how I am stuffing everything into one array
  myShapes.add(q1 );
  myShapes.add(q2 );
  
}

 void changeColor(){
  this.c = color(0,0,255);
  }
 
void draw()
{
  background(0);
  
  for(int i = 0; i < myShapes.size(); i++){

// note how I no longer assume it is only query that is being drawn.
    abstractSearchObject myQuery1 = (abstractSearchObject)myShapes.get(i);
    myQuery1.display();
  }
}
 
 
 
void mousePressed(){
  for(int i = 0; i < myShapes.size(); i++){ 
     // note how I made it generic 
    abstractSearchObject myQuery1 = (abstractSearchObject)myShapes.get(i);
    evaluateQuerySelection(myQuery1);
  }
  println("pressed");
  
}

void mouseReleased(){
  queryBeingDragged = null; 
} 
 
void mouseDragged(){
  if( queryBeingDragged != null){
     println("dragging" + queryBeingDragged.name);
    //moveQueryByMouse(queryBeingDragged);
    // note how I encapsulated the movement from directly affecting qx and qy
    queryBeingDragged.moveByMouseCoord(mouseX, mouseY);
   }
}  




void evaluateQuerySelection(abstractSearchObject myQuery1){ 
  if (myQuery1.inQuery(mouseX, mouseY) & queryBeingDragged==null){ 
    dragX = (int)myQuery1.qx - mouseX;
    dragY = (int)myQuery1.qy - mouseY;
    queryBeingDragged = myQuery1;
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
  
  boolean inQuery(int x, int y){
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
class Query extends abstractSearchObject{
  
  Hit hit = null;
  
  Query(String name, color tempQc, float tempQx, float tempQy,int tempdQx, int tempdQy) {
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