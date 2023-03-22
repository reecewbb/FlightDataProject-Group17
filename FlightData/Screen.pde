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
    if(screenType == MAP_SCREEN)
    {
      for (int i = 0; i < airportList.size(); i++)
      {
        Airport myAirport = (Airport) airportList.get(i);
        event = myAirport.airportClicked(mouseX, mouseY);
        if (event != -1) return event;
      }
    }
    else 
    {
      for (int i = 0; i < widgetList.size(); i++)
      {
        //insert code to return widget event
      }
    }
    return NO_EVENT;
  }

  void draw(int event, ArrayList<Airport> myAirports, ArrayList<Flight> myFlights)
  {
    myFont=loadFont("Arial-Black-48.vlw");
    textFont(myFont);
    textSize(10);
    if (screenType == MAP_SCREEN) {
      image(mapImage, 0, 0);
      for (int z = 0; z < airportList.size(); z++)
      {
        Airport myAirport = (Airport) airportList.get(z);
        myAirport.draw();
      }
    }
    if (screenType == BAR_CHART_SCREEN)
    {
      for (int i = 0; i < widgetList.size(); i++) 
      {
        Widget aWidget = (Widget) widgetList.get(i);
        aWidget.draw();
      }
      BarChart bc = new BarChart(event, myAirports, myFlights);
      bc.draw();
    }
  }
}
