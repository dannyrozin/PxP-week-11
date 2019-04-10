// The world pixel by pixel 2019
// Daniel Rozin
// simple shape with video texture

import processing.video.*;

Capture video;

float zoom = 1;
void setup() 
{ 
  size(1024, 768, P3D); 
  video = new Capture(this, width, height);
  video.start();
 
}

void draw() 
{ 
  background(0); 
  if (video.available())video.read();

  if (keyPressed == true)  zoom = mouseX-300;                                // press key to change zoom
  translate(width/2, height/2, zoom);                                       // to make sure all rotations are centered around the center of our window, and move away from the object by "zoom"
  rotateX(mouseY/100.0);                                                   // rotate around the X and  Y axis (divide by 100 to make a small number as it expects radians)
  rotateY( mouseX/100.0); 
  translate(-width/2, -height/2);                                         // translate back so we are on the normal X, Y axis but stll rotated


  beginShape();                                                            // start a new shape, 
  texture(video);                                                      // use our video as texture, place the call after the beginShape()
  vertex(400, 300, 0, 400, 300);                                            // define the three corners of our face
  vertex( 400, 600, 0, 400, 600);                                           // the last 2 numbers are the X,Y placement of the texture for that vertex
  vertex( 600, 600, 0, 600, 600);
  endShape();                                                            // done with the shape
} 
