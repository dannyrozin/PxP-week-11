
// The world pixel by pixel 2020
// Daniel Rozin
// simple shape with image texture


PImage ourTexture;


float zoom = 1;
void setup() 
{ 
  size(1000, 800, P3D); 
  ourTexture = loadImage("https://amp.thisisinsider.com/images/58d919eaf2d0331b008b4bbd-750-562.jpg");
  ourTexture.resize(width, height);                                  // resizing the texture image helps so the coords for the geometry and corespond
}

void draw() 
{ 
  background(0);  
  beginShape();                                                            // start a new shape, 
  texture(ourTexture);                                                      // use our PImage as texture, place the call after the beginShape()
  vertex(400, 300, 0, 400, 300);                                            // define the three corners of our face
  vertex( 400, 600, 0, 400, 600);                                           // the last 2 numbers are the X,Y placement of the texture for that vertex
  vertex( 600, 600, 0, mouseX, mouseY);
  endShape();                                                            // done with the shape
} 
