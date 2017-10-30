import tuio.*;

SurfaceObjectList objectList;
TuioClient client;

UDPOutput clientParameters = new UDPOutput("127.0.0.1", 3001, 3003);
UDPOutput clientSoundOnOff = new UDPOutput("127.0.0.1", 3002, 3004);

void setup()
{
  textFont(createFont("Sans", 12));

  size(640,480);
  noStroke();
  fill(0);
  noLoop();
  redraw();
  objectList = new SurfaceObjectList();
  client  = new TuioClient(this);
}

void draw()
{
  background(255);
  objectList.draw();
}

// called after each message bundle
void refresh() { 
  redraw(); 
}

// called when an object is added to the scene
void addTuiObject(Integer s_id, Integer f_id) {
  objectList.activate(s_id,f_id);
  //System.out.println("add object "+f_id+" ("+s_id+")");
}

// called when an object is removed from the scene
void removeTuiObject(Integer s_id,Integer f_id ) {
  objectList.deactivate(s_id);
  //System.out.println("remove object "+f_id+" ("+s_id+")");
}

// called when an object is moved
void updateTuiObject (Integer s_id, Integer f_id, Float xpos, Float ypos, Float angle) {
  objectList.update(s_id,(int)(640*xpos.floatValue()),(int)(480*ypos.floatValue()),angle.floatValue());
  System.out.println("update object "+f_id+" ("+s_id+")");
}

float volume = 0.2;
float volumeMin = 0;
float volumeMax = 1;

int frequency = 80;
int frequencyMin = 30;
int frequencyMax = 880;

boolean soundOn = false;

void setVolume(float value)
{
  volume = max(min(value, volumeMax), volumeMin); 
  sendParameters();  
}

void setFrequency(int value)
{
  frequency = max(min(value, frequencyMax), frequencyMin); 
  sendParameters();  
}

void sendParameters()
{
  String msg = volume + " " + frequency + "\n";
  print(msg);
  clientParameters.send(frequency + " " + volume + "\n");  
}

void toggleSound()
{
  soundOn = !soundOn; 
  if (soundOn)
    clientSoundOnOff.send("1\n");
  else 
    clientSoundOnOff.send("0\n"); 
}

void keyPressed()
{
  switch (key)
  {
  case 'v': 
    setVolume(volume + 0.1); 
    break;
  case 'V': 
    setVolume(volume - 0.1);     
    break;
  case 'f': 
    setFrequency(frequency + 10);
    break;
  case 'F': 
    setFrequency(frequency - 10);
    break;
  case ' ':
    toggleSound();
    break;
  }

}






