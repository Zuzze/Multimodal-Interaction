import java.util.ArrayList;
ArrayList shapes;
shapeObject selectedShape = null;
int dragX;
int dragY;
int Y_AXIS = 1;
int X_AXIS = 2;
PFont font;

 
void setup()
{
  selectedShape = null;
  shapes = new ArrayList();
  size(800, 500);//window size
  smooth();
  font = loadFont("AmericanTypewriter-48.vlw");
  
  //create shapes
  shapes.add(new Shape("Rectangle", color(0), 600, 300, 25, 25));
  shapes.add(new Shape("Triangle", color(0), 200, 100, 20, 20));
  shapes.add(new Shape("Ellipse", color(0), 500, 100, 50, 20));
  shapes.add(new Shape("Circle", color(0),200, 200, 50, 50));
  shapes.add(new Shape("Arc", color(0),80, 200, 150, 100)); 
}
 
 void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {
  noFill();
  if (axis == Y_AXIS) {  // Top to bottom gradient
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  }  
  else if (axis == X_AXIS) {  // Left to right gradient
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y+h);
    }
  }
}
 
void draw(){
  // Background
  background(255);
  //setGradient(50, 90, width, height, c1, c2, Y_AXIS);
  
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
    shapeObject shape = (shapeObject)shapes.get(i);
    shape.display();
  }
}
 
void mousePressed(){
  println("Mouse pressed");
  if(selectedShape == null){
    for(int i = 0; i < shapes.size(); i++){ 
      shapeObject shape = (shapeObject)shapes.get(i);
        if (shape.isOver(mouseX, mouseY)){
        selectedShape = shape;
        selectedShape.shapeColor = color(random(255), random(255), random(255));
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
         if(selectedShape.shapeHeight < 200){
           selectedShape.shapeHeight += 10;
         }
       }
       if(keyCode == DOWN){
         if(selectedShape.shapeHeight > 10){
           selectedShape.shapeHeight -= 10;
         }
       }
       if(keyCode == RIGHT){
         if(selectedShape.shapeWidth < 200){
           selectedShape.shapeWidth += 10;
         }
       }
       if(keyCode == LEFT){
         if(selectedShape.shapeWidth > 10){
           selectedShape.shapeWidth -= 10;
         }
       }
    }
  }
}

/*void evaluateShapeSelection(shapeObject shape){ 
  if (shape.isOver(mouseX, mouseY) & selectedShape==null){
    selectedShape = shape;
    println("Selected: " + shape.type);
    dragX = (int)shape.shapeX - mouseX;
    dragY = (int)shape.shapeY - mouseY;
    selectedShape = shape;
  }
}*/

//=====================================================================
abstract class shapeObject{
  String type;
  color shapeColor;
  float shapeX;
  float shapeY;
  int shapeWidth;
  int shapeHeight;
 
  shapeObject(String type, color tempColor, float tempX, float tempY,int tempshapeWidth, int tempshapeHeight) {
     this.type = type;
     shapeColor = tempColor;
     shapeX = tempX;
     shapeY = tempY;
     shapeWidth = tempshapeWidth;
     shapeHeight = tempshapeHeight;
  }
 
  void display() {
    stroke(0);
    fill(shapeColor);
    if(this.type.equals("Rectangle")){
      rectMode(RADIUS);
      rect(shapeX,shapeY, shapeWidth, shapeHeight);
    } else if(this.type.equals("Triangle")){
        triangle(shapeX, shapeY, shapeX + shapeWidth, shapeY, (shapeX + shapeX + shapeWidth)/2, shapeY + shapeHeight);
    } else if(this.type.equals("Ellipse") || this.type.equals("Circle")){
        ellipse(shapeX,shapeY, shapeWidth, shapeHeight);
    } else if(this.type.equals("Arc")){
        arc(shapeX,shapeY, shapeWidth, shapeHeight, PI, TWO_PI);
    }
  }
    
  
  //is mouse inside shape
  boolean isOver(int x, int y){
    if((x > shapeX-shapeWidth) & x < (shapeX+shapeWidth)){
      if((y > shapeY-shapeHeight)  & y < (shapeY+shapeHeight)){
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
class Shape extends shapeObject{
  
  Shape(String type, color tempshapeColor, float tempX, float tempY,int tempshapeWidth, int tempshapeHeight) {
    super( type,  tempshapeColor,  tempX,  tempY, tempshapeWidth,  tempshapeHeight);
  }
  
  void display(){
     super.display();
  } 
}