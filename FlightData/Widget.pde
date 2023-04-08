class Widget {
  int x, y, widgetWidth, widgetHeight;
  String label;
  int event, offset;
  color widgetColor, labelColor;
  PImage arrowImage, searchImage;
  PFont widgetFont;
  boolean hasBorder, setBorder, arrow, visibleButton, search;

  Widget(int x, int y, int widgetWidth, int widgetHeight, int event)
  {
    this.x=x;
    this.y=y;
    this.widgetWidth = widgetWidth;
    this.widgetHeight = widgetHeight;
    this.event = event;
    visibleButton = false;
    hasBorder = false;
  }
  
  public void setColour(){}
  public void unsetColour(){}
  
  void draw() {
    if(visibleButton)
    {
      if (hasBorder) strokeWeight(2);
      else strokeWeight(1);
      stroke(labelColor);
      textSize(20);
      fill(widgetColor);
      rect(x, y, widgetWidth, widgetHeight, 10);
      fill(labelColor);
      textAlign(CENTER);
      text(label, x + widgetWidth/2 + offset, y + widgetHeight/2 + textAscent()/2);
    }
    if(arrow)
    {
      imageMode(CENTER);
      image(arrowImage, x + widgetWidth/3.5, y + widgetHeight/2);
      imageMode(CORNER);
    }
    if(search)
    {
      imageMode(CENTER);
      image(searchImage, x + widgetWidth * 0.8, y + widgetHeight/2);
      imageMode(CORNER);
    }
  }

  public void hover() {
    if(!setBorder) hasBorder = false;
    if (mouseX > x && mouseX < x + widgetWidth && mouseY > y && mouseY < y + widgetHeight) {
      hasBorder = true;
    }
  }

  public int getEvent(int mX, int mY) {
    if (mX > x && mX < x+widgetWidth && mY > y && mY < y+widgetHeight) {
      return event;
    }
    return NO_EVENT;
  }
}
