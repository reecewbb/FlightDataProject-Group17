class Button extends Widget{
  
  Button(int x, int y, int widgetWidth, String label, int event)
  {
    super(x, y, widgetWidth, 40, event);
    this.label=label;
    arrow = false;
    offset = 0;
    widgetFont = myFont;
    labelColor= WHITE;
    widgetColor = WIDGET_COLOUR;
    visibleButton = true;
    if (label.equals("Back"))
    {
      arrow = true;
      arrowImage = loadImage("back_arrow.png");
      arrowImage.resize(widgetHeight - 15, 0);
      offset = 10;
    }
    if (label.equals("Search"))
    {
      search = true;
      searchImage = loadImage("search.png");
      searchImage.resize(widgetHeight - 15, 0);
      offset = -10;
    }
  }
  
  Button(int x, int y, int widgetWidth, String label, color widgetColor, int event, color labelColor)
  {
    this(x, y, widgetWidth, label, event);
    this.widgetColor = widgetColor;
    this.labelColor = labelColor;
  }
  
  @Override
  public void setColour()
  {
    widgetColor = AIRPORT_COLOUR;
  }
  
  @Override
  public void unsetColour()
  {
    widgetColor = WIDGET_COLOUR;
  }
}
