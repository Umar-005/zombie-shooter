class ImageLoader{
  // all images 
  PImage background,logo,bullet,blood1,blood2,blood3,blood4,explosion1, explosion2, explosion3, explosion4,doctor1, doctor2, doctor3,dog1, dog2, dog3,instaKill, maxAmmo, doublePoints,nuke;
  PImage base, barrel,skeleton1, skeleton2, skeleton3, skeleton4,walker1, walker2, walker3, walker4,zombie1, zombie2, zombie3, zombie4;
  
  ImageLoader(){
    background = loadImage("images/background.png");
    logo = loadImage("images/logo.png");
    
    bullet = loadImage("images/bullet.png");
    
    doctor1 = loadImage("images/doctor1.png");
    doctor2 = loadImage("images/doctor2.png");
    doctor3 = loadImage("images/doctor3.png");
    
    dog1 = loadImage("images/dog1.png");
    dog2 = loadImage("images/dog2.png");
    dog3 = loadImage("images/dog3.png");
    
    instaKill = loadImage("images/instaKill.png");
    maxAmmo = loadImage("images/maxAmmo.png");
    doublePoints = loadImage("images/doublePoints.png");
    nuke = loadImage("images/nuke.png");
    
    blood1 = loadImage("images/blood1.png");
    blood2 = loadImage("images/blood2.png");
    blood3 = loadImage("images/blood3.png");
    blood4 = loadImage("images/blood4.png");
    
    explosion1 = loadImage("images/explosion1.png");
    explosion2 = loadImage("images/explosion2.png");
    explosion3 = loadImage("images/explosion3.png");
    explosion4 = loadImage("images/explosion4.png");
    
    base   = loadImage("images/base.png");
    barrel = loadImage("images/barrel.png");
    
    skeleton1 = loadImage("images/skeleton1.png");
    skeleton2 = loadImage("images/skeleton2.png");
    skeleton3 = loadImage("images/skeleton3.png");
    skeleton4 = loadImage("images/skeleton4.png");
    
    walker1 = loadImage("images/walker1.png");
    walker2 = loadImage("images/walker2.png");
    walker3 = loadImage("images/walker3.png");
    walker4 = loadImage("images/walker4.png");
    
    zombie1 = loadImage("images/zombie1.png");
    zombie2 = loadImage("images/zombie2.png");
    zombie3 = loadImage("images/zombie3.png");
    zombie4 = loadImage("images/zombie4.png");

  }
}
