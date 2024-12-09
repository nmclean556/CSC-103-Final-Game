class Boss {

  PImage willAsADemon;
  PImage willAsADemonLeftSide;
  PImage bossDedL;
  PImage bossDedR;

  

  int x;
  int y;
  int s;


  int headX;
  int headY;

  int jumpSpeed;
  int jumpHeightY;
  int jumpHeight;

  int startTime;
  int currentTime;
  int interval = 5000;
  int timer = 5;

  int attackStartTime;
  int attackCurrentTime;
  int attackInterval = 1000;

  boolean isJump;
  boolean isFall;

  int attack;

  boolean iCastFireball;

  int top;
  int bottom;
  int left;
  int right;

  int attackPower;
  int damageInflicted;
  int health;

  boolean isDead;

  boolean isAttacking;
  boolean isFirstJump;

  int attackTop;
  int attackBottom;
  int attackLeft;
  int attackRight;

  int hBX;
  int hBY;
  int hBW;
  int hBH;

  int adHBX;
  int adHBY;
  int adHBW;
  int adHBH;


  boolean playerHealthDecrease;
  
  boolean noise;


  Boss(int startX, int startY/*, int size*/) {
    rectMode(CENTER);
    imageMode(CENTER);

    willAsADemon = loadImage("willAsADemon.png");
    willAsADemonLeftSide = loadImage("willAsADemonLeftSide.png");
    bossDedL = loadImage("bossDedL.png");
    bossDedR = loadImage("bossDedR.png");
    
    x = startX;
    y = startY;
    s = 150;

    jumpSpeed = 15;
    jumpHeight = 1000;

    startTime = millis();

    attackPower = 30;
    damageInflicted = 0;
    health = 500;

    isFirstJump = true;
    print(isFirstJump);

    top = y - s / 2;
    bottom = y + s / 2;
    left = x - s / 2;
    right = x + s / 2;

    hBX = x- s / 2 - 1;
    hBY = y - s * 2 - 1;
    hBW = health / 2;
    hBH = 9;

    adHBX = you.x - you.s / 2 - 1;
    adHBY = you.y - you.s * 2 - 1;
    adHBW = s - 1;
    adHBH = 9;
    
    
  }


  void render() {

    //if(x < width / 2){
    if (you.x > x) {
      image(willAsADemonLeftSide, x, y, (s * 4), s*4);
      
    } else {
      image(willAsADemon, x, y, s * 4, s*4);
      
    }

    //}
    //else if(x > width / 2){
    //  image(willAsADemon, x, y, -s *4, s*4);


    //}

    //noStroke();
    //fill(#6F2522);
    //head();
    //body();
    //legs();


    //fill(0);
    //text(damage, width - 100, height - 100);

    //rectMode(CORNER);
    //rect(adHBX, adHBY, adHBW, adHBH);
  }

  void head() {
    headX = x;
    headY = y - s;
    int headSize = s;

    circle(headX, headY, headSize);
  }


  void body() {
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


  void legs() {

    int legX1 = x - s / 3;
    int legX2 = x + s / 3;
    int legY = y + s / 2;
    int legThickness = s / 3;
    int legLength = s / 2;


    rect(legX1, legY, legThickness, legLength, 25);
    rect(legX2, legY, legThickness, legLength, 25);
  }


  //sets up how often enemy attacks
  void attackPattern() {


    currentTime = millis();

    if (isFirstJump == true) {
      isJump = true;
      isFirstJump = false;
    }

    //timer if statement
    else if (currentTime - startTime > interval) {
      //println(timer, "seconds");


      attack = int(random(0, 3));
      println("attack", attack);
      





      if (attack == 1) {
        isJump = true;
        jumpHeightY = y - jumpHeight;
      }

      if (attack == 2) {
        iCastFireball = true;
        
      if (bossNoises2.isPlaying() == false) {
      bossNoises2.play();
    }
      
    }
      

      startTime = millis();
  }

    currentTime = millis();

    //timer if statement
    if (attackCurrentTime - attackStartTime > attackInterval) {
      //println(timer);
      attackStartTime = millis();
      isAttacking = !isAttacking;
    }




    top = y - s / 2;
    bottom = y + s / 2;
    left = x - s / 2;
    right = x + s / 2;
  }




  void jumping() {

    if (isJump == true) {
      y -= jumpSpeed;
    }
  }

  void falling() {

    if (isFall == true) {
      y += jumpSpeed;
    }
  }


  void topOfJump() {

    if (y <= jumpHeightY) {

      if (x >= width / 2) {
        x = 300;
      } else if (x <= width / 2) {
        x = width -300;
      }


      isJump = false;
      isFall = true;
    }
  }

  void land() {

    if (y >= height /2) {
      isFall = false;
      y = height /2;
    }
  }


  void bossDeath() {
    if (damageInflicted >= health) {
      isDead = true;
      print(isDead);
    }
  }



  void bossAttackPlayer(Player aPlayer) {

    if (attackTop < aPlayer.bottom &&
      attackBottom > aPlayer.top &&
      attackLeft < aPlayer.right &&
      attackRight > aPlayer.left && isAttacking == true) {
      aPlayer.health -= attackPower;
      isAttacking = false;
    }
  }

  //allows player to attack enemy
  void playerAttackBoss(Player aPlayer) {
    if (aPlayer.swordTop < bottom &&
      aPlayer.swordBottom > top &&
      aPlayer.swordLeft < right &&
      aPlayer.swordRight > left &&
      aPlayer.attacking == true) {

      println("hit");
      health -= aPlayer.attackPower;

      
    }
  }

  //enemy health bar
  void bossHealthDeterioration() {
  rectMode(CORNER);
    hBX = x- s / 2;
    hBY = y - s * 2;
    
    hBW = health /2;
    
    fill(0);
    rect(hBX, hBY, 250, hBH);
    fill(0, 255, 0);
    rect(hBX, hBY, hBW, hBH);
    fill(0);

    
  }
}
