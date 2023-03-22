class Airport
{
  int x;
  int y;
  String name;
  int topSideBottom;
  color airportStrokeColor;
  color airportColor; 
  color airportTextColor;
  boolean isClicked;
  
  Airport(int x, int y, String name, int topSideBottom)
  {
    this.x = x;
    this.y = y;
    this.name = name;
    this.topSideBottom = topSideBottom;
    airportStrokeColor = color(0);
    airportColor = color(#FC0808);
    airportTextColor = color(0);
    isClicked = false;
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
  
  void isClicked(int mX, int mY)
  {
    if( mX < this.x + AIRPORT_RADIUS && mX > this.x - AIRPORT_RADIUS && mY < this.y + AIRPORT_RADIUS && mY > this.y - AIRPORT_RADIUS)
    {
      this.isClicked = true;
      System.out.print("Hello");
    }
  }
  
  void draw()
  {
    fill(airportColor);
    stroke(airportStrokeColor);
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
