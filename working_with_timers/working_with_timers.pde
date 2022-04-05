// The world pixel by pixel 2022
// Daniel Rozin
// using "timers" to controll two different things at different intervals

int rectInterval= 300;   // interval in ms for first timer
int circleInterval= 301;
int lastRectTime=0;      // variable to hold last triggerng of first timer
int lastCircleTime=0;
Boolean showRect = true;  // variable to hold the state of timer
Boolean showCircle = true;
void setup() {
  size (650, 300);
}

void draw() {  
  background (0);
  if (millis()-lastRectTime> rectInterval) {      // check the first timer
    showRect= !showRect;                          // change the state              
    lastRectTime= millis();                        // if it is due, reset it
  }
  if (millis()-lastCircleTime> circleInterval) {    // check the second timer
    showCircle= !showCircle;
    lastCircleTime= millis();
  }

  if (showRect) rect( 200, 100, 100, 100);           // act on the state of the first timer
  if (showCircle) circle( 400, 150, 100);
}
