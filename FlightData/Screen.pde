class Screen {
  ArrayList widgetList = new ArrayList();
  ArrayList airportList = new ArrayList();
  int screenType, previousEvent, outgoingFlights;

  Screen (int screenType)
  {
    this.screenType = screenType;
  }
  
  void setOutgoingFlights(int outgoingFlights)
  {
    this.outgoingFlights = outgoingFlights;
  }

  void addAirport(Airport airport)
  {
    airportList.add(airport);
  }

  void addWidget(Widget widget)
  {
    widgetList.add(widget);
  }

  int buttonClicked()
  {
    int event;
    if (screenType == MAP_SCREEN)
    {
      for (int i = 0; i < widgetList.size(); i++)
      {
        Widget myWidget = (Widget) widgetList.get(i);
        event = myWidget.getEvent(mouseX, mouseY);
        if (event != -1)
        {
          return event;
        }
      }
      float mX = mouseX - SCREENX/3;
      float mY = mouseY - SCREENY/3;
      event = TOP_LEFT_EVENT;
      while (mX > 0)
      {
        mX -= SCREENX/3;
        event++;
      }
      while (mY > 0)
      {
        mY -= SCREENY/3;
        event += 3;
      }
      return event;
    }
    /*
      for (int i = 0; i < widgetList.size(); i++)
     {
     Widget myWidget = (Widget) widgetList.get(i);
     event = myWidget.getEvent(mouseX, mouseY);
     if (event != -1)
     {
     return event;
     }
     }
     */
    if (screenType >= TOP_LEFT_SCREEN && screenType <= BOT_RIGHT_SCREEN)
    {
      for (int i = 0; i < airportList.size(); i++)
      {
        Airport myAirport = (Airport) airportList.get(i);
        event = myAirport.airportClicked(mouseX, mouseY);
        if (event != -1)
        {
          return event;
        }
      }
      for (int i = 0; i < widgetList.size(); i++)
      {
        Widget myWidget = (Widget) widgetList.get(i);
        event = myWidget.getEvent(mouseX, mouseY);
        if (event != -1)
        {
          return event;
        }
      }
    } 
    else
    {
      for (int i = 0; i < widgetList.size(); i++)
      {
        Widget myWidget = (Widget) widgetList.get(i);
        event = myWidget.getEvent(mouseX, mouseY);
        if (event != -1)
        {
          return event;
        }
      }
    }
    return NO_EVENT;
  }

  void draw(int event, ArrayList<Airport> myAirports, ArrayList<Flight> myFlights, Filter mapFilter)
  {
    myFont=loadFont("Arial-Black-48.vlw");
    textFont(myFont);
    textSize(10);
    mapImage = loadImage("Blank_US_Map.png");
    startUS = loadImage("Start_US_Map.png");
    startAlaska = loadImage("Start_Alaska_Map.png");
    startHawaii = loadImage("Start_Hawaii_Map.png");
    switch(screenType) 
    {
    case MAP_SCREEN:
      mapImage.resize(SCREENX, SCREENY);
      image(mapImage, 0, 0);
      String selectArea = "SELECT AREA";
      textSize(20);
      text(selectArea, SCREENX/2 - textWidth(selectArea)/2, TOP_TEXT_BUFFER);
      textSize(10);
      stroke(120);
      rect(0, SCREENY/3, SCREENX, 0.5);
      rect(0, 2 * SCREENY/3, SCREENX, 0.5);
      rect(0, SCREENY/3, SCREENX, 0.5);
      rect(SCREENX/3,0, 0.5, SCREENY);
      rect(2 * SCREENX/3,0, 0.5, SCREENY);
      for (int i = 0; i < airportList.size(); i++)
      {
        Airport myAirport = (Airport) airportList.get(i);
        myAirport.draw(MAP_SCREEN);
      }
      for (int i = 0; i < widgetList.size(); i++)
      {
        Widget myWidget = (Widget) widgetList.get(i);
        myWidget.draw();
      }
      if (mapFilter.currentFilter != 0 && mapFilter.currentFilter != mapFilter.previousFilter)
      {
        mapFilter.showAirports(airportList);
      }
      break;

    case TOP_LEFT_SCREEN:
      setScreen(0, 0, TOP_LEFT_SCREEN, "NORTH WEST US");
      break;

    case TOP_MID_SCREEN:
      setScreen(1, 0, TOP_MID_SCREEN, "NORTH CENTRAL US");
      break;

    case TOP_RIGHT_SCREEN:
      setScreen(2, 0, TOP_RIGHT_SCREEN, "NORTH EAST US");
      break;

    case MID_LEFT_SCREEN:
      setScreen(0, 1, MID_LEFT_SCREEN, "WEST US");
      break;

    case MID_MID_SCREEN:
      setScreen(1, 1, MID_MID_SCREEN, "CENTRAL US");
      break;

    case MID_RIGHT_SCREEN:
      setScreen(2, 1, MID_RIGHT_SCREEN, "EAST US");
      break;

    case BOT_LEFT_SCREEN:
      setScreen(0, 2, BOT_LEFT_SCREEN, "SOUTH WEST US");
      break;

    case BOT_MID_SCREEN:
      setScreen(1, 2, BOT_MID_SCREEN, "SOUTH CENTRAL US");
      break;

    case BOT_RIGHT_SCREEN:
      setScreen(2, 2, BOT_RIGHT_SCREEN, "SOUTH EAST US");
      break;

    case BAR_CHART_SCREEN:
      for (int i = 0; i < widgetList.size(); i++)
      {
        Widget aWidget = (Widget) widgetList.get(i);
        aWidget.draw();
      }
      if (event == NO_EVENT)
      {
        event = previousEvent;
      }
      BarChart outgoingFlightsChart = new BarChart(event - NUMBER_OF_EVENTS, myAirports, myFlights);
      previousEvent = event;
      outgoingFlightsChart.draw();
      break;
      
    case START_SCREEN:
      String start = "AIRPORT DATA VIEWER";
      String regionSelect = "SELECT REGION";
      fill(0);
      textSize(50);
      text(start, SCREENX/2 - textWidth(start)/2, 100);
      textSize(20);
      text(regionSelect, SCREENX/2 - textWidth(regionSelect)/2, 200);
      startUS.resize(START_MAP_WIDTH, 0);
      startAlaska.resize(START_MAP_WIDTH, 0);
      startHawaii.resize(START_MAP_WIDTH, 0);
      image(startUS, 150, 250);
      image(startAlaska, 800, 250);
      image(startHawaii, 500, 520);
      break;
      
    case CHART_SELECT_SCREEN: //<>//
      for (int i = 0; i < widgetList.size(); i++)
      {
        Widget aWidget = (Widget) widgetList.get(i);
        aWidget.draw();
      }
      String outgoingFlightsString = "TOTAL NUMBER OF OUTGOING FLIGHTS: " + Integer.toString(outgoingFlights);
      textSize(20);
      text(outgoingFlightsString, 100, 120);
      break;
    }
  }

  void setScreen(int widthNo, int heightNo, int ID, String areaName)
  {
    mapImage.resize(SCREENX * 3, SCREENY * 3);
    image(mapImage, -widthNo * SCREENX, -heightNo * SCREENY);
    textSize(20);
    text(areaName, SCREENX/2 - 100, 50);
    textSize(15);
    for (int i = 0; i < myAirports.size(); i++)
    {
      Airport myAirport = (Airport) myAirports.get(i);
      myAirport.draw(ID);
    }
    textSize(10);
    for (int i = 0; i < widgetList.size(); i++)
    {
      Widget myWidget = (Widget) widgetList.get(i);
      myWidget.draw();
    }
    if (mapFilter.currentFilter != 0 && mapFilter.currentFilter != mapFilter.previousFilter)
    {
      mapFilter.showAirports(myAirports);
    }
  }
}
