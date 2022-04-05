// The world pixel by pixel 2022
// Daniel Rozin
// Wooden Mirror- grid of boxes rotating in 3D according to pixel brightnesss
// drag mouse to change box sizes
import processing.video.*;
Capture ourVideo;
int cellSize= 30;                  // the size of each element

void setup() {
  size(1280, 720, P3D);              // must use P3D for any 3D stuff
  String videoList[]= Capture.list();
  ourVideo=new Capture(this, width, height, videoList[0]);
  ourVideo.start();
  noStroke();
  fill(255, 200, 150);
}

void draw() {
  directionalLight(255, 255, 255, 0, 1, -1);   //light from above to shade the tilting tiles
  background (0);
  if (ourVideo.available()) ourVideo.read();
  image(ourVideo,0,0,60,40);                   // somehow needed fro video when in P3D
  ourVideo.loadPixels();
  for (int x = 0; x < width; x+=cellSize) {
    for (int y = 0; y < height; y+=cellSize) {
      PxPGetPixel(x, y, ourVideo.pixels, width);                    // get the RGB of the pixel
      float pixBrigtness = (R+G+B)/3;   
     
      pushMatrix();                                          // if we dont push and pop the matrix our transformations will accumolate
      translate(x, y); 
      rotateX(pixBrigtness/150.00-0.8);                      // rotateX rotates around the X axis
      box(cellSize-2, cellSize-2, cellSize/4);
      popMatrix();
    }
  }
}
void mouseDragged() {
  cellSize= (int)map(mouseX, 0, width, 5, 50);
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
