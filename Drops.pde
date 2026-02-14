abstract class Drops{
  float x,y,time;
  PImage instaKill, maxAmmo, doublePoints,nuke;
  int random;
  int count;
  boolean flash = false;
  boolean collected = false;
  Drops(float x,float y, float time){
    this.x = x;
    this.y = y;
    this.time = time;
    instaKill = game.imageLoader.instaKill;
    maxAmmo = game.imageLoader.maxAmmo;
    doublePoints = game.imageLoader.doublePoints;
    nuke = game.imageLoader.nuke;

  }
  
  boolean collectableTimeFinshed(){
    if(millis()/1000- time> 6){
      return true;
    }
    return false;
  }
  
  
  boolean delete(){
    if(millis()/1000- time> 16){
      return true;
    }
    return false;
  }
  
  abstract void drawDrop();
  abstract void drawCollected();
  
  
}

class InstaKill extends Drops{
  InstaKill(float x, float y, float time){
    super(x,y,time);
  }
  void drawDrop() {

    if (millis()/1000 - time > 3) {
      flash = true;
    }

    if (!flash) {
      image(instaKill, x, y);
      return;
    }

    if ((millis() / 200) % 2 == 0) {
      image(instaKill, x, y);
    }
}

  
  void drawCollected(){
    image(instaKill, 30, height-100, 60, 60);
  }

}

class MaxAmmo extends Drops{
  
  MaxAmmo(float x, float y, float time){
    super(x,y,time);
  }
  
  void drawDrop(){
    if (millis()/1000 - time > 3) {
      flash = true;
    }

    if (!flash) {
      image(maxAmmo, x, y);
      return;
    }

    if ((millis() / 200) % 2 == 0) {
      image(maxAmmo, x, y);
    }
  }
  
  void drawCollected(){
  }
}


class DoublePoints extends Drops{
  
  DoublePoints(float x, float y, float time){
    super(x,y, time);
  }
  
  void drawDrop(){
    if (millis()/1000 - time > 3) {
      flash = true;
    }

    if (!flash) {
      image(doublePoints, x, y);
      return;
    }

    if ((millis() / 200) % 2 == 0) {
      image(doublePoints, x, y);
    }
  }
  
  void drawCollected(){
    image(doublePoints, 120, height-100, 60, 60);
  }
}


class Nuke extends Drops{
  
  Nuke(float x, float y, float time ){
    super(x,y, time);
  }
  
  void drawDrop(){
    
    if (millis()/1000 - time > 3) {
      flash = true;
    }

    if (!flash) {
      image(nuke, x, y);
      return;
    }

    if ((millis() / 200) % 2 == 0) {
      image(nuke, x, y);
    }
  }
  void drawCollected() {}
}
