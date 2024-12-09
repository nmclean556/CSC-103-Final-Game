class Enemy{
  
PImage goblinLeft;
PImage goblinRight;

//enemy vars
int x;
int y;
int s;

int attackPower;
int damageInflicted;
int health;
int knockbackDis;

boolean hit;

int headX;
int headY;

int speed;
  
boolean isUp;
boolean isDown;
boolean isLeft;
boolean isRight;  
  
int top;
int bottom;
int left;
int right; 

boolean isAttacking;

int attackTop;
int attackBottom;
int attackLeft;
int attackRight;

int startTime;
int currentTime;
int interval = 1000;
int timer = 1;

boolean isDead;



int adHBX;
int adHBY;
int adHBW;
int adHBH;


boolean playerHealthDecrease;
  
  
//constructor
Enemy(int startX, int startY, int power/*int health, int size, color c*/){
    rectMode(CENTER);
    imageMode(CENTER);
    
    goblinLeft = loadImage("goblinLeft.png");
    goblinRight = loadImage("goblinRight.png");
    x = startX;
    y = startY;
    s = 75; 
    
    attackPower = power;
    damageInflicted = 0;
    health = 50;
    knockbackDis = s;
    
    hit = false;
    
    speed = 1;
    
    top = y - s / 2;
    bottom = y + s / 2;
    left = x - s / 2;
    right = x + s / 2;
  
    startTime = millis();
    
    
  
    adHBX = you.x - you.s / 2 - 1;
    adHBY = you.y - you.s * 2 - 1;
    adHBW = s - 1;
    adHBH = 9;

}
  
void render(){
  

  if (you.x > x) {
      image(goblinRight, x, y, (s * 4), s*4);
    } else {
      image(goblinLeft, x, y, s * 4, s*4);
    }
  //fill(50, 0, 0);
  //head();
  //body();
  //legs();
  
  
  //fill(0);
  //text(damageInflicted, width - 100, height - 100);
  
  //rectMode(CORNER);
  //rect(adHBX, adHBY, adHBW, adHBH);
  
  
  //image(goblin, x, y, s*4,s*4);
  
}

void head(){
  headX = x;
  headY = y - s;
  int heEnemyize = s;

  circle(headX, headY, heEnemyize);
  
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
  
//allows enemies to move
void move(){

  if (isUp == true) {
    y -= speed;
  }

  if (isDown == true) {
    y += speed;
  }
  
  if (isLeft == true) {
    x -= speed;
  }

  if (isRight == true) {
    x += speed;
  }

  top = y - s / 2;
  bottom = y + s / 2;
  left = x - s / 2;
  right = x + s / 2;
}
 
//allows enemies to follow player
void enemyFollowPlayer(Player aPlayer){
  
  if(y > aPlayer.y + aPlayer.s){
    isUp = true;
  }
  else{
    isUp = false;
  }
  if(y < aPlayer.y - aPlayer.s){
    isDown = true;
  }
  else{
    isDown = false;
  }
  if(x > aPlayer.x + aPlayer.s){
    isLeft = true;
  }
  else{
    isLeft = false;
  }
  if(x < aPlayer.x - aPlayer.s){
    isRight = true;
  }
  else{
    isRight = false;
  }
  
}
  
//void collide(Player aPlayer){
    
//    if (top < aPlayer.bottom &&
//        bottom > aPlayer.top &&
//        left < aPlayer.right &&
//        right > aPlayer.left){
          
//          println("colliding");
    
  
//    } 
//} 

//allows enemies to attack player
void enemyAttack(Player aPlayer){
  if(isAttacking == true){
    attackTop = y - s;
    attackBottom = y + s;
    attackLeft = x - s;
    attackRight = x + s;
  }
  else{
    attackTop = -200;
    attackBottom = -200;
    attackLeft = -200;
    attackRight = -200;
  }
  
  if (attackTop < aPlayer.bottom &&
      attackBottom > aPlayer.top &&
      attackLeft < aPlayer.right &&
      attackRight > aPlayer.left){
        
        
        
        println("hit");
        
        if (enemyNoises.isPlaying() == false) {
        enemyNoises.play();
        }
        aPlayer.health -= attackPower;
        isAttacking = false;
        
  }  
  
  
}

//sets up how often enemy attacks
void attackPattern(){
  
  currentTime = millis();
  
  //timer if statement
  if (currentTime - startTime > interval){
    println(timer);
    startTime = millis();
    isAttacking = !isAttacking;
  }
  
  
}
  
//allows player to attack enemy
void playerAttackEnemy(Player aPlayer){
  if (aPlayer.swordTop < bottom &&
      aPlayer.swordBottom > top &&
      aPlayer.swordLeft < right &&
      aPlayer.swordRight > left && 
      aPlayer.attacking == true){
        
        println("hit");
        health -= aPlayer.attackPower; 


    
 }
 
}

//sets up enemies abilities to disappear 
void enemyDeath(Player aPlayer){
  if (damageInflicted >= health){
    isDead = true;
    aPlayer.health = 200;
  }
  
}



//enemy health bar
void enemyHealthDeterioration(){
  rectMode(CORNER);
    adHBX = x- s / 2;
    adHBY = y - s * 2;
    
    adHBW = health *2;
    
    fill(0);
    rect(adHBX, adHBY, 100, adHBH);
    fill(0, 255, 0);
    rect(adHBX, adHBY, adHBW, adHBH);
    fill(0);

    
  }



















}
