class Player{
PImage playerL;
PImage player;

//player vars
  //player position vars
  int x;
  int y;
  int s;

  //head vars
  int headX;
  int headY;

  color clothes;
  color skinTone;
  color hairCol;
  color hairCol2;
  color eyeCol;

  boolean isUp;
  boolean isDown;
  boolean isLeft;
  boolean isRight;

  int speed;

  int top;
  int bottom;
  int left;
  int right;

  int health;
  int attackPower;

  boolean attacking;

  boolean attackUp;
  boolean attackDown;
  boolean attackLeft;
  boolean attackRight;

  int swordTop;
  int swordBottom;
  int swordLeft;
  int swordRight;
  
  boolean ded;
  
  int hBX;
  int hBY;
  int hBW;
  int hBH;


//constructor
  Player(int tempX, int tempY, int tempD, color c1, color c2, color c3, color c4) {
    x = tempX;
    y = tempY;
    s = tempD;
    hairCol = c1;
    skinTone = c2;
    clothesCol = c3;
    hairCol2 = c4;

    isUp = false;
    isDown = false;
    isLeft = false;
    isRight = false;

    speed = 5;

    health = 200;
    attackPower = 20;

    attacking = false;

    attackUp = false;
    attackDown = false;
    attackLeft = false;
    attackRight = false;
    
    player = loadImage("you.png");
    
    ded = false;
    
    hBX = x- s / 2 - 1;
    hBY = y - s * 2 - 1;
    hBW = s - 1;
    hBH = 9;
  }





  ///////////////////////////////////////////////////////////////////////////////////
void render() {
  
  noStroke();
  fill(100);
  //head();
  //body();
  //legs();
  
  image(player, x, y, s * 5, s*5);
  //fill(0);
  //text(damage, width - 100, height - 100);
  
  //rectMode(CORNER);
  //rect(adHBX, adHBY, adHBW, adHBH);
  
}
 
void head(){
  headX = x;
  headY = y - s;
  int headSize = s;

  circle(headX, headY, headSize);
  
}


void body(){
  int neckW = s / 3;
  int armsX = x;
  int armsY = y - s / 5;
  int armsY2 = y;
  int armsW = s + s / 4;
  int armsW2 = s + s / 4;
  int armsH = s / 2;
  
  rect(armsX, armsY2, armsW2, armsH, 15);
 
  rect(x, y, s, s, 25);
  rect(armsX, armsY, armsW, armsH, 15);
  
  ellipse(x, y - s / 2, neckW, s / 7);
  
}


void legs(){
  
  int legX1 = x - s / 3;
  int legX2 = x + s / 3;
  int legY = y + s / 2;
  int legThickness = s / 3;
  int legLength = s / 2; 


  rect(legX1, legY, legThickness, legLength, 25);
  rect(legX2, legY, legThickness, legLength, 25); 
  
  
}

//movements
  ///////////////////////////////////////////////////////////////////////////////////
  void move() {



    if (isUp == true && y >= 0 - s / 2) {
      y -= speed;
    }

    if (isDown == true && y <= height + s / 2) {
      y += speed;
    }

    if (isLeft == true && x >= - s / 2) {
      x -= speed;
    }

    if (isRight == true && x <= width + s / 2) {
      x += speed;
    }

    //updates player bounds
    top = y - s /2;
    bottom = y + s /2;
    left = x - s / 2;
    right = x + s / 2;
  }

  ///////////////////////////////////////////////////////////////////////////////////

//determines which way player can attack from
  void attackDirection() {

    if (attacking == true && attackUp == true) {
      swordTop = y - s - s / 2;
      swordBottom = y + s / 2;
      swordLeft = x - s / 2;
      swordRight = x + s / 2;
      //println("attacking up");
      
    } else if (attacking == true && attackDown == true) {
      swordTop = y - s / 2;
      swordBottom = y + s + s / 2;
      swordLeft = x - s / 2;
      swordRight = x + s / 2;
      //println("attacking down");
      
    } else if (attacking == true && attackLeft == true) {
      swordTop = y - s / 2;
      swordBottom = y + s / 2;
      swordLeft = x - s - s / 2;
      swordRight = x + s / 2;
      //println("attacking left");
      
    } else if (attacking == true && attackRight == true) {
      swordTop = y - s / 2;
      swordBottom = y + s / 2;
      swordLeft = x - s / 2;
      swordRight = x + s + s / 2;
      //println("attacking right");
    }
  }
  

//sets up player health bar border
//the actual heath bar is set up in ads tab
  //void healthBar(){
  //  rectMode(CORNER);
    
  //  int borderHBX = x- s / 2;
  //  int borderHBY = y - s * 2;
  //  int borderHBW = s;
  //  int borderHBH = 10;
    
    
    
  //  fill(0);
  //  rect(borderHBX, borderHBY, borderHBW, borderHBH);
  //  //fill(0,255,0);
  //  //rect(hBX, hBY, hBW, hBH);
  //  //fill(0);
  //}
  
  //player health bar
void playerHealthDeterioration(){
  rectMode(CORNER);
    hBX = x- s / 2;
    hBY = y - s * 2;
    
    hBW = health /2;
    
    fill(0);
    rect(hBX, hBY, 100, hBH);
    fill(0, 255, 0);
    rect(hBX, hBY, hBW, hBH);
    fill(0);

    
  }
  
  
void youDed(){
  
  if(health <= 0){
    ded = true;
    //print ("you ded");
    
  }
}
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}
