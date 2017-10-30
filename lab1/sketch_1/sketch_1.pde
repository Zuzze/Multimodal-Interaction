import java.util.ArrayList;
 
ArrayList shapes;
abstractSearchObject selectedShape = null;
int dragX;
int dragY;
color c = color(random(255), random(255), random(255));
PFont font;
 
void setup()
{
  selectedShape = null;
  shapes = new ArrayList();
  size(800, 500);//window size
  smooth();
  font = loadFont("AmericanTypewriter-48.vlw");
  
  //create shapes
  shapes.add(new Shape("Rectangle", color(random(255), random(255), random(255)),width/2.0+100, height/5.0+100, 100, 20));
  shapes.add(new Shape("Triangle", color(random(255), random(255), random(255)),10,10, 100, 20));
  shapes.add(new Shape("Ellipse", color(random(255), random(255), random(255)),20, 20, 100, 20));
  shapes.add(new Shape("Circle", color(random(255), random(255), random(255)),50, 50, 50, 20));
  shapes.add(new Shape("Diamond", color(random(255), random(255), random(255)),width, 4.0*height, 5, 5)); 
}

 void changeColor(){
  this.c = color(0,0,255);
  }
 
void draw(){
  background(255);
  
  //Text
  textFont(font, 20);//font style + size)
  fill(0);//font color
  text("Mouse position: " + str(mouseX) + ", " + str(mouseY), 50, 50);
  
  textFont(font, 20);
  fill(0);
  if(selectedShape == null){
    text("Selected: none", 400, 50);
  } else {
    text("Selected: " + selectedShape.type, 400, 50);
  }
  
  //Shapes
  for(int i = 0; i < shapes.size(); i++){
    abstractSearchObject shape = (abstractSearchObject)shapes.get(i);
    shape.display();
  }
}
 
void mousePressed(){
  println("Mouse pressed");
  if(selectedShape == null){
    for(int i = 0; i < shapes.size(); i++){ 
      abstractSearchObject shape = (abstractSearchObject)shapes.get(i);
        if (shape.isOver(mouseX, mouseY)){
        selectedShape = shape;
        break;
      } else {
        selectedShape = null;
      }
    }
  } else {
    //shape already selected and will be moved to clicked position
     selectedShape.moveByMouseCoord(mouseX, mouseY);
     selectedShape.shapeColor = color(random(255), random(255), random(255));
     selectedShape = null;
  }
}

/*void mouseReleased(){
  selectedShape.shapeColor = color(random(255), random(255), random(255));
} 
 
void mouseDragged(){
  if( selectedShape != null){
     println("dragging " + selectedShape.type);
    //moveShapeByMouse(selectedShape);
    // note how I encapsulated the movement from directly affecting shapeX and shapeY
    selectedShape.moveByMouseCoord(mouseX, mouseY);
   }
}*/

void keyPressed(){
  if (key == CODED){
    if(selectedShape != null){
       if (keyCode == UP){
         selectedShape.dshapeY += 10;
         println("grow " + selectedShape.type);
         
       }
       if(keyCode == DOWN){
         selectedShape.dshapeY -= 10;
         println("shrink " + selectedShape.type);
       }
       if(keyCode == RIGHT){
         selectedShape.dshapeX += 10;
         println("shrink " + selectedShape.type);
       }
       if(keyCode == LEFT){
         selectedShape.dshapeX -= 10;
         println("shrink " + selectedShape.type);
       }
    }
  }
}

void evaluateShapeSelection(abstractSearchObject shape){ 
  if (shape.isOver(mouseX, mouseY) & selectedShape==null){
    selectedShape = shape;
    println("Selected: " + shape.type);
    dragX = (int)shape.shapeX - mouseX;
    dragY = (int)shape.shapeY - mouseY;
    selectedShape = shape;
  }
}

//=====================================================================
abstract class abstractSearchObject{
  String type;
  color shapeColor;
  float shapeX;
  float shapeY;
  int dshapeX;
  int dshapeY;
 
  abstractSearchObject(String type, color tempColor, float tempX, float tempY,int tempdshapeX, int tempdshapeY) {
     this.type = type;
     shapeColor = tempColor;
     shapeX = tempX;
     shapeY = tempY;
     dshapeX = tempdshapeX;
     dshapeY = tempdshapeY;
  }
 
  void display() {
    stroke(0);
    fill(shapeColor);
    if(this.type.equals("Rectangle")){
      rectMode(RADIUS);
      rect(shapeX,shapeY,dshapeX,dshapeY);
    } else if(this.type.equals("Triangle")){
        ellipse(shapeX,shapeY, 10, 55);
    } else if(this.type.equals("Ellipse")){
        ellipse(shapeX,shapeY, 10, 55);
    } else {
        ellipse(shapeX,shapeY, 55, 55);
    }
  }
    
  
  //is mouse inside shape
  boolean isOver(int x, int y){
    if((x > shapeX-dshapeX) & x < (shapeX+dshapeX)){
      if((y > shapeY-dshapeY)  & y < (shapeY+dshapeY)){
        return true;
      }
    }
    return false;
  }
  
  void moveByMouseCoord(int mausX, int mausY){
    this.shapeX = mausX + dragX;
    this.shapeY = mausY + dragY;
  }
}


//=====================================================================
class Shape extends abstractSearchObject{
  
  Shape(String type, color tempshapeColor, float tempX, float tempY,int tempdshapeX, int tempdshapeY) {
    super( type,  tempshapeColor,  tempX,  tempY, tempdshapeX,  tempdshapeY);
  }
  
  void display(){
     super.display();
  } 
}