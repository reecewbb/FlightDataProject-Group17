class Screen { //<>// //<>// //<>//
  ArrayList widgetList = new ArrayList();
  ArrayList<Airport> airportList = new ArrayList();
  int screenType, outgoingFlights, currentGridHover, screen, incomingFlights;
  float[][] rectangleWidth;
  String[] areaNames;

  Screen (int screenType)
  {
    this.screenType = screenType;
    myFont=loadFont("MicrosoftJhengHeiUIRegular-40.vlw");
    textFont(myFont);
    textSize(10);
    setImages();
    rectangleWidth = new float[9][3];
    for (int i = 0; i < 9; i++)
    {
      rectangleWidth[i][START] = 0.5;
      rectangleWidth[i][CHANGED] = 2;
      rectangleWidth[i][CURRENT] = rectangleWidth[i][START];
    }
    areaNames = new String[9];
    areaNames[TOP_LEFT] = "North West US";
    areaNames[TOP_MID] = "North Central US";
    areaNames[TOP_RIGHT] = "North East US";
    areaNames[MID_LEFT] = "West US";
    areaNames[MID_MID] = "Central US";
    areaNames[MID_RIGHT] = "East US";
    areaNames[BOT_LEFT] = "South West US";
    areaNames[BOT_MID] = "South Central US";
    areaNames[BOT_RIGHT] = "South East US";
  }

  void setShadowArray(PImage[] array, String startName, String shadowName, int size)
  {
    array[START] = loadImage(startName);
    array[CHANGED] = loadImage(shadowName);
    array[START].resize(size, 0);
    array[CHANGED].resize(size + 5, 0);
    array[CURRENT] = array[START];
  }

  void setImages()
  {
    mapImage = loadImage("Blank_US_Map.png");
    alaskaMapImage = loadImage("Start_Alaska_Map.png");
    hawaiiMapImage = loadImage("Start_Hawaii_Map.png");
    US = new PImage[3];
    Alaska = new PImage[3];
    Hawaii = new PImage[3];
    Departures = new PImage[3];
    Arrivals = new PImage[3];
    Airlines = new PImage[3];
    setShadowArray(US, "Start_US_Map.png", "Shadow_US.png", START_MAP_WIDTH);
    setShadowArray(Alaska, "Start_Alaska_Map.png", "Shadow_Alaska.png", START_MAP_WIDTH);
    setShadowArray(Hawaii, "Start_Hawaii_Map.png", "Shadow_Hawaii.png", START_MAP_WIDTH);
    setShadowArray(Departures, "departures.png", "shadow_departures.png", CHART_BUTTON_SIZE);
    setShadowArray(Arrivals, "arrivals.png", "shadow_arrivals.png", CHART_BUTTON_SIZE);
    setShadowArray(Airlines, "airline_logos.png", "airline_logos_shadow.png", CHART_BUTTON_SIZE);
  }

  void setOutgoingFlights(int outgoingFlights)
  {
    this.outgoingFlights = outgoingFlights;
  }

  void setIncomingFlights(int incomingFlights)
  {
    this.incomingFlights = incomingFlights;
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
    for (int i = 0; i < widgetList.size(); i++)
    {
      Widget myWidget = (Widget) widgetList.get(i);
      event = myWidget.getEvent(mouseX, mouseY);
      if (event != -1)
      {
        return event;
      }
    }
    if (screenType == MAP_SCREEN)
    {
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
    if ((screenType >= TOP_LEFT_SCREEN && screenType <= BOT_RIGHT_SCREEN) || screenType == ALASKA_SCREEN || screenType == HAWAII_SCREEN)
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
    }
    return NO_EVENT;
  }

  void draw(int event, ArrayList<Airport> myAirports, ArrayList<Flight> myFlights, Filter mapFilter)
  {
    if (event == NO_EVENT)
    {
      event = previousEventScreen;
    }
    switch(screenType)
    {
    case MAP_SCREEN:
      fill(BLACK);
      mapImage.resize(SCREENX, SCREENY);
      image(mapImage, 0, 0);
      String selectArea = "Select area";
      textSize(20);
      text(selectArea, SCREENX/2, TOP_TEXT_BUFFER);
      textSize(10);
      stroke(120);
      drawGrid();
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
      drawAreaName();
      textSize(20);
      text("Sort", FILTER_WIDGET_X + FILTER_WIDGET_WIDTH / 2, 690);
      break;

    case TOP_LEFT_SCREEN:
      setScreen(0, 0, TOP_LEFT_SCREEN);
      break;

    case TOP_MID_SCREEN:
      setScreen(1, 0, TOP_MID_SCREEN);
      break;

    case TOP_RIGHT_SCREEN:
      setScreen(2, 0, TOP_RIGHT_SCREEN);
      break;

    case MID_LEFT_SCREEN:
      setScreen(0, 1, MID_LEFT_SCREEN);
      break;

    case MID_MID_SCREEN:
      setScreen(1, 1, MID_MID_SCREEN);
      break;

    case MID_RIGHT_SCREEN:
      setScreen(2, 1, MID_RIGHT_SCREEN);
      break;

    case BOT_LEFT_SCREEN:
      setScreen(0, 2, BOT_LEFT_SCREEN);
      break;

    case BOT_MID_SCREEN:
      setScreen(1, 2, BOT_MID_SCREEN);
      break;

    case BOT_RIGHT_SCREEN:
      setScreen(2, 2, BOT_RIGHT_SCREEN);
      break;

    case OUTGOING_BAR_CHART_SCREEN:
      for (int i = 0; i < widgetList.size(); i++)
      {
        Widget aWidget = (Widget) widgetList.get(i);
        aWidget.draw();
      }
      outgoingFlightsChart = new BarChart(lastAirportSelected - CHART_SELECTION_EVENT, myAirports, myFlights, OUTGOING);
      previousEventScreen = event;
      outgoingFlightsChart.draw();
      break;

    case START_SCREEN:
      String start = "AIRPORT DATA VIEWER";
      String regionSelect = "Select Region";
      String continentalUS = "Continental US";
      String alaska = "Alaska";
      String hawaii = "Hawaii";
      fill(0);
      textSize(50);
      text(start, SCREENX/2, 100);
      textSize(30);
      text(regionSelect, SCREENX/2, 170);
      textSize(20);
      text(continentalUS, US_X_START + START_MAP_WIDTH/2, TOP_ROW_Y_START - 30);
      text(alaska, ALASKA_X_START + START_MAP_WIDTH/2, TOP_ROW_Y_START - 30);
      text(hawaii, HAWAII_X_START + START_MAP_WIDTH/2, HAWAII_Y_START + 80);
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
      if (event <= CHART_SELECTION_EVENT) event = lastAirportSelected;
      Airport currentAirport = myAirports.get(event - CHART_SELECTION_EVENT);
      airlinesChart = new PieChart(lastAirportSelected - CHART_SELECTION_EVENT, myAirports, myFlights);
      String airportName = "Airport: " + currentAirport.getAirportName();
      String cityName = "City: " + currentAirport.getCityName();
      String outgoingFlightsString = "Total number of outgoing flights: " + Integer.toString(outgoingFlights);
      String incomingFlightsString = "Total number of incoming flights: " + Integer.toString(incomingFlights);
      String mostCommonAirline = "Most popular airline: " + airlinesChart.getMostCommonAirline();
      String depString = "Click to view departures";
      String arrString = "Click to view arrivals";
      String airString = "Click to view airlines";
      fill(BLACK);
      textSize(20);
      textAlign(LEFT);
      text(airportName, 100, 120);
      text(cityName, 100, 160);
      text(outgoingFlightsString, 100, 200);
      text(incomingFlightsString, 100, 240);
      text(mostCommonAirline, 100, 280);
      textAlign(CENTER);
      text(depString, DEP_X + Departures[CURRENT].width/2, DEP_Y + Departures[CURRENT].height + 10);
      text(arrString, ARR_X + Arrivals[CURRENT].width/2, ARR_Y + Arrivals[CURRENT].height + 30);
      text(airString, PIE_X + Airlines[CURRENT].width/2, PIE_Y + Airlines[CURRENT].height + 30);
      image(Departures[CURRENT], DEP_X, DEP_Y);
      image(Arrivals[CURRENT], ARR_X, ARR_Y);
      image(Airlines[CURRENT], PIE_X, PIE_Y);
      break;

    case ALASKA_SCREEN:
      for (int i = 0; i < widgetList.size(); i++)
      {
        Widget aWidget = (Widget) widgetList.get(i);
        aWidget.draw();
      }
      for (int i = 0; i < airportList.size(); i++)
      {
        Airport myAirport = (Airport) airportList.get(i);
        myAirport.draw(MAP_SCREEN);
      }
      alaskaMapImage.resize(int(SCREENX * 0.9), 0);
      image(alaskaMapImage, 50, 100);
      textSize(30);
      text("ALASKA", SCREENX/2, textAscent() * 2);
      break;

    case HAWAII_SCREEN:
      for (int i = 0; i < widgetList.size(); i++)
      {
        Widget aWidget = (Widget) widgetList.get(i);
        aWidget.draw();
      }
      for (int i = 0; i < airportList.size(); i++)
      {
        Airport myAirport = (Airport) airportList.get(i);
        myAirport.draw(MAP_SCREEN);
      }
      hawaiiMapImage.resize(0, int(SCREENY*1.1));
      image(hawaiiMapImage, 220, 0);
      textSize(30);
      text("HAWAII", SCREENX/2, textAscent() * 2);
      break;

    case PIE_CHART_SCREEN:
      for (int i = 0; i < widgetList.size(); i++)
      {
        Widget aWidget = (Widget) widgetList.get(i);
        aWidget.draw();
      }
      previousEventScreen = event;
      airlinesChart.draw();
      break;

    case INCOMING_BAR_CHART_SCREEN:
      for (int i = 0; i < widgetList.size(); i++)
      {
        Widget aWidget = (Widget) widgetList.get(i);
        aWidget.draw();
      }
      incomingFlightsChart = new BarChart(lastAirportSelected - CHART_SELECTION_EVENT, myAirports, myFlights, INCOMING);
      previousEventScreen = event;
      incomingFlightsChart.draw();
      break;
    }
  }

  void drawGrid()
  {
    strokeWeight(1);
    rect(0, SCREENY/3, SCREENX/3, rectangleWidth[TOP_LEFT][CURRENT]);
    rect(SCREENX/3, 0, rectangleWidth[TOP_LEFT][CURRENT], SCREENY/3);

    rect(SCREENX/3, 0, rectangleWidth[TOP_MID][CURRENT], SCREENY/3);
    rect(2 * SCREENX/3, 0, rectangleWidth[TOP_MID][CURRENT], SCREENY/3);
    rect(SCREENX/3, SCREENY/3, SCREENX/3, rectangleWidth[TOP_MID][CURRENT]);

    rect(2 * SCREENX/3, 0, rectangleWidth[TOP_RIGHT][CURRENT], SCREENY/3);
    rect(2 * SCREENX/3, SCREENY/3, SCREENX/3, rectangleWidth[TOP_RIGHT][CURRENT]);

    rect(0, SCREENY/3, SCREENX/3, rectangleWidth[MID_LEFT][CURRENT]);
    rect(SCREENX/3, SCREENY/3, rectangleWidth[MID_LEFT][CURRENT], SCREENY/3);
    rect(0, 2 * SCREENY/3, SCREENX/3, rectangleWidth[MID_LEFT][CURRENT]);

    rect(SCREENX/3, SCREENY/3, SCREENX/3, rectangleWidth[MID_MID][CURRENT]);
    rect(SCREENX/3, SCREENY/3, rectangleWidth[MID_MID][CURRENT], SCREENY/3);
    rect(2 * SCREENX/3, SCREENY/3, rectangleWidth[MID_MID][CURRENT], SCREENY/3);
    rect(SCREENX/3, 2*SCREENY/3, SCREENX/3, rectangleWidth[MID_MID][CURRENT]);

    rect(2 * SCREENX/3, SCREENY/3, SCREENX/3, rectangleWidth[MID_RIGHT][CURRENT]);
    rect(2 * SCREENX/3, SCREENY/3, rectangleWidth[MID_RIGHT][CURRENT], SCREENY/3);
    rect(2 * SCREENX/3, 2 * SCREENY/3, SCREENX/3, rectangleWidth[MID_RIGHT][CURRENT]);

    rect(0, 2 * SCREENY/3, SCREENX/3, rectangleWidth[BOT_LEFT][CURRENT]);
    rect(SCREENX/3, 2 * SCREENY/3, rectangleWidth[BOT_LEFT][CURRENT], SCREENY/3);

    rect(SCREENX/3, 2 * SCREENY/3, rectangleWidth[BOT_MID][CURRENT], SCREENY/3);
    rect(SCREENX/3, 2*SCREENY/3, SCREENX/3, rectangleWidth[BOT_MID][CURRENT]);
    rect(2 * SCREENX/3, 2* SCREENY/3, rectangleWidth[BOT_MID][CURRENT], SCREENY/3);

    rect(2 * SCREENX/3, 2* SCREENY/3, rectangleWidth[BOT_RIGHT][CURRENT], SCREENY/3);
    rect(2 * SCREENX/3, 2 * SCREENY/3, SCREENX/3, rectangleWidth[BOT_RIGHT][CURRENT]);
  }

  void hover()
  {
    switch (screenType)
    {
    case MAP_SCREEN:
      screen = checkScreen();
      changeRectWidth(screen);
      break;

    case START_SCREEN:
      US[CURRENT] = changeShadow(US_X_START, TOP_ROW_Y_START, US[START], US[CHANGED]);
      Alaska[CURRENT] = changeShadow(ALASKA_X_START, TOP_ROW_Y_START, Alaska[START], Alaska[CHANGED]);
      Hawaii[CURRENT] = changeShadow(HAWAII_X_START, HAWAII_Y_START, Hawaii[START], Hawaii[CHANGED]);
      break;

    case CHART_SELECT_SCREEN:
      Departures[CURRENT] = changeShadow(DEP_X, DEP_Y, Departures[START], Departures[CHANGED]);
      Arrivals[CURRENT] = changeShadow(ARR_X, ARR_Y, Arrivals[START], Arrivals[CHANGED]);
      Airlines[CURRENT] = changeShadow(PIE_X, PIE_Y, Airlines[START], Airlines[CHANGED]);
      break;
    }
  }

  PImage changeShadow(int xpos, int ypos, PImage start, PImage shadow)
  {
    if (mouseX > xpos && mouseX < xpos + start.width && mouseY > ypos && mouseY < ypos + start.height)
    {
      return shadow;
    } else
    {
      return start;
    }
  }


  void drawAreaName()
  {
    int screenCopy = screen;
    int row = 0;
    int column = 0;
    while (screenCopy > 2)
    {
      screenCopy -= 3;
      row++;
    }
    while (screenCopy > 0)
    {
      screenCopy--;
      column++;
    }
    fill(BLACK);
    textSize(15);
    text(areaNames[screen], (column * SCREENX / 3) + (SCREENX / 6), row * SCREENY / 3 + textAscent() * 2);
  }

  int checkScreen()
  {
    float mX = mouseX - SCREENX/3;
    float mY = mouseY - SCREENY/3;
    int screen = TOP_LEFT;
    while (mX > 0)
    {
      mX -= SCREENX/3;
      screen++;
    }
    while (mY > 0)
    {
      mY -= SCREENY/3;
      screen += 3;
    }
    return screen;
  }

  void changeRectWidth(int screen)
  {
    for (int i = 0; i < rectangleWidth.length; i++)
    {
      rectangleWidth[i][CURRENT] = rectangleWidth[i][START];
    }
    rectangleWidth[screen][CURRENT] = rectangleWidth[screen][CHANGED];
    currentGridHover = screen;
  }

  void setScreen(int widthNo, int heightNo, int ID)
  {
    fill(BLACK);
    mapImage.resize(SCREENX * 3, SCREENY * 3);
    image(mapImage, -widthNo * SCREENX, -heightNo * SCREENY);
    textSize(20);
    text(areaNames[ID - 1], SCREENX/2, 50);
    String selectAirport = "SELECT AIRPORT";
    textSize(15);
    text(selectAirport, SCREENX/2, TOP_TEXT_BUFFER + 50);
    for (Airport currentAirport : airportList)
    {
      currentAirport.draw(ID);
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
