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
  
  int buttonClicked()
  {
    int event;
    for (int i = 0; i < airportList.size(); i++)
    {
      Airport myAirport = (Airport) airportList.get(i);
      event = myAirport.airportClicked(mouseX, mouseY);
      if (event != -1) return event;
    }
    return NO_EVENT;
  }

  void draw()
  {
    myFont=loadFont("Arial-Black-48.vlw");
    textFont(myFont);
    textSize(10);
    if(screenType == MAP_SCREEN) image(mapImage, 0, 0);
    else if (screenType == BAR_CHART_SCREEN)
    {
        text("BAR CHART", SCREENX/2, SCREENY/2);                        @PUT BAR CHART CALL HERE
    }
    for (int z = 0; z < airportList.size(); z++)
    {
      Airport myAirport = (Airport) airportList.get(z);
      myAirport.draw();
    }
  }
}
