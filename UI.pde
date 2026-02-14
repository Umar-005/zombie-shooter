class Button {
  float x,y, buttonWidth, buttonHeight;
  String text;
  
  Button(float x, float y, float buttonWidth, float buttonHeight, String text){
    this.x = x;
    this.y = y;
    this.text = text;
    this.buttonWidth = buttonWidth;
    this.buttonHeight = buttonHeight;
  }
  
  void draw(boolean hovered){
    fill(76, 122, 55);
     if(hovered){
       fill(60, 100, 45);
    }
    rectMode(CENTER);
    stroke(0);
    strokeWeight(5);
    rect(x,y,buttonWidth,buttonHeight,20);
    fill(255);
    textAlign(CENTER,CENTER);
    textSize(buttonHeight/2);
    text(text,x,y);
    
  }
  
  boolean isMouseOver() {
    return mouseX > x - buttonWidth / 2 &&
           mouseX < x + buttonWidth / 2 &&
           mouseY > y - buttonHeight / 2 &&
           mouseY < y + buttonHeight / 2;
  }

}


class InputField {
  float x, y, w, h;
  String text = "";
  String placeholder;
  boolean active = false;
  final int MAX_LENGTH = 9; // character cap

  InputField(float x, float y, float w, float h, String placeholder) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.placeholder = placeholder;
  }

  void draw(String displayText) {
    stroke(active ? color(255, 200, 100) : 200);
    strokeWeight(3);
    fill(40, 60, 80, active ? 180 : 220);
    rectMode(CENTER);
    rect(x, y, w, h, 10);

    fill(255);
    textSize(24);
    textAlign(LEFT, CENTER);
    if (displayText.length() > 0) text(displayText, x - w/2 + 10, y);
    else { 
      fill(180); 
      text(placeholder, x - w/2 + 10, y); 
    }
    textAlign(CENTER, CENTER);
  }

  boolean isMouseOver() {
    return mouseX > x - w/2 && mouseX < x + w/2 &&
           mouseY > y - h/2 && mouseY < y + h/2;
  }
  
  void setActive(boolean val) {
    active = val; 
  }
 
  void handleKeyTyped(char key) {
    if (!active) return;

    if (key == BACKSPACE && text.length() > 0) {
      text = text.substring(0, text.length() - 1);
    } 
    else if (key != BACKSPACE && key != ENTER && text.length() < MAX_LENGTH) {
      text += key;
    }
  }
  
  void clear() { 
    text = ""; 
  }
}






class ShowButton {
  float x, y, w, h;
  boolean hovered = false;
  boolean showing = false;

  ShowButton( float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void draw(boolean showing) {
    rectMode(CENTER);
    stroke(isMouseOver() ? color(255, 200, 100) : 200);
    strokeWeight(2);
    fill(40, 60, 80, 200);
    rect(x, y, w, h, 8);
    fill(255);
    textSize(18);
    textAlign(CENTER, CENTER);
    text(showing ? "Hide" : "Show", x, y);
  }


  boolean isMouseOver() {
    hovered = mouseX > x - w / 2 && mouseX < x + w / 2 &&
               mouseY > y - h / 2 && mouseY < y + h / 2;
    return hovered;
  }


  void toggle(){
    showing = !showing;
  }
}
