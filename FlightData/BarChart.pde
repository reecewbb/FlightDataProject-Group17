class BarChart
{
  int barChartYAxisLength;
  int barChartXAxisLength;
  int airportID;
  ArrayList<Airport> airportList = new ArrayList();
  ArrayList<Flight> flightList = new ArrayList();
  ArrayList<Flight> outgoingFlights = new ArrayList();

  BarChart(int airportID, ArrayList airportList, ArrayList flightList)
  {
    this.airportID = airportID;
    this.airportList = airportList;
    Airport currentAirport = airportList.get(airportID);
    String airportName = currentAirport.getAirportName();
    for (int i = 0; i < flightList.size(); i++)
    {
      Flight currentFlight = (Flight) flightList.get(i);
      if (currentFlight.getOrigin() == airportName)
      {
        outgoingFlights.add(currentFlight);
      }
    }
  }

  public int findMaxValue()
  {
    int maxValue = 0;
    int[] desinationCount = createDestinationArray();
    for (int i = 0; i < outgoingCount.length; i++)
    {
      int currentValue = destinationCount[i];
      if (currentValue > maxValue) maxValue = currentValue;
    }
    return maxValue;
  }

  public int[] createDestinationArray
  {
    int[] outgoingCount = new int[outgoingFlights.size()];
    for (int i = 0; i < outgoingFlights.size(); i++)
    {
      Flight currentFlight = outgoingFlights.get(i);
      String destAirport = currentFlight.getDest();
      for (int j = 0; j < airportList.size(); j++)
      {
        Airport currentAirport = airportList.get(i);
        if (currentAirport.getAirportName() == destAirport)
        {
          outgoingCount[currentAirport.getID()]++;
        }
      }
    }
    return outgoingCount;
  }

  void draw()
  {
    fill(0);
    rect(20, SCREENY + 30, barChartXAxisLength, 10);
    rect(20, SCREENY + 30, 10, barChartYAxisLength);
    float separation = barChartXAxisLength/130;
    for (int i = 0; i < myAirports.size(); i++)
    {
      textSize(10);
      text(myAirports.get(i).name, separation, SCREENY + 25);
      separation *= 2;
    }
  }
}
