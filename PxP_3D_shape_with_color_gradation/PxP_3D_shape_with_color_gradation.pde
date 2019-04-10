
// The world pixel by pixel 2019
// Daniel Rozin
// simple shape with color gradation


float zoom = 1;
void setup() 
{ 
  size(1000, 800, P3D);
} 

void draw() 
{ 
  background(0);  

  if (keyPressed == true)  zoom = mouseX-300;                                // press key to change zoom
  translate(width/2, height/2, zoom);                                       // to make sure all rotations are centered around the center of our window, and move away from the object by "zoom"
  rotateX(mouseY/100.0);                                                   // rotate around the X and  Y axis (divide by 100 to make a small number as it expects radians)
  rotateY( mouseX/100.0); 
  translate(-width/2, -height/2);                                         // translate back so we are on the normal X, Y axis but stll rotated


  beginShape();                                                            // start a new shape, 
  fill(255, 0, 0);                                                     // every corner gets a fill () and then a vertex()
  vertex(400, 300, 0);                                                // define the three corners of our face
  fill(255, 255, 0); 
  vertex( 400, 600, 0);
  fill(255, 0, 255); 
  vertex( 600, 600, 0);
  endShape();                                                            // done with the shape
} 
