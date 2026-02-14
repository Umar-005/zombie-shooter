class Shop{
  boolean displayShop = false;
  int itemSpace;
  Button fillAmmo, increaseMaxAmmo, increaseHealth, increaseBulletSpeed, incraeseBulletDamage,increaseHealthRegenRate;
  boolean hoverFillAmmo, hoverIncreaseMaxAmmo, hoverIncreaseHealth, hoverIncreaseBulletSpeed, hoverIncraeseBulletDamage, hoverIncreaseHealthRegenRate;
  Shop(){
       fillAmmo = new Button(width- 225,100,220,40,"Fill Ammo");
       increaseMaxAmmo  = new Button(width- 225,200,220,40,"Increase Max Ammo");
       increaseHealth = new Button(width- 225,300,220,40,"Increase health");
       increaseBulletSpeed = new Button(width- 225,400,220,40,"Increase Bullet Speed");
       incraeseBulletDamage = new Button(width- 225,500,220,40,"Increase Bullet Damage");
       increaseHealthRegenRate = new Button(width- 225,600,220,40,"Increase Regen Rate ");
  }
  
  void drawShop(){
    drawButton();
    if(displayShop){
      drawItems();
      hoverFillAmmo = fillAmmo.isMouseOver();
      hoverIncreaseMaxAmmo = increaseMaxAmmo.isMouseOver();
      hoverIncreaseHealth = increaseHealth.isMouseOver();
      hoverIncreaseBulletSpeed = increaseBulletSpeed.isMouseOver();
      hoverIncraeseBulletDamage = incraeseBulletDamage.isMouseOver();
      hoverIncreaseHealthRegenRate = increaseHealthRegenRate.isMouseOver();
      
      cursor((hoverFillAmmo || hoverIncreaseMaxAmmo || hoverIncreaseHealth || hoverIncreaseBulletSpeed || hoverIncraeseBulletDamage || hoverIncreaseHealthRegenRate) ? HAND : ARROW);
      fillAmmo.draw(hoverFillAmmo);
      increaseMaxAmmo.draw(hoverIncreaseMaxAmmo);
      increaseHealth.draw(hoverIncreaseHealth);
      increaseBulletSpeed.draw(hoverIncreaseBulletSpeed);
      incraeseBulletDamage.draw(hoverIncraeseBulletDamage);
      increaseHealthRegenRate.draw(hoverIncreaseHealthRegenRate);
    }
  }
  
  void drawButton(){
    itemSpace = 0;
    if(displayShop){
      itemSpace = 450;
    }
    noStroke();
    fill(33, 31, 28, 200);
    rectMode(CORNER);
    rect(width-150-itemSpace,0,150,40);
    fill(240, 238, 235);
    textSize(25);
    text("Shop",width-75-itemSpace,20);
  }
  
  void drawItems(){
    fill(33, 31, 28, 200);
    rectMode(CORNER);
    rect(width-450,0,450,height);
    fill(240, 238, 235);
    items();
  }
  
  
  void items(){
    textSize(25);
    text("Price: " + 250,width- 225, 50);
    text("Price: " + 750,width- 225,150);
    text("Price: " + 1000,width- 225, 250);
    text("Price: " + 500,width- 225,350);
    text("Price: " + 750,width- 225,450);
    text("Price: " + 1500,width- 225,550);
  }
  
  boolean overButton(){
    int x = width-150/2-itemSpace;
    int y =20;
    return mouseX > x - 150 / 2 &&
           mouseX < x + 150 / 2 &&
           mouseY > y - 40 / 2 &&
           mouseY < y + 40 / 2;
  
  }
  
  
}
