class Screen {
  ArrayList widgetList = new ArrayList();
  ArrayList airportList = new ArrayList();

  void addAirport(Airport airport) {
    airportList.add(airport);
  }

  void draw()
  {
    image(mapImage, 0, 0);
    myFont=loadFont("Arial-Black-48.vlw");
    textFont(myFont);
    textSize(10);
    for (int z = 0; z < airportList.size(); z++)
    {
      Airport myAirport = (Airport) airportList.get(z);
      myAirport.draw();
    }
  }
}
