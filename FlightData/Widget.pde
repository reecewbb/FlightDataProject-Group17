class Widget {
  int x, y, widgetWidth, widgetHeight;
  String label;
  int event, offset;
  color widgetColor, labelColor;
  PImage arrowImage;
  PFont widgetFont;
  boolean hasBorder, setBorder, arrow;
  boolean visibleButton;

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
  
  Widget(int x, int y, int widgetWidth, int widgetHeight, String label, color widgetColor, PFont widgetFont, int event, color labelColor) 
  {
    this(x, y, widgetWidth, widgetHeight, event);
    this.label=label;
    arrow = false;
    offset = 0;
    this.widgetColor = widgetColor;
    this.widgetFont = widgetFont;
    this.labelColor= labelColor;
    visibleButton = true;
    if (label.equals("Back"))
    {
      arrow = true;
      arrowImage = loadImage("back_arrow.png");
      arrowImage.resize(widgetHeight - 15, 0);
      offset = 10;
    }
  }
  
  void setColour()
  {
    widgetColor = AIRPORT_COLOUR;
  }
  
  void unsetColour()
  {
    widgetColor = WIDGET_COLOUR;
  }

  void draw() {
    if(visibleButton)
    {
      if (hasBorder) strokeWeight(2);
      else strokeWeight(1);
      stroke(WHITE);
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
  }

  void hover() {
    if(!setBorder) hasBorder = false;
    if (mouseX > x && mouseX < x + widgetWidth && mouseY > y && mouseY < y + widgetHeight) {
      hasBorder = true;
    }
  }

  int getEvent(int mX, int mY) {
    if (mX > x && mX < x+widgetWidth && mY > y && mY < y+widgetHeight) {
      return event;
    }
    return NO_EVENT;
  }
}
