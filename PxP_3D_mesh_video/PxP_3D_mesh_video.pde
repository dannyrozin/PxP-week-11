// The world pixel by pixel 2022
// Daniel Rozin
// creates 3D mesh using colors from camera
// move mouse X to rotate, mouse Y to zoom

import processing.video.*;
int cell = 10;                                                           // this will be the size of our mesh cells
Capture video;
void setup() {
  size(720, 480, P3D);
    String videoList[] = Capture.list();
  video = new Capture(this, width, height, videoList[0]);
  video.start();
  image(video,0,0,1,1); // neeed to image vifeo at least once in p3d
  noStroke();
}

void draw() {
  background(0);
  lights();                                                       // need to call lights in the draw() to get the 3D shaded
  translate(width/2, height/2);                                   // translating to center of screen 
  scale(mouseY/100.0);                                            // scaling to create the zoom effect with mouseY
  rotateY(radians(mouseX));                                       // rotating around Y axis acording to mouseX
  translate(-width/2, -height/2, 0);                             // translating back so our coordinates are synced between screen and video
  if (video.available ()) video.read();
  video.loadPixels();
  //video.filter(BLUR, 5);                                    // try bluring to soften
  for (int x=0; x< video.width-cell; x+= cell) {                      // visiting all pixels skipping every cell amount
    for (int y=0; y< video.height-cell; y+= cell) {
      beginShape();                                                  // we will make two triangles for each cell, start the first triangle

      PxPGetPixel(x, y, video.pixels, width);                      // get the RGB of our pixel        
      int brightness = (R+G+B)/-3;
      fill(R, G, B);
      vertex (x, y, brightness);

      PxPGetPixel(x+cell, y, video.pixels, width);                  //get the RGB of the top right
      brightness = (R+G+B)/-3;
      fill(R, G, B);
      vertex (x+cell, y, brightness);

      PxPGetPixel(x+cell, y+cell, video.pixels, width);            //get the RGB of the bottom right
      brightness = (R+G+B)/-3;
      fill(R, G, B);
      vertex (x+cell, y+cell, brightness);

      endShape(CLOSE);                                              // close the first triangle

      beginShape();                                                 // start second triangle

      PxPGetPixel(x+cell, y+cell, video.pixels, width);            //get the RGB of the bottom right
      brightness = (R+G+B)/-3;
      fill(R, G, B);
      vertex (x+cell, y+cell, brightness);

      PxPGetPixel(x, y+cell, video.pixels, width);                 //get the RGB of the bottom left
      brightness = (R+G+B)/-3;
      fill(R, G, B);
      vertex (x, y+cell, brightness);

      PxPGetPixel(x, y, video.pixels, width);                      //get the RGB of the top left
      brightness = (R+G+B)/-3;
      fill(R, G, B);
      vertex (x, y, brightness);

      endShape(CLOSE);                                             // close the second triangle
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
