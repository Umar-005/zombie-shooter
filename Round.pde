class Round{
  int round;
  float roundX = width/2;
  float roundY = height/2;
  float scaleDecrase = 2;
  float textSize = 150;
  float enemyAmount;
  float enemySpeed;
  float spawnRate;
  float timeBetweenSpawn;
  float damage;
  float health;
  PVector roundDir =  new PVector(50 - roundX, 50 - roundY).normalize();
  Round(int round){
    this.round = round;
  }
  
  void displayRound(){
    fill(110, 0, 10);    
    textSize(textSize);
    text(round,roundX,roundY);
    if(textSize>70){
      textSize -= scaleDecrase;
    }
    moveRound();
  }
  
  
  void moveRound(){
    if(roundX>50){
      roundX += roundDir.x * 20;
      roundY += roundDir.y * 20;
    }
  }
  
  float difficulty() {
    return 1 + round * 0.1 + pow(round, 1.5) * 0.01;
  }

  float[] roundInfo(){
    float d = difficulty();
    enemyAmount = 15 * d;
    enemySpeed = 5  * (1 + round * 0.04);
    spawnRate = 3  * d;
    timeBetweenSpawn = max(0.6, 4 / d);
    damage = 0.1 * d;
    health = 100 * d;
    return new float[] {enemyAmount, enemySpeed, spawnRate, timeBetweenSpawn, damage, health};
  }

}
