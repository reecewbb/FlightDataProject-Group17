class Screen {
  ArrayList widgetList = new ArrayList();
  ArrayList airportList = new ArrayList();
  int screenType;

  Screen (int screenType)
  {
    this.screenType = screenType;
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
      for (int i = 0; i < airportList.size(); i++)
      {
        Airport myAirport = (Airport) airportList.get(i);
        event = myAirport.airportClicked(mouseX, mouseY);
         if (event != -1)
        {
           return event;
        }
      }
      for(int i = 0; i < widgetList.size(); i++)
      {
        Widget myWidget = (Widget) widgetList.get(i);
        event = myWidget.getEvent(mouseX, mouseY);
        if(event != -1)
        {
           return event;
        }
      }
    } else
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

  void draw(int event, ArrayList<Airport> myAirports, ArrayList<Flight> myFlights)
  {
    myFont=loadFont("Arial-Black-48.vlw");
    textFont(myFont);
    textSize(10);
    mapImage = loadImage("Blank_US_Map.png");
    switch(screenType)
    {
      case MAP_SCREEN:
      mapImage.resize(SCREENX, SCREENY);
      image(mapImage, 0, 0);
      for (int i = 0; i < airportList.size(); i++)
      {
        Airport myAirport = (Airport) airportList.get(i);
        myAirport.draw(MAP_SCREEN);
      }
      for(int i = 0; i < widgetList.size(); i++)
      {
        Widget myWidget = (Widget) widgetList.get(i);
        myWidget.draw();
      }
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

      case(BAR_CHART_SCREEN):
      for (int i = 0; i < widgetList.size(); i++)
      {
        Widget aWidget = (Widget) widgetList.get(i);
        aWidget.draw();
      }
      BarChart bc = new BarChart(event, myAirports, myFlights);
      bc.draw();
      break;
    }
  }
  
  void setScreen(int widthNo, int heightNo, int ID)
   {
     mapImage.resize(SCREENX * 3, SCREENY * 3);
     image(mapImage, -widthNo * SCREENX, -heightNo * SCREENY);
     for (int i = 0; i < airportList.size(); i++)
      {
        Airport myAirport = (Airport) airportList.get(i);
        myAirport.draw(ID);
      }
   }
}
