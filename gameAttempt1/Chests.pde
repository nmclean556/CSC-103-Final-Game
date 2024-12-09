class Chests{
 
PImage chest;
  
//chest vars
int x;
int y;
int w;
int h;

boolean openChest;
boolean isOpened;

int top;
int bottom;
int left;
int right;

int chest1Roll;
int chest2Roll;
int chest3Roll;

int chest1RoomNumber;
int chest2RoomNumber;
int chest3RoomNumber;



//constructor
Chests(){
  imageMode(CENTER);
  
  x = width / 2;
  y = height / 2;
  w = 100;
  h = 50;
  
  openChest = false;
  isOpened = false;
  
  top = y - h / 2;
  bottom = y + h / 2;
  left = x - w / 2;
  right = x + w / 2;
  
  chest = loadImage("chest.png");
  
  
}

//render
void render(){
 rectMode(CENTER);
 
 //fill(#4D3114);
 rect(x, y, w, h);
  
 text("press 'e' to open", 300, 100); 
 image(chest, x, y, w * 2, h*4);
}
  
//sets condition that player can open chests once
void collision(Player aPlayer){
  
  if (top < aPlayer. bottom &&
        bottom > aPlayer.top &&
        left < aPlayer.right &&
        right > aPlayer.left
        && openChest == true 
        && isOpened == false){
          println("opening");
          isOpened = true;
  
  }
  
  
}
  

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}
