class ScreenGame extends Screen{
// game variables 
  
  Gun gun; // players gun
  Round round;  // controls rounds
  Shop shop; // display shop
  
  // buttons
  Button restart, menu, resume;
  boolean hoverRestart, hoverMenu, hoverResume;
  
  // game arrays
  ArrayList<Bullets> bullets;
  ArrayList<Enemy> enemies;
  ArrayList<Drops> drops;
  
  //game positions
  float [] bulletPosition;
  float [] enemeyPosition;
  
  // round info
  float [] roundInfo;
  boolean newRound = true;
  int enemySpawned = 0;
  int roundNumber = 1;
  int lastSpawn = 0;
  
  // game info
  int maxBullets = 50;
  int bulletsLeft = 50;
  int scorePerShot = 10;
  int originalScorePerShot = scorePerShot;
  float bulletSpeed = 20;
  float bulletDamage = 10;
  
  // increase 
  
  int increaseMaxBullets = 10;
  int increaseHealth = 20;
  int increaseBulletSpeed = 2;
  int increaseBulletDamage = 3;
  float increaseRegen = 0.03;
  
  // score
  int score = 500;
  int totalScore = score;
  int bodyShotMultiplier = 1;
  int headShotMultiplier = 3;
  int instaKillMultiplier = 6;  
  
  // time
  int time = 0;
  int nukeTime = 0;
  int pausedTime = 0;
  int totalPausedTime = 0;
  int timeBetweenRounds = 7;
  
  // game state
  boolean gameOver = false;
  boolean paused = false;
  
  // drop state
  boolean instaKill = false;
  boolean maxAmmo = false;
  boolean doublePoints = false;
  boolean nuke = false;



  ScreenGame(Game game){
    super(game);
    
    // game objects
    gun = new Gun(width/2, height/2-38);
    bullets = new ArrayList<>();
    enemies = new ArrayList<>();
    drops = new ArrayList<>();
    shop = new Shop();
    
    // make buttons
    restart = new Button(width/2,height/2+300,300,80,"Restart");
    menu = new Button(width/2,height/2+150,300,80,"Menu");
    resume = new Button(width/2,height/2,300,80,"Resume ");
  }
  
  void draw(){
    drawBackground();
    if(!gameOver && !paused){
      game();
    }
    else if(paused){
      paused();
    }
    else if(gameOver){
      gameOver();
    } 
   
  }
  
  
  void game(){
    
    // starts new round
    if(newRound){
      round = new Round(roundNumber);
      newRound = false;
      roundInfo = round.roundInfo();
    }
    
    
    // handles bullets
    for( int i =0; i < bullets.size(); i++){   
      bullets.get(i).drawBullet();
      if(bullets.get(i).outOfBounds()){  // removes bullet if it goes out of screen
        bullets.remove(i);
        i=i-1;
        continue;        
      }
      bulletPosition = bullets.get(i).bulletPosition();
      for(int j =0; j< enemies.size(); j++){
        if(enemies.get(j).alive){
          enemeyPosition = enemies.get(j).enemyPosition();
          int typeShot = collision(bulletPosition[0],bulletPosition[1],enemeyPosition[0],enemeyPosition[1],enemeyPosition[2],enemeyPosition[3],enemeyPosition[4]); // checks for collision
          if (instaKill && !(typeShot==0)){ // if insta kill is active and there is a collistion then enemies instantly die
            if(!(enemies.get(j) instanceof Doctor)){ // only add score if not doctor
              score += scorePerShot*instaKillMultiplier;
              totalScore +=scorePerShot*instaKillMultiplier;
            }
            enemies.get(j).enemyHealth = 0; 
            bullets.remove(i);
            enemies.get(j).alive = false;
            randomDrop(enemies.get(j).x, enemies.get(j).y);
            i=i-1;
            if(i==-1){
              break;
            }
            continue;            
          }
          else if(typeShot==1){ // body shot
            if(!(enemies.get(j) instanceof Doctor)){
              score += scorePerShot * bodyShotMultiplier;
              totalScore +=scorePerShot * bodyShotMultiplier;
            }
            enemies.get(j).enemyHealth -= bulletDamage;           
            bullets.remove(i);
            if (enemies.get(j).enemyHealth <= 0){
              enemies.get(j).alive = false;
              randomDrop(enemies.get(j).x, enemies.get(j).y);
            }
           i=i-1;
           if(i==-1){
            break;
           }
           continue;
         
          }
          else if(typeShot==2){  // headShot
            if(!(enemies.get(j) instanceof Doctor)){
              score += scorePerShot*headShotMultiplier;
              totalScore +=scorePerShot*headShotMultiplier;
            }
            enemies.get(j).enemyHealth -= bulletDamage*3;
            bullets.remove(i);
            if (enemies.get(j).enemyHealth <= 0){
              enemies.get(j).alive = false;
              randomDrop(enemies.get(j).x, enemies.get(j).y);
            }
            i=i-1;
            if(i==-1){
              break;
            }
            continue;
         
         }
       }
     }
         
    }
   
    // handles enemies
    for(int i =0; i< enemies.size(); i++){
      if(nuke){ // if player picks up nuke kill all enemies
          enemies.get(i).alive = false;
      }
      
      
      if(enemies.get(i).alive){
        enemies.get(i).drawEnemy();
      }
      else if(!enemies.get(i).alive && enemies.get(i).animationCount < enemies.get(i).animationLength){  // draw death animation if enemy has died and animation hasnt finished yet 
         enemies.get(i).deathAnimation(nuke); 
      }
      else if(enemies.get(i).animationCount >= enemies.get(i).animationLength){
        if((enemies.get(i) instanceof Doctor)){  // if doctor score gets halved 
          score = (int) score / 2;
        }
        enemies.remove(i);
        i=i-1;
        if(i==-1){
           break;
        }
      }
      float damage =  enemies.get(i).enemyDamage;
      if(enemies.get(i).inGun()  && enemies.get(i).alive){
        if((enemies.get(i) instanceof Doctor)){  // if doctor goes in gun then player gets score if it wasanother enemy then gun loses health
          score += 250;
          totalScore +=250;
          enemies.remove(i);
          i=i-1;
          if(i==-1){
            break;
          }
        }
        else{
          gun.health -= damage;
        }
      }
    }
    
    
    
    if(millis()-nukeTime>=1000){
      nuke = false;
    }
    
    // draws ui
    gun.drawGun();
    shop.drawShop();
    drawInfo();
       
    if((millis()/1000)-time - totalPausedTime/1000 >timeBetweenRounds){  // waits  between each round
      round.displayRound();
      if(enemySpawned<= (int)roundInfo[0]-1){ 
        if ((millis()/1000) - lastSpawn - totalPausedTime/1000> roundInfo[3]){  // spawns enemy after a set amount of time
          lastSpawn = millis()/1000;
          totalPausedTime =0;          
          spawnEnemy();
        }
      }
      else{
        if (enemies.size()==0){
          time = millis()/1000;
          totalPausedTime =0;
          newRound = true;
          enemySpawned =0;
          roundNumber +=1;
        }
      }
    }
    else{
        fill(255);
        textSize(30);
        text("Round " + roundNumber + " starts in " + String.valueOf((int)time+timeBetweenRounds+totalPausedTime/1000- millis()/1000),width/2,200);
    }
    
    if(gun.health<=0){
      gameOver = true;
    }
    
    
    // handles drops
    for (int i =0; i< drops.size(); i++){
      if(drops.get(i).collected){
        drops.get(i).drawCollected();
      }
      else{
        drops.get(i).drawDrop();
      }
      
      if(drops.get(i).collectableTimeFinshed()  && (!drops.get(i).collected || drops.get(i) instanceof Nuke || drops.get(i) instanceof MaxAmmo )){
          drops.remove(i);
          i=i-1;
            if(i==-1){
              break;
            }
      }
      else if(drops.get(i).delete()){
        drops.remove(i);
        i=i-1;
        if(i==-1){
          break;
        }
      }
    }
    
    
    
    if(instaKill){
      if(!containsType(drops, InstaKill.class)){
        instaKill = false;   
      }
    }
    
    if(!containsType(drops, DoublePoints.class)){
      scorePerShot = originalScorePerShot;
    }
    

    
    if(doublePoints){
      scorePerShot =originalScorePerShot*2;
      doublePoints = false;   
    }

    
    if(maxAmmo){
      bulletsLeft = maxBullets;
      maxAmmo = false;
    }
    
    cursor((shop.overButton() || overPauseButton()) ? HAND : ARROW);
  }
  
  
  void paused(){
    fill(255);
    textSize(80);
    text("Paused", width/2, height/2-300);
    text("Current Score = " + String.valueOf(totalScore),width/2,height/2-150);
    hoverRestart = restart.isMouseOver();
    hoverMenu = menu.isMouseOver();
    hoverResume = resume.isMouseOver();
    cursor((hoverRestart || hoverMenu || hoverResume) ? HAND : ARROW);
    resume.draw(hoverResume);
    restart.draw(hoverRestart);
    menu.draw(hoverMenu);
  }
  
  void gameOver(){
    fill(255);
    text("Game Over", width/2, height/2-200);
    text("Final score = " + String.valueOf(totalScore),width/2,height/2);
    hoverRestart = restart.isMouseOver();
    hoverMenu = menu.isMouseOver();
    cursor((hoverRestart || hoverMenu ) ? HAND : ARROW);
    restart.draw(hoverRestart);
    menu.draw(hoverMenu);
    
  
  }
  
  void handleMousePressed() {
    
     for(int i=0; i<drops.size();i++){
      float x = drops.get(i).x;
      float y = drops.get(i).y;
      if (dist(mouseX,mouseY,x,y)< 55 && !drops.get(i).collected){
        drops.get(i).collected = true;
        if(drops.get(i) instanceof InstaKill){
          instaKill = true;
        }
        else if(drops.get(i) instanceof MaxAmmo){
          maxAmmo = true;
        }          
        else if(drops.get(i) instanceof DoublePoints){
          doublePoints = true;
        }  
        else if(drops.get(i) instanceof Nuke){
          score += enemies.size()*scorePerShot*instaKillMultiplier;
          totalScore += enemies.size()*scorePerShot;
          nuke = true;
          nukeTime = millis();
        }
        return;
      }
      
    }
    
    if(shop.overButton()){
      shop.displayShop = !shop.displayShop;
    }
    else if(shop.displayShop){
       if(shop.hoverFillAmmo && score>= 250){
         score -=250;
         bulletsLeft = maxBullets;
       }
       else if(shop.hoverIncreaseMaxAmmo && score>= 750){
         score -=750;
         maxBullets += increaseMaxBullets ;   
       }
       else if(shop.hoverIncreaseHealth && score>= 1000){
         score -=1000;
         gun.totalHealth += increaseHealth; 
       }
       else if(shop.hoverIncreaseBulletSpeed && score>= 500){
         score -=500;
         bulletSpeed += increaseBulletSpeed;    
       }
       else if(shop.hoverIncraeseBulletDamage && score>= 750){
         score -=750;
         bulletDamage += increaseBulletDamage;  
       }
       else if(shop.hoverIncreaseHealthRegenRate && score>= 1500){
         score -=1500;
         gun.regenRate += increaseRegen;  
       }
       
    }
    else if(overPauseButton()){
      paused = true;
      pausedTime = millis();
    }
    else if(bulletsLeft>0){
      PVector hand = gun.getBarrelTip();   
      bulletsLeft-=1;
      bullets.add(new Bullets(hand.x, hand.y, bulletSpeed, mouseX, mouseY));
    }
    

    
     if(gameOver){
          if (restart.isMouseOver()) {
            game.database.saveHighScore(game.currentUser,totalScore);
            game.database.updateTop10(game.currentUser,totalScore);
            resetGame();
          }
          else if (menu.isMouseOver()) {
            game.database.saveHighScore(game.currentUser,totalScore);
            game.database.updateTop10(game.currentUser,totalScore);
            game.switchScreen(new ScreenMenu(game)); 
          }
       }
      else if(paused){
           if (restart.isMouseOver()) {
            game.database.saveHighScore(game.currentUser,totalScore);
            game.database.updateTop10(game.currentUser,totalScore);
            resetGame();
          }
          else if (menu.isMouseOver()) {
            game.database.saveHighScore(game.currentUser,totalScore);
            game.database.updateTop10(game.currentUser,totalScore);
            game.switchScreen(new ScreenMenu(game)); 
          }
          else if(resume.isMouseOver()){
            totalPausedTime = millis() - pausedTime;
            paused = false;
          }
      }
  }
  void handleKeyPressed(){
    if (key == 's') {
      shop.displayShop = !shop.displayShop;
    }
  }
  void handleKeyTyped(){}
  
  
  // checks for collision between bullet and enemy
  int collision(float bX, float bY, float eX, float eBY,  float eHY, float eBR, float eHR){
    int typeShot = 0; // return depends on the shot type
    if (dist(bX,bY,eX,eBY)< eBR){
      typeShot = 1; // bodyshot
    } else if (dist(bX,bY,eX,eHY)< eHR) {
      typeShot = 2;  // headshot
    }
    return typeShot;
  }
  
  
  
  
  void spawnEnemy(){
    int spawnCount = int(roundInfo[2]);
     for(int i =0; i<spawnCount; i++){
       if(enemySpawned>= (int) roundInfo[0]){
         break;
       }
       enemies.add(randomEnemy());
       enemySpawned +=1;
     }  
  
  }
  
  
  
  // gets random enemy
  Enemy randomEnemy(){
    int randomNum = (int) random(0,100);
    if (randomNum<30){
      return new Walker(roundInfo[1]*0.5,roundInfo[4]*1.5,roundInfo[5]*2);
    }
    else if (randomNum<40){
      return new Skeleton(roundInfo[1]*1.3,roundInfo[4]*0.7,roundInfo[5]*0.5);
    }
    else if (randomNum<55){
      return new Dog(roundInfo[1]*1.6,roundInfo[4],roundInfo[5]*0.25);
    }
    else if (randomNum<60){
      return new Doctor(roundInfo[1]*1.3,0,roundInfo[5]*0.5);
    }
    else {
      return new Zombie(roundInfo[1],roundInfo[4],roundInfo[5]);
    }
  }
  
  
  void drawInfo(){
    fill(240, 238, 235);
    textSize(35);
    text("Bullets: " + bulletsLeft + "/" + maxBullets, width/2, 40);
    text("Score: " + score , width/2 , height - 120);
    text("To Spawn: " + ((int) roundInfo[0] - enemySpawned), 200,40);
    if(!shop.displayShop){
      fill(255, 200, 60);
      rect(width-40,70,10,40,5);
      rect(width-57,70,10,40,5);
    }

  }
  
  boolean overPauseButton(){
    return mouseX > width-57 &&
           mouseX < width -30 &&
           mouseY > 70 &&
           mouseY < 110;    
  }
  
  
  
  void randomDrop(float x, float y){
    int random = (int) random(1000);
    if(random>120){return;}
    if(random<20){
      drops.add(new InstaKill(x,y,millis()/1000));
    }
    else if(random<70){
      drops.add(new MaxAmmo(x,y,millis()/1000));
    }
    else if(random<110){
      drops.add(new DoublePoints(x,y,millis()/1000));
    }
    else if(random<120){
      drops.add(new Nuke(x,y,millis()/1000));
    }
  }
  
  boolean containsType(ArrayList<?> list, Class<?> type){
    for(int i=0; i<list.size();i++){
      if(type.isInstance(list.get(i))){
        return true;
      }
    }
    return false;
  }
  
  void resetGame() {

    bullets = new ArrayList<Bullets>();
    enemies = new ArrayList<Enemy>();
    drops   = new ArrayList<Drops>();
    gun = new Gun(width/2, height/2-38);
    
    bulletPosition = new float[2];
    enemeyPosition = new float[2];
    shop = new Shop();
      
    newRound = true;
    enemySpawned = 0;
    roundNumber = 1;
    time = 0;
    pausedTime = 0;
    totalPausedTime = 0;
    nukeTime = 0;
    lastSpawn = 0;
  
    maxBullets = 50;
    bulletsLeft = maxBullets;
  
    scorePerShot = originalScorePerShot;
    bulletSpeed = 20;
    bulletDamage = 10;
  
    score = 500;
    totalScore = score;

    paused = false;
    gameOver = false;
    instaKill = false;
    maxAmmo = false;
    doublePoints = false;
    nuke = false;

}

  
  
}
