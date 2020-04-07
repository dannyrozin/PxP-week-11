
// The world pixel by pixel 2020
// Daniel Rozin
// draw shapes with texture
// drag mouse to draw shapes

Shard[] shards = new Shard[0];                   //an empty array that will hold our shard objects as we add them
PImage pigs;                         
float angle= 1;
float dir = 0.01;
void setup() {
  size (1280, 720, P3D);
  pigs= loadImage("http://hellogiggles.com/wp-content/uploads/2015/05/29/piglets-hd-photos-7.jpg");
  pigs.resize(width, height);
  noStroke();
}

void draw() {
  //lights();
  background(0);
  angle+=dir;                                          // increment our rotation angle
  if (angle > 1.8 || angle < 0.2 )dir = -dir ;         // change direction
  
  for (int i = 0; i< shards.length; i++) {            // visit all our shards
    shards[i].drawShard();                            // draw all our shards
  }
}

class Shard {                                        // class to hold shard data and functions 
  int[] pointXs=new int[0];                          // arrays to hold all the points of the shape
  int[] pointYs=new int[0];

  int locX, locY, locZ;                             // ints to hold the center of the shapes                                   

  Shard(int x, int y) {                             // constructor
    pointXs= append(pointXs, x);                    // add the x, y to the arrays
    pointYs= append(pointYs, y);
    locX=x;                                     
    locY=y;
  }

  void addPoint(int x, int y) {                   // function to add points to the shape
    pointXs= append(pointXs, x);                  // add the x, y to the arrays
    pointYs= append(pointYs, y);
    locX+= x;                                    // sum the x and y so we can average to get center 
    locY+= y;
  }
  
void drawShard() {                               // function to draw the shard   
  int centerX= locX/pointXs.length;              // find the average x for center of rotation
    pushMatrix();
    translate (centerX, 0);                       // translate to center of shard
    rotateY(angle);                               // rotate around center of shard

    beginShape();                                // start the shape
    texture(pigs);                                // use our PImage as texture
    for (int i= 0; i< pointXs.length; i++) {
      vertex(pointXs[i]-centerX, pointYs[i], 0, pointXs[i], pointYs[i]);                //use our arrays x and y to define the vertexes and the points on the texture
    }
    endShape(CLOSE);                                                                    // end the shape
    popMatrix();                                                                       // pop our matrix
  }
}


void mousePressed() {
  shards= (Shard[]) append(shards, new Shard(mouseX, mouseY));                        // when the mouse is pressed we start a new shard by calling new(0 and adding to our array
}

void mouseDragged () {
  shards[shards.length-1].addPoint(mouseX, mouseY);                                   // when the mouse is draged we add the mouseX and Y to the last shard arays
}
