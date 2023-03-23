class Airport
{
  int x, y, topSideBottom, airportID;
  String name;
  color airportStrokeColor, airportColor, airportTextColor;

  Airport(int x, int y, String name, int topSideBottom)
  {
    this.x = x;
    this.y = y;
    this.name = name;
    this.topSideBottom = topSideBottom;
    airportStrokeColor = color(0);
    airportColor = color(#FC0808);
    airportTextColor = color(0);
  }
  
  public void setID(int airportID)
  {
    this.airportID = airportID;
  }
  
  public int getID()
  {
    return airportID;
  }
  
  public int getX()  
  {
    return x;
  }
  
  public int getY()
  {
    return y;
  }
  
  public String getAirportName()
  {
     return name; 
  }
  
  void strokeAirport(int mX, int mY)
  {
    if( mX < this.x + AIRPORT_RADIUS && mX > this.x - AIRPORT_RADIUS && mY < this.y + AIRPORT_RADIUS && mY > this.y - AIRPORT_RADIUS)
    {
      this.airportStrokeColor = (255);
    }
    else
    {
      this.airportStrokeColor = (0);
    }
  }
  
  int airportClicked(int mX, int mY)
  {
    if( mX < x + AIRPORT_RADIUS && mX > x - AIRPORT_RADIUS && mY < y + AIRPORT_RADIUS && mY > y - AIRPORT_RADIUS) return airportID;
    else return -1;
  }
  
  void draw(int screen)
  {
    fill(airportColor);
    stroke(airportStrokeColor);
    int screenPart = screen;
    switch(screenPart)
    {
      case MAP_SCREEN:
      int xpos = x;
    }
    ellipse(this.x, this.y, AIRPORT_RADIUS, AIRPORT_RADIUS);
    fill(airportTextColor);
    switch(topSideBottom)
    {
      case ON_TOP:
      text(this.name, this.x - AIRPORT_RADIUS - 10, this.y - AIRPORT_RADIUS - 5);
      break;
      
      case ON_SIDE:
      text(this.name, this.x + AIRPORT_RADIUS + 5, this.y + 5);
      break;
      
      case ON_BOTTOM:
      text(this.name, this.x - AIRPORT_RADIUS, this.y + AIRPORT_RADIUS + 12);
      break;
    }
  }  
}
