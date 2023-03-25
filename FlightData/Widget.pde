class Widget {
  int x, y, widgetWidth, widgetHeight;
  String label;
  int event;
  color widgetColor, labelColor;
  PFont widgetFont;
  boolean hasBorder;
  boolean visibleButton;

  Widget(int x, int y, int widgetWidth, int widgetHeight, String label,
    color widgetColor, PFont widgetFont, int event) {
    this.x=x;
    this.y=y;
    this.widgetWidth = widgetWidth;
    this.widgetHeight= widgetHeight;
    this.label=label;
    this.event=event;
    this.widgetColor=widgetColor;
    this.widgetFont=widgetFont;
    labelColor= color(0);
    visibleButton = true;
  }
  
  Widget(int x, int y, int widgetWidth, int widgetHeight, int event)
  {
    this.x=x;
    this.y=y;
    this.widgetWidth = widgetWidth;
    this.widgetHeight = widgetHeight;
    this.event = event;
    visibleButton = false;
  }

  void draw() {
    if(visibleButton)
    {
      if (hasBorder) stroke(255);
      else stroke(0);
      fill(widgetColor);
      rect(x, y, widgetWidth, widgetHeight);
      fill(labelColor);
      text(label, x + widgetWidth/2 - textWidth(label)/2, y + widgetHeight/2 + textAscent()/2);
    }
  }

  void hover(int mX, int mY) {
    hasBorder = false;
    if (mX > x && mX < x+widgetWidth && mY > y && mY < y+widgetHeight) {
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
