// The world pixel by pixel 2021
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
  for (int x = 0; x < width; x+=cellSize) {
    for (int y = 0; y < height; y+=cellSize) {
      float pixBrigtness= brightness( ourVideo.get(x, y));   // get the brightness of the pixel under the cell
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
