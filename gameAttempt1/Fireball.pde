class Fireball{
  
PImage fireball;
  
  
int x;
int y;
//int s;

int xSpeed;
int ySpeed;

int attackTop;
int attackBottom;
int attackLeft;
int attackRight;

boolean hit;

boolean remove;


Fireball(int startX, int startY){
  
  x = startX;
  y = startY;
  
  xSpeed = int(random(5, 10));//int(random(1,10));
  ySpeed = int(random(-5, 5));//int(random(1,10));
  
  //println(xSpeed,   ySpeed);
  
  attackTop = y - 25;
  attackBottom = y + 25;
  attackLeft = x - 25;
  attackRight = x + 25;
  
  //fireball = loadImage("fireball.png");
  
  remove = false;
  
}
  
void render(){
  
  fill(#C4581A);
  circle(x, y, 50);
  //fill(200);
  
  //image(fireball, x, y, 300, 300);
  
}
  
void move(Boss aBoss) {
    
  if(aBoss.x <= width / 2){
    x += xSpeed;
  }
  else if (aBoss.x >= width / 2){
    x -= xSpeed;
  }
    y -= ySpeed;
    
    attackTop = y - 25;
    attackBottom = y + 25;
    attackLeft = x - 25;
    attackRight = x + 25;
    
  }
  

  
  void hitsPlayer(Player aPlayer){

     if (attackTop < aPlayer.bottom &&
      attackBottom > aPlayer.top &&
      attackLeft < aPlayer.right &&
      attackRight > aPlayer.left){
        hit = true;
        //print(hit);
        aPlayer.health -= 2;
        //print("Fireball hit");
      }
  }
  
  //allows enemies to follow player
void outOfBounds(){
  
  if(y < 0){
    remove = true;
  }
  
  if(y > height){
    remove = true;
  }
  
  if(x > width){
    remove = true;
  }
  
  if(x < 0){
    remove = true;
  }
  
  
}
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}
