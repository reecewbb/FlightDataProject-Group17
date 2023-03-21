class Airport
{
  int x;
  int y;
  String name;
  int topSideBottom;
  
  Airport(int x, int y, String name, int topSideBottom)
  {
    this.x = x;
    this.y = y;
    this.name = name;
    this.topSideBottom = topSideBottom;
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
  
  void draw()
  {
    fill(#FA0505);
    stroke(0);
    ellipse(this.x, this.y, AIRPORT_RADIUS, AIRPORT_RADIUS);
    fill(0);
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
