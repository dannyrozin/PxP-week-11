
// The world pixel by pixel 2016
// Daniel Rozin
// simple shape with color texture


PImage ourTexture;


float zoom = 1;
void setup() 
{ 
  size(1000, 800, P3D); 
  ourTexture = loadImage("http://foundtheworld.com/wp-content/uploads/2015/12/Eiffel-Tower-3.jpg");
  ourTexture.resize(width, height);
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
  texture(ourTexture);
  vertex(400, 300, 0, 400, 300);                                                // define the three corners of our face
  vertex( 400, 600, 0, 400, 600);                                               // the last 2 numbers are the X,Y placement of the texture for that vertex
  vertex( 600, 600, 0, 600, 600);
  endShape();                                                            // done with the shape
} 