// The world pixel by pixel 2022
// Daniel Rozin
// using time funtions and transforms to creat a real time clock

void setup() { 
  size(500,500);
  smooth();
  fill(0);
  stroke(255);
}

void draw() {
  background (255);

  float secondsAngle= (second()/60.0)* 360;                            // calculating the angle of the seconds hand in degrees
  float minutesAngle= (minute()/60.0)* 360 ;                           // calculating the angle of the minutes hand in degrees
  float hoursAngle= ( (hour() % 12 )/12.0)* 360 ;                      // calculating the angle of the hours hand in degrees (converting from 24 to 12 with %)
  translate (width/2,height/2);                                        // translating to the center of the screen which is now 0,0
  fill(0); 
  ellipse(0,0,450,450);                                                // drawing the clock circle
  fill(255); 
  text (hour()+" : "+minute()+" : "+second(),100,0);                  // making a string from the time by using + and texting on screen 
  
  for (float i = 0; i< 12;i++) {
    rotate(radians(30));                                              // rotating by 30 degrees (accumulative) 12 times
    rect(0,-210,4,4);                                                // drawing the hour dots, we are drawing always at position 0, -210 (up)
  }                                                                     // but the rotation positions them around the circumference
  pushMatrix();                                                       // pushing the matrix so that we can revert to it after drawing the seconds
    rotate(radians( secondsAngle));                                  // rotating by the amount of secondAngle, after converting to radians
    strokeWeight (2);
    line(0,0,0,-200);                                                // we draw a vertical line and the rotation angles it to the correct angle
  popMatrix();                                                        // when we are done drawing the secnd hand we can pop the matrix and revert to 
                                                                      // the state it was before we called pushMatrix
  pushMatrix();                                    
    rotate(radians( minutesAngle));                                  // the same for minutes
    strokeWeight (6);
    line(0,0,0,-150);
  popMatrix();

  pushMatrix();
    rotate(radians( hoursAngle));                                    // the same for hours
    strokeWeight (10);
    line(0,0,0,-100);
  popMatrix();
}
