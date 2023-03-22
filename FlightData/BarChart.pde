class BarChart
{
  int barChartYAxisLength;
  int barChartXAxisLength;
  int airportID;
  ArrayList<Airport> airportList = new ArrayList();
  ArrayList<Flight> flightList = new ArrayList();
  ArrayList<Flight> outgoingFlights = new ArrayList();
  int[] outgoingCount;

  BarChart(int airportID, String airportName, ArrayList airportList, ArrayList flightList)
  {
    this.airportID = airportID;
    this.airportList = airportList;
    for (int i = 0; i < flightList.size(); i++)
    {
      Flight currentFlight = (Flight) flightList.get(i);
      if (currentFlight.getOrigin() == airportName)
      {
        outgoingFlights.add(currentFlight);
      }
    }
    outgoingCount = new int[outgoingFlights.size()];
  }

  void addAirport(Airport airport)
  {
    airportList.add(airport);
  }


  public int findMaxValue()
  {
    int maxValue = 0;
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
    for (int i = 0; i < outgoingCount.length; i++)
    {
      int currentValue = outgoingCount[i];
      if (currentValue > maxValue) maxValue = currentValue;
    }
    return maxValue;
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
