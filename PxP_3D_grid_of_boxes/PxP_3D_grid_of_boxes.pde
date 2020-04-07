// The world pixel by pixel 2020
// Daniel Rozin
// creates 3D grid of boxes
// move mouse X Y to rotate



void setup() {
  size (700, 700, P3D);                      // must be P3D
  fill(255, 0, 255);
  noStroke();
  smooth();
}

void draw() {
  lights();                                 // must call lights() in draw() or it wont work
  background(0);
  translate(width/2, height/2, -200);       // translating to the center of screen so we can rotate around center
  rotateX(mouseY/100.0);                     // rotating on X, and Y with mouse
  rotateY(mouseX/100.0);
  translate(-width/2, -height/2, 200);     // after establishing the rotation we reverse the translation for the rest of the drawing

  int spacing = 40;
  translate (100, 100);                    // translating left and down a bit so we dont start at the corner
  for (int x= 0;x< 12;x++) {               // 3 repeat loops of 12 yield 1728 boxes
    for (int y= 0;y< 12;y++) {
      for (int z= 0;z< 12;z++) {
        pushMatrix();                      // for each box we will translate to where we want so we say pushMatrix, so we can revert to it
        translate(x*spacing, y*spacing, -z*spacing);    // translating by absolute amounts on the X,Y,Z
        fill(x*20, y*20, z*20);                            // setting a fill color based on X,Y,Z
        box(12);                                            // the4 box is always drawn at 0,0,0 but since we did a transaltion it will be in the right lace
        popMatrix();                                    // revertig our matrix so it will be ready for the next box
      }
    }
  }
}
