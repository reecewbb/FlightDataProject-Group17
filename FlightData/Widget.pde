class Widget {
  int x, y, widgetWidth, widgetHeight;
  int event;

  Widget(int x, int y, int widgetWidth, int widgetHeight, int event)
  {
    this.x=x;
    this.y=y;
    this.widgetWidth = widgetWidth;
    this.widgetHeight = widgetHeight;
    this.event = event;
  }
  
  public void setColour(){}
  public void unsetColour(){}
  public void draw(){}
  public void hover(){}
  public void changeColour(){};

  public int getEvent(int mX, int mY) {
    if (mX > x && mX < x+widgetWidth && mY > y && mY < y+widgetHeight) {
      return event;
    }
    return NO_EVENT;
  }
}
