// The world pixel by pixel 2021
// Daniel Rozin
// creates 3D mesh according to sine wave and uses movie as texture
// move mouse X to rotate

import processing.video.*;
int cell = 5;   // this will be the size of our mesh cells
int count=0;
Movie ourMovie; 
void setup() {
  size(720, 480, P3D);
  ourMovie = new Movie(this, "Internationale.mov"); 
  ourMovie.play();
  noStroke();
}

void draw() {
  background(0);
  count+=10; 
  lights();                                                // need to call lights in the draw() to get the 3D shaded
  translate(width/2, height/2);                                   // translating to center of screen 
  scale(0.8);                                            // scaling to create the zoom effect with mouseY
  rotateY(radians(mouseX));                                       // rotating around Y axis acording to mouseX
  translate(-width/2, -height/2, 0);                             // translating back so our coordinates are synced between screen and video
  for (int x=0; x< ourMovie.width-cell; x+= cell) {                      // visiting all pixels skipping every cell amount
    for (int y=0; y< ourMovie.height-cell; y+= cell) {
      beginShape();                                                  // we will make two triangles for each cell, start the first triangle
      texture(ourMovie);                                                // assigning the video as the texture                                      
      float z = sin(radians (count+x+y) )*50.0;                      // calculating a z according to the sine of the x and y and time
      vertex (x, y, z, x, y);                                        // using the same x,y cordinates as u, v

      z = sin(radians (count+x+cell+y) )*50.0; 
      vertex (x+cell, y, z, x+cell, y);

      z = sin(radians (count+x+cell+ y+cell) )*50.0; 
      vertex (x+cell, y+cell, z, x+cell, y+cell);

      endShape(CLOSE);                                              // close the first triangle

      beginShape();                                                 // start second triangle
      texture(ourMovie);
      z = sin(radians (count+x+cell+ y+cell) )*50.0; 
      vertex (x+cell, y+cell, z, x+cell, y+cell);

      z = sin(radians (count+x+y+cell) )*50.0; 
      vertex (x, y+cell, z, x, y+cell);

      z = sin(radians (count+x+y) )*50.0; 
      vertex (x, y, z, x, y);
      endShape(CLOSE);                                             // close the second triangle
    }
  }
}
void movieEvent(Movie m) {              //  callback function that reads a frame whenever its ready
  m.read();
}
