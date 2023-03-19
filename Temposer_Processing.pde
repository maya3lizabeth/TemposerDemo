import processing.serial.*;
import processing.sound.*;

Serial portListener; 
SoundFile chillMusic;
SoundFile hypeMusic;
String pendingAcceleration;
float acceleration;
float avgDeviation = 0;
float pastDeviation = 0;
float EMERGENCY = 900.0;

// find port we're using and set serial object to listen to it
void setup()
{

  String COM7 = Serial.list()[0]; 
  portListener = new Serial(this, COM7, 9600);
  chillMusic = new SoundFile(this, "just-relax-11157.mp3");
  hypeMusic = new SoundFile(this, "action-techno-beat-121310.mp3");
  chillMusic.loop();
  hypeMusic.loop();
  hypeMusic.amp(0);
}

void switchChill(){
  
    chillMusic.amp(0);
    hypeMusic.amp(1);
}

void switchHype(){

   hypeMusic.amp(0);
   chillMusic.amp(1);

}

void draw()
{
  
  
  for (int i = 0; i < 900000000; i++){
    if ( portListener.available() > 0) 
    {  
      // read in data
      pendingAcceleration = portListener.readStringUntil('\n');
      //if (pendingAcceleration != null && pendingAcceleration.equals("stop")){
      //  chillMusic.stop();
      //  hypeMusic.stop();
      //  exit();
      //  return;
      //}else 
      if (pendingAcceleration != null){
        acceleration = Float.parseFloat(pendingAcceleration);
      }
      if (acceleration == EMERGENCY){
        chillMusic.stop();
        hypeMusic.stop();
      }
    }
    
    avgDeviation += (acceleration*acceleration);  
  }
  
  avgDeviation /= 900000000; 
  
  if (avgDeviation > 2 && pastDeviation < 2){
    switchChill();
  }else if (avgDeviation < 2 && pastDeviation > 2){
    switchHype();
  }
  
  pastDeviation = avgDeviation;
  avgDeviation = 0;
  
 }
