import processing.sound.*;

SoundFile deathScream;
SoundFile walking;
SoundFile bossNoises2;
SoundFile enemyNoises;
SoundFile gameMusic;
SoundFile win;

//case vars
PImage background;
PImage keys;
PImage swordUp;
PImage swordDown;
PImage swordL;
PImage swordR;
PImage youWin;
PImage hell;


PImage bossDedL;
PImage bossDedR;

int state;

//charcter vars
color skinCol;
color hairCol;
color hairCol2;
color clothesCol;

int playerX;
int playerY;

//calls classes
Player you;
Enemy ad1;
Boss b1;
Fireball f1;


Chests chest1;
Chests chest2;
Chests chest3;

Buttons respawnButton;

//makes array list
ArrayList<Player> characterList;

ArrayList<Enemy> enemyList2;
ArrayList<Enemy> enemyList3;
ArrayList<Enemy> enemyList4;
ArrayList<Enemy> enemyList5;
ArrayList<Enemy> enemyList6;
ArrayList<Enemy> enemyList7;
ArrayList<Enemy> enemyList8;


ArrayList<Chests> chestList;
ArrayList<Boss> bossList;
ArrayList<Fireball> fireballList;

ArrayList<Buttons> buttonList;

//stops rapid attacking by player
int attackCooldown;

//stops enemies from  responing after death
boolean enemiesAround;

boolean enemiesNeeded;

int needEnemyRoom1Roll;
int needEnemyRoom2Roll;
int needEnemyRoom3Roll;
int needEnemyRoom4Roll;
int needEnemyRoom5Roll;
int needEnemyRoom6Roll;
int needEnemyRoom7Roll;
int needEnemyRoom8Roll;

boolean room1Enemies;
boolean room2Enemies;
boolean room3Enemies;
boolean room4Enemies;
boolean room5Enemies;
boolean room6Enemies;
boolean room7Enemies;
boolean room8Enemies;

boolean needChest1;
boolean needChest2;
boolean needChest3;

int chest1Roll;
int chest2Roll;
int chest3Roll;

int chest1RoomNumber;
int chest2RoomNumber;
int chest3RoomNumber;

boolean chest1Opened;
boolean chest2Opened;
boolean chest3Opened;

int fadeStartTime;
int fadeEndTime;
int fadeInterval;
int fadeClock = 1;


//death text vars
String death;
int textX;
int textY;

int textOpacity;


boolean isColor = true;
boolean musicPlaying;


///////////////////////////////////////////////////////////////////////////////////
void setup() {
  size(1200, 1000);
  rectMode(CENTER);
  imageMode(CENTER);

  background = loadImage("background.jpg");
  keys = loadImage("key.png");
  swordUp = loadImage("swordUp.png");
  swordDown = loadImage("swordDown.png");
  swordL = loadImage("swordL.png");
  swordR = loadImage("swordR.png");
  bossDedL = loadImage("bossDedL.png");
  bossDedR = loadImage("bossDedR.png");
  youWin = loadImage("youWin.png");
  hell = loadImage("hell.jpg");

  //initializing vars above
  state = 0;

  playerX = width / 2;
  playerY = height / 2;



  hairCol = color(0);
  hairCol2 = color(#343434);
  skinCol = color(#E3C8A5);
  clothesCol = color(0);

  attackCooldown = 1;

  //needEnemyRoll = int(random(0,1));


  chest1RoomNumber = int(random(2, 5));
  chest2RoomNumber = int(random(5, 7));
  chest3RoomNumber = int(random(7, 9));

  println(chest1RoomNumber, chest2RoomNumber, chest3RoomNumber);


  needChest1 = false;
  needChest2 = false;
  needChest3 = false;




  //creates classes within setup/draw tab
  you = new Player(playerX, playerY, 75, hairCol, skinCol, clothesCol, hairCol2);
  ad1 = new Enemy(width - 200, height / 2, 50);
  b1 = new Boss(int(random(width/2-1, width/2+1)), height/2);
  f1 = new Fireball(width / 2, height/2);



  chest1 = new Chests();
  chest2 = new Chests();
  chest3 = new Chests();

  respawnButton = new Buttons(width/2, height -300, 300, 100, color(200));

  //makes arraylist

  enemyList2 = new ArrayList();
  enemyList3 = new ArrayList();
  enemyList4 = new ArrayList();
  enemyList5 = new ArrayList();
  enemyList6 = new ArrayList();
  enemyList7 = new ArrayList();
  enemyList8 = new ArrayList();

  buttonList = new ArrayList();


  bossList = new ArrayList();
  fireballList = new ArrayList();

  chestList = new ArrayList();


  //sets enemiesAround to true
  enemiesAround = true;

  needEnemyRoom1Roll = int(random(1, 3));
  needEnemyRoom2Roll = int(random(1, 3));
  needEnemyRoom3Roll = int(random(1, 3));
  needEnemyRoom4Roll = int(random(1, 3));
  needEnemyRoom5Roll = int(random(1, 3));
  needEnemyRoom6Roll = int(random(1, 3));
  needEnemyRoom7Roll = int(random(1, 3));
  needEnemyRoom8Roll = int(random(1, 3));

  roomEnemies();


  room2Enemies = true;
  room3Enemies = true;
  room4Enemies = true;
  room5Enemies = true;
  room6Enemies = true;
  room7Enemies = true;
  room8Enemies = true;

  println(needEnemyRoom1Roll);

  size(1200, 1000);

  deathScream = new SoundFile(this, "toTheHellFire.wav");
  walking = new SoundFile(this, "walking.wav");
  bossNoises2 = new SoundFile(this, "bossNoises2.mp3");
  enemyNoises = new SoundFile(this, "EnemyNoises.mp3");
  gameMusic = new SoundFile(this, "gameMusic.mp3");
  win = new SoundFile(this, "win.mp3");

  death = "YOU DIED";


  fadeStartTime = millis();
  fadeInterval = 200;
}

///////////////////////////////////////////////////////////////////////////////////
void draw() {
  background(42);
  textSize(50);
  image(background, width/2, height/2);
  text(you.health, 100, height - 100);
  //class player class functions
  //for(Player aPlayer : characterList){

  for (Chests aChest : chestList) {

    aChest.render();

    aChest.collision(you);
  }
  //chestLocations();
  allChestsFound();


  //you will find a lot of these in random places
  //this means i did weird stuff that effected other stuff
  //will be more organized in the future
  rectMode(CENTER);

  //sets procedure to deal with enemies


  //for(Chests aChest : chestList){
  //  aChest.render();
  //  aChest.render();
  //  aChest.collision(you);
  //  //aBall.move();
  //  //aBall.wallDetect();
  //}

  for (Boss aBoss : bossList) {
    aBoss.render();
    you.render();
    aBoss.attackPattern();
    aBoss.jumping();
    aBoss.falling();
    aBoss.topOfJump();
    aBoss.land();
    fireballAttack(b1);
    aBoss.bossAttackPlayer(you);
    aBoss.playerAttackBoss(you);
    aBoss.bossHealthDeterioration();
    aBoss.bossDeath();
  }

  for (Buttons aButton : buttonList) {
    aButton.render();
    //println("sup");
    //aButton.isPressed();
  }

  for (Fireball aFireball : fireballList) {
    aFireball.render();
    aFireball.move(b1);
    aFireball.hitsPlayer(you);
    aFireball.outOfBounds();
    //f1.wallDetect();

    //if(aFireball.hit == true){
    //  remove
    //}
  }

  //removes enemies upon death
  for (int i = fireballList.size()-1; i >= 0; i--) {
    Fireball aFireball = fireballList.get(i);
    if (aFireball.remove == true) {
      fireballList.remove(aFireball);
      println("out of bounds");
      println(fireballList.size());
    }
  }


  //}

  //roomEnemies();



  //removes enemies upon death
  for (int i = enemyList2.size()-1; i >= 0; i--) {
    Enemy anAd = enemyList2.get(i);
    if (anAd.isDead == true) {
      enemyList2.remove(anAd);
      println("ded enemy");
      enemiesAround = false;
    }
  }

  for (int i = enemyList3.size()-1; i >= 0; i--) {
    Enemy anAd = enemyList3.get(i);
    if (anAd.isDead == true) {
      enemyList3.remove(anAd);
      println("ded enemy");
      enemiesAround = false;
    }
  }

  for (int i = enemyList4.size()-1; i >= 0; i--) {
    Enemy anAd = enemyList4.get(i);
    if (anAd.isDead == true) {
      enemyList4.remove(anAd);
      println("ded enemy");
      enemiesAround = false;
    }
  }

  for (int i = enemyList5.size()-1; i >= 0; i--) {
    Enemy anAd = enemyList5.get(i);
    if (anAd.isDead == true) {
      enemyList5.remove(anAd);
      println("ded enemy");
      enemiesAround = false;
    }
  }

  for (int i = enemyList6.size()-1; i >= 0; i--) {
    Enemy anAd = enemyList6.get(i);
    if (anAd.isDead == true) {
      enemyList6.remove(anAd);
      println("ded enemy");
      enemiesAround = false;
    }
  }

  for (int i = enemyList7.size()-1; i >= 0; i--) {
    Enemy anAd = enemyList7.get(i);
    if (anAd.isDead == true) {
      enemyList7.remove(anAd);
      println("ded enemy");
      enemiesAround = false;
    }
  }

  for (int i = enemyList8.size()-1; i >= 0; i--) {
    Enemy anAd = enemyList8.get(i);
    if (anAd.isDead == true) {
      enemyList8.remove(anAd);
      println("ded enemy");
      enemiesAround = false;
    }
  }

  you.render();
  you.move();
  you.attackDirection();
  you.youDed();
  you.playerHealthDeterioration();
  sword();

  //calls finite statement machines
  finiteStateMachine();
  cases();



  //fireballAttack(b1);
  //println(state);
}

///////////////////////////////////////////////////////////////////////////////////
void finiteStateMachine() {
  rectMode(CENTER);
  textAlign(CENTER);
  textSize(50);

  switch (state) {

  case 0:
    you.ded =false;
    musicPlaying = true;
    //if(characterList.size() > 0){
    //  characterList.remove(you);
    // }

    image(hell, width/2, height/2, width, height);
    you.render();
    you.x = width/2;
    you.y = height -150;
    if (you.attacking == true) {
      state = 1;
    }

    fill(0);
    text("Press 'Space' to Enter", width / 2, 100);
    break;


  case 1:

    you.ded =false;
    //you.render();
    //you.move();
    //you.attackDirection();

    //if(characterList.size() == 0){
    //  characterList.add(you);
    //}

    //print(you.playerX);
    //you.healthBar();
    playerX = width - you.s / 2;

    you.render();
    you.move();
    you.attackDirection();
    you.youDed();
    you.playerHealthDeterioration();


    //chest1.render();
    //chest1.collision(you);
    //if(enemyList.size() > 0){
    //  enemyList.remove(0);
    // }


    text(state, width-100, 100);

    if (gameMusic.isPlaying() == false && musicPlaying == true) {
      gameMusic.play();
    }
    break;

  case 2:

    println(enemyList2.size());
    println(needEnemyRoom2Roll);

    for (Enemy anEnemy : enemyList2) {
      anEnemy.render();
      anEnemy.move();
      anEnemy.enemyFollowPlayer(you);
      //anAd.collide(you)
      anEnemy.enemyAttack(you);
      anEnemy.attackPattern();
      anEnemy.enemyDeath(you);
      anEnemy.enemyHealthDeterioration();
    }
    //if(state != 2){
    //  enemiesAround = true;

    //}
    //println("case 2: 1",enemiesAround);
    //  println("2", room2Enemies);

    playerX = you.s / 2;

    if (gameMusic.isPlaying() == false && musicPlaying == true) {
      gameMusic.play();
    }



    //if(room2Enemies == false){
    //   enemiesAround = true;

    //}

    //else if(needEnemyRoom2Roll == 0){
    //  room2Enemies = false;
    //  enemiesAround = true;
    //}

    //if(enemyList.size() == needEnemyRoom2Roll){
    //    room2Enemies = false;
    //    enemiesAround = true;
    //}


    fill(0);
    text(state, width-100, 100);
    break;


  case 3:


    //println("case 3: 1",enemiesAround);
    //println("2", room3Enemies);


    for (Enemy anEnemy : enemyList3) {
      anEnemy.render();
      anEnemy.move();
      anEnemy.enemyFollowPlayer(you);
      //anAd.collide(you)
      anEnemy.enemyAttack(you);
      anEnemy.attackPattern();
      anEnemy.enemyDeath(you);
      anEnemy.enemyHealthDeterioration();
    }
    //  if(enemyList.size() < needEnemyRoom3Roll /*&& enemiesAround == true*/ && room3Enemies == true && state == 3){
    //    enemyList.add(new Enemy(int(random(400, 801)), height / 2, 5));
    //    if(enemyList.size() == needEnemyRoom3Roll){
    //      print("full");
    //    }
    //  }
    //  else{
    //    if(enemyList.size() == 0){


    //    room3Enemies = false;
    //    }
    //}
    if (gameMusic.isPlaying() == false && musicPlaying == true) {
      gameMusic.play();
    }

    //if(room3Enemies == false){
    //    enemiesAround = true;

    // }

    //else if(needEnemyRoom3Roll == 0){
    //  room3Enemies = false;
    //  enemiesAround = true;
    //}

    //if(enemyList.size() == needEnemyRoom3Roll){
    //  room3Enemies = false;
    //  enemiesAround = true;


    ////if(enemyList.size() < needEnemyRoom3Roll && enemiesAround == true && state == 3){
    ////  enemyList.add(new Enemy(width - 200, height / 2, 10));
    ////}
    ////else{
    ////  if(enemyList.size() > 0){
    ////    enemyList.remove(0);
    ////  }

    //}

    //if(enemyList.size() == 0){
    //  enemiesAround = false;

    //}

    fill(0);
    text(state, width-100, 100);

    break;

  case 4:

    for (Enemy anEnemy : enemyList4) {
      anEnemy.render();
      anEnemy.move();
      anEnemy.enemyFollowPlayer(you);
      //anAd.collide(you)
      anEnemy.enemyAttack(you);
      anEnemy.attackPattern();
      anEnemy.enemyDeath(you);
      anEnemy.enemyHealthDeterioration();
    }


    fill(0);
    text(state, width-100, 100);

    if (gameMusic.isPlaying() == false && musicPlaying == true) {
      gameMusic.play();
    }

    break;

  case 5:

    for (Enemy anEnemy : enemyList5) {
      anEnemy.render();
      anEnemy.move();
      anEnemy.enemyFollowPlayer(you);
      //anAd.collide(you)
      anEnemy.enemyAttack(you);
      anEnemy.attackPattern();
      anEnemy.enemyDeath(you);
      anEnemy.enemyHealthDeterioration();
    }


    fill(0);
    text(state, width-100, 100);
    if (gameMusic.isPlaying() == false && musicPlaying == true) {
      gameMusic.play();
    }

    break;

  case 6:

    for (Enemy anEnemy : enemyList6) {
      anEnemy.render();
      anEnemy.move();
      anEnemy.enemyFollowPlayer(you);
      //anAd.collide(you)
      anEnemy.enemyAttack(you);
      anEnemy.attackPattern();
      anEnemy.enemyDeath(you);
      anEnemy.enemyHealthDeterioration();
    }
    if (gameMusic.isPlaying() == false && musicPlaying == true) {
      gameMusic.play();
    }

    fill(0);
    text(state, width-100, 100);

    break;

  case 7:


    for (Enemy anEnemy : enemyList7) {
      anEnemy.render();
      anEnemy.move();
      anEnemy.enemyFollowPlayer(you);
      //anAd.collide(you)
      anEnemy.enemyAttack(you);
      anEnemy.attackPattern();
      anEnemy.enemyDeath(you);
      anEnemy.enemyHealthDeterioration();
    }
    if (gameMusic.isPlaying() == false && musicPlaying == true) {
      gameMusic.play();
    }

    fill(0);
    text(state, width-100, 100);
    break;

  case 8:

    for (Enemy anEnemy : enemyList8) {

      anEnemy.render();
      anEnemy.move();
      anEnemy.enemyFollowPlayer(you);
      //anAd.collide(you)
      anEnemy.enemyAttack(you);
      anEnemy.attackPattern();
      anEnemy.enemyDeath(you);
      anEnemy.enemyHealthDeterioration();
    }

    if (gameMusic.isPlaying() == false && musicPlaying == true) {
      gameMusic.play();
    }
    fill(0);
    //text("room 8 -A", width/2, 100);
    //text("room 5 -V", width/2, height -100);
    //text("case 8", width / 2, height /2);
    //text("     <- room 7", 100, height / 2);
    text(state, width-100, 100);
    break;

  case 9:
    //if(enemyList.size() > 0){
    //    enemyList.remove(0);
    //   }


    if (bossList.size() < 1) {
      bossList.add(b1);
    }
    if (b1.isDead == true) {
      bossList.remove(b1);
    }

    if (b1.x < width/2 && b1.isDead== true) {
      image(bossDedL, b1.x, b1.y, (b1.s * 4), b1.s*4);
    } else {
      if (b1.isDead == true) {
        image(bossDedR, b1.x, b1.y, (b1.s * 4), b1.s*4);
      }
    }


    if (gameMusic.isPlaying() == false && musicPlaying == true) {
      gameMusic.play();
    }

    break;

  case 10: //death menu

    background(0);
    textSize(150);
    fill(255);
    //text("you ded", width/2, height/2);

    musicPlaying = false;


    if (deathScream.isPlaying() == false && you.ded == true) {
      deathScream.play();
    }


    deathText();



    //if (buttonList.size() < 1) {
    //  buttonList.add(respawnButton);
    //}
    //respawnButton.render();
    textSize(50);
    fill(150);
    text("Press 'Space' to Respawn", width /2, height -100);

    if (you.attacking == true) {
      state = 1;
      print("space");
    }

    break;

  case 11:

    musicPlaying = false;
    image(youWin, width/2, height/2);

    fill(150);
    text("Press 'Space' to Return Home", width /2, height -100);

    if (you.attacking == true) {
      state = 1;
      print("space");
      //you.x = width/2;
    }

    if (win.isPlaying() == false) {
      win.play();
    }


    break;
  }
}


void spawnEnemies() {
}



///////////////////////////////////////////////////////////////////////////////////
void cases() {

  //set conditionn in which you can switch between rooms
  room1();
  room2();
  room3();
  room4();
  room5();
  room6();
  room7();
  room8();
  room9();

  death();
}

void room1() {
  if (you.x >= width && state == 1) {

    //print(state);
    state = 2;
    you.x = you.s / 2;
  }
}

void room2() {
  if (you.x <= 0 && state == 2) {

    //print(state);
    state = 1;
    you.x = width - you.s / 2;
  }

  if (you.x >= width && state == 2) {

    //print(state);
    state = 3;
    you.x = you.s / 2;
  }

  if (you.y <= 0 && state == 2) {

    //print(state);
    state = 5;
    you.y = height - you.s / 2;
  }

  spawnChest();
}

void room3() {
  if (you.x <= 0 && state == 3) {

    //print(state);
    state = 2;
    you.x = width - you.s / 2;
  }

  if (you.y <= 0 && state == 3) {

    //print(state);
    state = 6;
    you.y = height - you.s / 2;
  }
}

void room4() {

  if (you.x >= width && state == 4) {

    //print(state);
    state = 5;
    you.x = you.s / 2;
  }

  if (you.y <= 0 && state == 4) {

    //print(state);
    state = 7;
    you.y = height - you.s / 2;
  }
}

void room5() {

  if (you.y >= height && state == 5) {

    //print(state);
    state = 2;
    you.y = you.s / 2;
  }

  if (you.y <= 0 && state == 5) {

    //print(state);
    state = 8;
    you.y = height - you.s / 2;
  }

  if (you.x <= 0 && state == 5) {

    //print(state);
    state = 4;
    you.x = width - you.s / 2;
  }

  if (you.x >= width && state == 5) {

    //print(state);
    state = 6;
    you.x = you.s / 2;
  }
}

void room6() {

  if (you.x <= 0 && state == 6) {

    //print(state);
    state = 5;
    you.x = width - you.s / 2;
  }

  if (you.y >= height && state == 6) {

    //print(state);
    state = 3;
    you.y = you.s / 2;
  }

  if (you.y <= 0 && state == 6 && chest1.isOpened == true
    && chest1.isOpened == true
    && chest1.isOpened == true) {

    //print(state);
    state = 9;
    you.y = height - 300;
    you.x = 300;
  }
}

void room7() {
  if (you.x >= width && state == 7) {

    //print(state);
    state = 8;
    you.x = you.s / 2;
  }

  if (you.y >= height && state == 7) {

    //print(state);
    state = 4;
    you.y = you.s / 2;
  }
}

void room8() {

  if (you.x <= 0 && state == 8) {

    print(state);
    state = 7;
    you.x = width - you.s / 2;
  }

  if (you.y >= height && state == 8) {

    //print(state);
    state = 5;
    you.y = you.s / 2;
  }
}

void room9() {

  if (b1.isDead == true && you.x >= width) {
    state = 11;
  }
}

void death() {

  if (you.ded == true) {
    state = 10;
    bossList.remove(b1);
  }
}

void deathText() {
  fadeEndTime = millis();

  fadeTimer();

  youDied(width / 2, height / 2, death);
}
void fadeTimer() {


  if (fadeEndTime - fadeStartTime > fadeInterval) {
    //println(clock);
    fadeStartTime = millis();
    fadeClock += 1;
    if (textOpacity <= 255) {
      textOpacity += 10;
    }
    println(textOpacity);
    isColor = !isColor;
  }
}

//////////////////////////////////////////////////////////////////////////////
void youDied(int x, int y, String s) {
  textAlign(CENTER);
  textSize(150);


  color c = color(textOpacity, 0, 0);
  fill(c);
  text(s, x, y);
}



void roomEnemies() {

  while (enemyList2.size() < needEnemyRoom2Roll /*&& enemiesAround == true && room2Enemies == true && state == 2*/) {
    enemyList2.add(new Enemy(int(random(400, 801)), int(random(400, 801)), 5));
    //print ("working");
  }

  while (enemyList3.size() < needEnemyRoom3Roll /*&& enemiesAround == true && room2Enemies == true && state == 2*/) {
    enemyList3.add(new Enemy(int(random(400, 801)), int(random(400, 801)), 5));      //print ("working");
  }

  while (enemyList4.size() < needEnemyRoom4Roll /*&& enemiesAround == true && room2Enemies == true && state == 2*/) {
    enemyList4.add(new Enemy(int(random(400, 801)), int(random(400, 801)), 5));
    //print ("working");
  }

  while (enemyList5.size() < needEnemyRoom5Roll /*&& enemiesAround == true && room2Enemies == true && state == 2*/) {
    enemyList5.add(new Enemy(int(random(400, 801)), int(random(400, 801)), 5));
    //print ("working");
  }

  while (enemyList6.size() < needEnemyRoom6Roll /*&& enemiesAround == true && room2Enemies == true && state == 2*/) {
    enemyList6.add(new Enemy(int(random(400, 801)), int(random(400, 801)), 5));
    //print ("working");
  }

  while (enemyList7.size() < needEnemyRoom7Roll /*&& enemiesAround == true && room2Enemies == true && state == 2*/) {
    enemyList7.add(new Enemy(int(random(400, 801)), int(random(400, 801)), 5));
    //print ("working");
  }

  while (enemyList8.size() < needEnemyRoom8Roll /*&& enemiesAround == true && room2Enemies == true && state == 2*/) {
    enemyList8.add(new Enemy(int(random(400, 801)), int(random(400, 801)), 5));
    //print ("working");
  }
}




void spawnChest() {

  if (chest1RoomNumber == state) {
    chest1.render();
    chest1.collision(you);
  } else {
    chestList.remove(chest1);
  }

  if (chest2RoomNumber == state) {
    chest2.render();
    chest2.collision(you);
  } else {
    chestList.remove(chest2);
  }

  if (chest3RoomNumber == state) {
    chest3.render();
    chest3.collision(you);
  } else {
    chestList.remove(chest3);
  }
}

//boss fieball attack
void fireballAttack(Boss aBoss) {
  if (aBoss.iCastFireball == true) {
    //println("fireball attack works");
    fireballList.add(new Fireball(aBoss.x, aBoss.y));
    fireballList.add(new Fireball(aBoss.x, aBoss.y));
    fireballList.add(new Fireball(aBoss.x, aBoss.y));
    fireballList.add(new Fireball(aBoss.x, aBoss.y));
    fireballList.add(new Fireball(aBoss.x, aBoss.y));
    aBoss.iCastFireball = false;
    //println(aBoss.iCastFireball);
  }
}

void allChestsFound() {

  if (chest1.isOpened == true) {
    image(keys, width - 50, height - 50, 75, 75);
  }
  if (chest2.isOpened == true) {
    image(keys, width - 100, height - 50, 75, 75);
  }
  if (chest3.isOpened == true) {
    image(keys, width - 150, height - 50, 75, 75);
  }
}


void buttonsClicked() {

  //if (respawnButton.isPressed() == true) {
  //  state = 1;
  //}
}


void sword() {

  if (you.attackUp == true && you.attacking == true) {
    image(swordUp, you.x, you.y -you.s*3, width/ 3, height /3);
  } else if (you.attackDown == true && you.attacking == true) {
    image(swordDown, you.x, you.y +you.s*3, width/ 3, height /3);
  } else if (you.attackLeft == true && you.attacking == true) {
    image(swordL, you.x-you.s*3, you.y +you.s, width/ 3, height /3);
  } else if (you.attackRight == true && you.attacking == true) {
    image(swordR, you.x+you.s*3, you.y +you.s, width/ 3, height /3);
  }
}




///////////////////////////////////////////////////////////////////////////////////
//keys that control movements and attacking
void keyPressed() {

  if (key == 'w') {
    you.isUp = true;

    you.attackUp = true;
    you.attackDown = false;
    you.attackLeft = false;
    you.attackRight = false;
  }

  if (key == 's') {
    you.isDown = true;

    you.attackUp = false;
    you.attackDown = true;
    you.attackLeft = false;
    you.attackRight = false;
  }

  if (key == 'a') {
    you.isLeft = true;

    you.attackUp = false;
    you.attackDown = false;
    you.attackLeft = true;
    you.attackRight = false;
  }

  if (key == 'd') {
    you.isRight = true;

    you.attackUp = false;
    you.attackDown = false;
    you.attackLeft = false;
    you.attackRight = true;
  }

  //test
  //if(key == 'p' && state == 0){
  // state = 1;
  //}
  //else if(key == 'p' && state == 1){
  // state = 0;
  //}


  if (key == ' ') {
    if (attackCooldown >= 1) {
      attackCooldown = 0;
      you.attacking = true;
    } else {
      you.attacking = false;
    }

    for (Enemy anAd : enemyList2) {
      anAd.playerAttackEnemy(you);
    }
    for (Enemy anAd : enemyList3) {
      anAd.playerAttackEnemy(you);
    }
    for (Enemy anAd : enemyList4) {
      anAd.playerAttackEnemy(you);
    }
    for (Enemy anAd : enemyList5) {
      anAd.playerAttackEnemy(you);
    }
    for (Enemy anAd : enemyList6) {
      anAd.playerAttackEnemy(you);
    }
    for (Enemy anAd : enemyList7) {
      anAd.playerAttackEnemy(you);
    }
    for (Enemy anAd : enemyList8) {
      anAd.playerAttackEnemy(you);
    }
  }

  //allows you to open chests
  if (key == 'e' && chest1RoomNumber == state) {
    chest1.openChest = true;
    //chest1Opened = true;
  }

  if (key == 'e' && chest2RoomNumber == state) {
    chest2.openChest = true;
    //chest1Opened = true;
  }

  if (key == 'e' && chest3RoomNumber == state) {
    chest3.openChest = true;
    //chest1Opened = true;
  }
}

///////////////////////////////////////////////////////////////////////////////////
// makes you stop walking
void keyReleased() {

  if (key == 'w') {
    you.isUp = false;
  }
  if (key == 's') {
    you.isDown = false;
  }

  if (key == 'a') {
    you.isLeft = false;
  }
  if (key == 'd') {
    you.isRight = false;
  }

  if (key == ' ') {
    you.attacking = false;
    attackCooldown = 1;
  }

  if (key == 'e') {
    chest1.openChest = false;
  }
}

void mousePressed() {


  buttonsClicked();
  if (respawnButton.isPressed() == true) {
    state = 1;
    you.ded = false;
    you.health = 200;
    buttonList.remove(respawnButton);
    println(buttonList.size());
  }
}
