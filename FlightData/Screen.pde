class Screen {  //<>// //<>//
  ArrayList widgetList = new ArrayList();
  ArrayList airportList = new ArrayList();
  int screenType, previousEvent, outgoingFlights;

  Screen (int screenType)
  {
    this.screenType = screenType;
    myFont=loadFont("Arial-Black-48.vlw");
    textFont(myFont);
    textSize(10);
    mapImage = loadImage("Blank_US_Map.png");
    US = new PImage[3];
    Alaska = new PImage[3];
    Hawaii = new PImage[3];
    Departures = new PImage[3];
    setShadowArray(US, "Start_US_Map.png", "Shadow_US.png", START_MAP_WIDTH);
    setShadowArray(Alaska, "Start_Alaska_Map.png", "Shadow_Alaska.png", START_MAP_WIDTH);
    setShadowArray(Hawaii, "Start_Hawaii_Map.png", "Shadow_Hawaii.png", START_MAP_WIDTH);
    setShadowArray(Departures, "departures.png", "shadow_departures.png", CHART_BUTTON_SIZE);
  }

  void setShadowArray(PImage[] array, String startName, String shadowName, int size)
  {
    array[START] = loadImage(startName);
    array[SHADOW] = loadImage(shadowName);
    array[START].resize(size, 0);
    array[SHADOW].resize(size + 5, 0);
    array[CURRENT] = array[START];
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
      rect(SCREENX/3, 0, 0.5, SCREENY);
      rect(2 * SCREENX/3, 0, 0.5, SCREENY);
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
      String continentalUS = "CONTINENTAL US";
      String alaska = "ALASKA";
      String hawaii = "HAWAII";
      fill(0);
      textSize(50);
      text(start, SCREENX/2 - textWidth(start)/2, 100);
      textSize(30);
      text(regionSelect, SCREENX/2 - textWidth(regionSelect)/2, 170);
      textSize(20);
      text(continentalUS, US_X_START + START_MAP_WIDTH/2 - textWidth(continentalUS)/2, TOP_ROW_Y_START - 30);
      text(alaska, ALASKA_X_START + START_MAP_WIDTH/2 - textWidth(alaska)/2, TOP_ROW_Y_START - 30);
      text(hawaii, HAWAII_X_START + START_MAP_WIDTH/2 - textWidth(hawaii)/2, HAWAII_Y_START + 80);
      image(US[CURRENT], US_X_START, TOP_ROW_Y_START);
      image(Alaska[CURRENT], ALASKA_X_START, TOP_ROW_Y_START);
      image(Hawaii[CURRENT], HAWAII_X_START, HAWAII_Y_START);
      break;

    case CHART_SELECT_SCREEN:
      for (int i = 0; i < widgetList.size(); i++)
      {
        Widget aWidget = (Widget) widgetList.get(i);
        aWidget.draw();
      }
      String outgoingFlightsString = "TOTAL NUMBER OF OUTGOING FLIGHTS: " + Integer.toString(outgoingFlights);
      String depString = "CLICK TO VIEW DEPARTURES";
      Airport currentAirport = myAirports.get(event - NUMBER_OF_EVENTS);
      String airportName= "AIRPORT NAME: " + currentAirport.getAirportName();
      textSize(20);
      text(airportName, 100, 120);
      text(outgoingFlightsString, 100, 160);
      text(depString, DEP_X + Departures[CURRENT].width/2 - textWidth(depString)/2, DEP_Y + Departures[CURRENT].height + 10);
      image(Departures[CURRENT], DEP_X, DEP_Y);
      break;
    }
  }

  void hover()
  {
    US[CURRENT] = changeShadow(US_X_START, TOP_ROW_Y_START, US[START], US[SHADOW]);
    Alaska[CURRENT] = changeShadow(ALASKA_X_START, TOP_ROW_Y_START, Alaska[START], Alaska[SHADOW]);
    Hawaii[CURRENT] = changeShadow(HAWAII_X_START, HAWAII_Y_START, Hawaii[START], Hawaii[SHADOW]);
    Departures[CURRENT] = changeShadow(DEP_X, DEP_Y, Departures[START], Departures[SHADOW]); //<>//
  }

  PImage changeShadow(int xpos, int ypos, PImage start, PImage shadow)
  {
    if (mouseX > xpos && mouseX < xpos + start.width && mouseY > ypos && mouseY < ypos + start.height)
    {
      return shadow;
    } else
    { //<>//
      return start;
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
