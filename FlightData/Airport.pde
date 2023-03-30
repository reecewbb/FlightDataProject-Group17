class Airport
{
  int x, y, topSideBottom, airportID, numberOfOutgoingFlights, borderSize, region;
  float xpos, ypos;
  String name, cityName;
  color airportStrokeColor, airportColor, airportTextColor;

  Airport(int x, int y, String name, int topSideBottom)
  {
    this.x = x;
    this.y = y;
    this.name = name;
    this.topSideBottom = topSideBottom;
    borderSize = 4;
    airportColor = color(AIRPORT_COLOUR);
    airportTextColor = color(0);
    region = US_REGION;
  }

  Airport(int x, int y, String name, int topSideBottom, int region)
  {
    this(x, y, name, topSideBottom);
    this.region = region;
  }

  public int getRegion()
  {
    return region;
  }

  public void setID(int airportID)
  {
    this.airportID = airportID;
  }

  public void setCityName(String cityName)
  {
    this.cityName = cityName;
  }

  public String getCityName()
  {
    return cityName;
  }

  public int getAmountOfOutgoingFlights(ArrayList<Flight> flightList)
  {
    int amount = 0;
    for (Flight currentFlight : flightList)
    {
      String currentAirportName = currentFlight.getOrigin();
      if (currentAirportName.equals(name))
      {
        amount++;
      }
    }
    return amount;
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

  void strokeAirport()
  {
    if ( mouseX < xpos + AIRPORT_RADIUS && mouseX > xpos - AIRPORT_RADIUS && mouseY < ypos + AIRPORT_RADIUS && mouseY > ypos - AIRPORT_RADIUS)
    {
      borderSize = 2;
    } else
    {
      borderSize = 1;
    }
  }

  int airportClicked(int mX, int mY)
  {
    if ( mX < xpos + AIRPORT_RADIUS && mX > xpos - AIRPORT_RADIUS && mY < ypos + AIRPORT_RADIUS && mY > ypos - AIRPORT_RADIUS) return airportID + CHART_SELECTION_EVENT;
    else return -1;
  }

  void draw(int screen)
  {
    fill(airportColor);
    stroke(WHITE);
    strokeWeight(borderSize);
    int screenPart = screen;
    xpos = x;
    ypos = y;
    switch(screenPart)
    {
    case MAP_SCREEN:
      xpos = x;
      ypos = y;
      break;

    case TOP_LEFT_SCREEN:
      changeCoordinates(0, 0);
      break;

    case TOP_MID_SCREEN:
      changeCoordinates(1, 0);
      break;

    case TOP_RIGHT_SCREEN:
      changeCoordinates(2, 0);
      break;

    case MID_LEFT_SCREEN:
      changeCoordinates(0, 1);
      break;

    case MID_MID_SCREEN:
      changeCoordinates(1, 1);
      break;

    case MID_RIGHT_SCREEN:
      changeCoordinates(2, 1);
      break;

    case BOT_LEFT_SCREEN:
      changeCoordinates(0, 2);
      break;

    case BOT_MID_SCREEN:
      changeCoordinates(1, 2);
      break;

    case BOT_RIGHT_SCREEN:
      changeCoordinates(2, 2);
      break;
    }
    ellipse(xpos, ypos, AIRPORT_RADIUS, AIRPORT_RADIUS);
    fill(airportTextColor);
    switch(topSideBottom)
    {
    case ON_TOP:
      text(name, xpos, ypos - AIRPORT_RADIUS - 5);
      break;

    case ON_SIDE:
      text(name, xpos + AIRPORT_RADIUS + 15, ypos + 5);
      break;

    case ON_BOTTOM:
      text(name, xpos, ypos + AIRPORT_RADIUS + 12);
      break;

    case ON_SIDE_FAR_TOPRIGHT:
      text(name, xpos+68, ypos - AIRPORT_RADIUS - 12 );
      stroke(0);
      line(xpos, ypos, xpos+40, ypos-AIRPORT_RADIUS - 22);
      break;

    case ON_SIDE_FAR_BOTTOMLEFT:
      text(name, xpos - AIRPORT_RADIUS - 45, ypos + 23);
      stroke(0);
      line(xpos, ypos, xpos - AIRPORT_RADIUS - 25, ypos + 15);
      break;

    case ON_SIDE_FAR_MIDDLERIGHT:
      text(name, xpos + AIRPORT_RADIUS + 60, ypos+10 );
      stroke(0);
      line(xpos, ypos, xpos + AIRPORT_RADIUS + 35, ypos);
      break;

    case ON_TOP_FAR:
      text(name, xpos, ypos-50 );
      stroke(0);
      line(xpos, ypos, xpos, ypos-45);
      break;
    }
  }

  void changeCoordinates(int widthNo, int heightNo)
  {
    xpos = (x - (widthNo * (SCREENX / 3))) * 3;
    ypos = (y - (heightNo * (SCREENY / 3))) * 3;
  }
}
