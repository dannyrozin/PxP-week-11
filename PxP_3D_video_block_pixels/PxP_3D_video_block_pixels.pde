// The world pixel by pixel 2019
// Daniel Rozin
// creates 3D block pixels using colors from camera
// move mouse X to rotate, mouse Y to zoom



import processing.video.*;

int cell = 20;                                                   // this will be the size of our blocks
int count=0;
Capture video;
void setup() {
  size(1280, 720, P3D);                                         // must be P3D
  video= new Capture(this, width, height);
  video.start();
  noStroke();
}

void draw() {
  background(0);
  lights();                                                       // need to call lights in the draw() to get the 3D shaded
  count++;                                                        // increment our counter for some of the effects
  translate(width/2, height/2);                                   // translating to center of screen 
  scale(mouseY/100.0);                                            // scaling to create the zoom effect with mouseY
  rotateY(radians(mouseX));                                       // rotating around Y axis acording to mouseX
  translate(-width/2, -height/2, 0);                             // translating back so our coordinates are synced between screen and video
  if (video.available ()) video.read();
  video.loadPixels();
  for (int x=0; x< video.width; x+= cell) {                      // visiting all pixels skipping every cell amount
    for (int y=0; y< video.height; y+= cell) {
      PxPGetPixel(x, y, video.pixels, width);                    // get the RGB of the pixel
     float z = (R+G+B)/3;                                       // calculate Z as the average RGB which is brightness
      //float z = sin(radians (count+x+y) )*50.0;                // this option applyes a sine wave for the Z instead of brightness
     // float z = sin( radians(count+dist(x,y,width/2,height/2)))*50;       // this option calculates the Z according to distance from center
      fill(R, G, B);                                            // set the fill to the color of the video
      pushMatrix();                                              // push the matrix so we can pop it later and get a constant matrix fr all pixels
      translate(x, y,-z/2);                                      // translate to the position of our pixel minus half the z to get a flat back
      box(cell, cell, z);                                         // create a box the size of our cell with a Z as we calculated
      popMatrix();                                                // pop the matrix to return to the way it was before this pixel
    }
  }
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
