class Button extends Widget {
  
  String label;
  int offset;
  color widgetColor, labelColor, strokeColor;
  PImage arrowImage, searchImage;
  PFont widgetFont;
  boolean hasBorder, setBorder, arrow, search;

  Button(int x, int y, int widgetWidth, String label, int event)
  {
    super(x, y, widgetWidth, 40, event);
    this.label=label;
    arrow = false;
    offset = 0;
    widgetFont = myFont;
    labelColor= WHITE;
    strokeColor = labelColor;
    widgetColor = WIDGET_COLOUR;
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
  void draw()
  {
    if (hasBorder) 
    {
      strokeWeight(2);
      strokeColor = color(AIRPORT_COLOUR);
    }
    else 
    {
      strokeWeight(1);
      strokeColor = color(labelColor);
    }
    stroke(strokeColor);
    textSize(20);
    fill(widgetColor);
    rect(x, y, widgetWidth, widgetHeight, 10);
    fill(labelColor);
    textAlign(CENTER);
    text(label, x + widgetWidth/2 + offset, y + widgetHeight/2 + textAscent()/2);
    if (arrow)
    {
      imageMode(CENTER);
      image(arrowImage, x + widgetWidth/3.5, y + widgetHeight/2); 
    }
    if (search)
    {
      imageMode(CENTER);
      image(searchImage, x + widgetWidth * 0.8, y + widgetHeight/2);
    }
    imageMode(CORNER);
  }
  
  @Override
  public void hover() {
    if(!setBorder) hasBorder = false;
    if (mouseX > x && mouseX < x + widgetWidth && mouseY > y && mouseY < y + widgetHeight) {
      hasBorder = true;
    }
  }

  @Override
  public void setColour()
  {
    widgetColor = AIRPORT_COLOUR;
    strokeColor = WIDGET_COLOUR;
  }

  @Override
  public void unsetColour()
  {
    widgetColor = WIDGET_COLOUR;
    strokeColor = labelColor;
  }
  
  @Override
  public void changeColour()
  {
    if(widgetColor == WIDGET_COLOUR)
    {
      widgetColor = AIRPORT_COLOUR;
      strokeColor = WIDGET_COLOUR;
    }
    else
    {
      widgetColor = WIDGET_COLOUR;
      strokeColor = labelColor;
    }
  }
}
