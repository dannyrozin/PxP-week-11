Shard[] shards = new Shard[0];
PImage theTextureImage;
float angle= 1;
float dir = 0.01;
boolean fall = false;
void setup() {
  size (1280, 720, P3D);
  theTextureImage= loadImage("http://hellogiggles.com/wp-content/uploads/2015/05/29/piglets-hd-photos-7.jpg");
  theTextureImage.resize(width, height);
  noStroke();
}

void draw() {
  //lights();
  background(0);
  angle+=dir;
  if (angle > 1.8 || angle < 0.2 )dir = -dir ;
  println (angle);
  for (int i = 0 ;i< shards.length;i++){
    shards[i].drawShard();
  }
    
    
}


class Shard {
  int[][] corners=new int[4][2];
  int locX, locY, locZ;
  int fallY= 0;

  Shard(int x, int y) {
    locX= x;
    locY= y;
   

    for (int i = 0; i < 4; i++) {
      int randi= (int)random (10, 120);
      corners[i][0]= randi;
       randi= (int)random (10, 120);
      corners[i][1]= randi;
    }
  }
  
  void drawShard(){
    
    
    int locYToUse = 0;
    if (fall ){
      fallY++;       
      locYToUse= locY+fallY;
      if (locYToUse> height-100) fallY--;
     }else{
      fallY= (fallY*999)/1000;   
      fallY = max(0, fallY);
      locYToUse= locY+fallY;
     } 
     
    pushMatrix();
    translate (locX,locYToUse);
    rotateY(angle);
     beginShape();
  texture(theTextureImage);
  vertex(0- corners[0][0], 0- corners[0][1], 0, locX- corners[0][0], locY- corners[0][1]);
   vertex(0+ corners[1][0], 0- corners[1][1], 0, locX+ corners[1][0], locY- corners[1][1]);
     vertex(0+corners[2][0], 0+ corners[2][1], 0, locX+ corners[2][0], locY+corners[2][1]);
       vertex(0- corners[3][0], 0+ corners[3][1], 0, locX- corners[3][0], locY+ corners[3][1]);
  endShape(CLOSE);
  popMatrix();
    
  }
}


void mousePressed(){
  shards= (Shard[]) append(shards, new Shard(mouseX, mouseY));
}
void keyPressed(){
  fall= ! fall;

}