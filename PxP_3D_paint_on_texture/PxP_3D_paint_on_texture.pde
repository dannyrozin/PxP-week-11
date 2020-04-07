// The world pixel by pixel 2020
// Daniel Rozin
// paint on texture
// drag mouse on right half of screen to paint. press key while painting to erase to transparant

PImage ourTexture, Eiffel;
float zoom = 1;
float angle = 0;
void setup() 
{ 
  size(1000, 500, P3D);
  ourTexture = createImage(500, 500, ARGB);                                                                 // create an image with alpha
  Eiffel = loadImage("https://amp.thisisinsider.com/images/58d919eaf2d0331b008b4bbd-750-562.jpg");           // load file
  ourTexture.set(0, 0, Eiffel);                                                                          // copy the file into the image with alpha
  ourTexture.resize(500, 500);
  noStroke();
}


void draw() {
  angle++;
  background(0);
  image (ourTexture, width/2, 0);  

  translate(width*1/4, 0);                                       // to make sure all rotations are centered around the center of our window, and move away from the object by "zoom"
  // rotate around the X and  Y axis (divide by 100 to make a small number as it expects radians)
  rotateY( radians(angle)); 
  translate(-width*1/4, 0);                                         // translate back so we are on the normal X, Y axis but stll rotated\

  beginShape();                                                            // start a new shape, 
  fill(255, 0, 0);                                                       // make it red
  vertex(0, 0, -100);                                                // define the three corners of our face
  vertex( 500, 500, -100);                                         
  vertex( 0, 500, -100);
  endShape();                                                            // done with the shape

  beginShape();                                                            // start a new shape, 
  texture(ourTexture);
  vertex(500, 0, 0, 500, 0);                                                // define the three corners of our face
  vertex( 500, 500, 0, 500, 500);                                          // the last 2 numbers are the X,Y placement of the texture for that vertex
  vertex( 0, 500, 0, 0, 500);
  endShape();                                                            // done with the shape
}

void mouseDragged() {
  ourTexture.loadPixels();                                            // get a hold of the pixels of the texture PImage
  for (int x = 0; x < 20; x++) {                                      // visit 20 pixels around the mouse
    for (int y = 0; y< 20; y++) {
      int paintX= constrain(x+mouseX-width/2, 0, 499);              // make sure we are not out of bounds
      int paintY= constrain( y+mouseY, 0, 499);
       if (keyPressed){
          PxPSetPixel(paintX, paintY, 0, 0, 0, 0, ourTexture.pixels, ourTexture.width);             // erase by seting Alpha to 0
       }else{
         PxPSetPixel(paintX, paintY, 255, 255, 0, 255, ourTexture.pixels, ourTexture.width);             // paint yellow
       }
    }
  }
  ourTexture.updatePixels();
}




int R, G, B, A;

void PxPGetPixel(int x, int y, int[] pixelArray, int pixelsWidth) {
  int thisPixel=pixelArray[x+y*pixelsWidth];     // getting the colors as an int from the pixels[]
  A = (thisPixel >> 24) & 0xFF;                  // we need to shift and mask to get each component alone
  R = (thisPixel >> 16) & 0xFF;                  // this is faster than calling red(), green() , blue()
  G = (thisPixel >> 8) & 0xFF;   
  B = thisPixel & 0xFF;
}


//our function for setting color components RGB into the pixels[] , we need to define the XY of where
// to set the pixel, the RGB values we want and the pixels[] array we want to use and it's width

void PxPSetPixel(int x, int y, int r, int g, int b, int a, int[] pixelArray, int pixelsWidth) {
  a =(a << 24);                       
  r = r << 16;                       // We are packing all 4 composents into one int
  g = g << 8;                        // so we need to shift them to their places
  color argb = a | r | g | b;        // binary "or" operation adds them all into one int
  pixelArray[x+y*pixelsWidth]= argb;    // finaly we set the int with te colors into the pixels[]
}
