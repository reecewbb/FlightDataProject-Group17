class BarChart //<>// //<>// //<>//
{
  int barChartYAxisLength;
  int barChartXAxisLength;
  int airportID;
  String airportName;
  ArrayList<Airport> airportList = new ArrayList();
  ArrayList<Flight> flightList = new ArrayList();
  ArrayList<Flight> outgoingFlights = new ArrayList();
  int[] flightCount;
  int[] destinationCount;

  BarChart(int airportID, ArrayList airportList, ArrayList flightList)
  {
    this.barChartYAxisLength = BAR_CHART_Y_AXIS_LENGTH; //<>//
    this.barChartXAxisLength = BAR_CHART_X_AXIS_LENGTH;
    this.airportID = airportID;
    this.airportList = airportList;
    this.flightList = flightList;
    Airport currentAirport = (Airport) airportList.get(airportID);
    airportName = currentAirport.getAirportName();
    //for (int i = 0; i < flightList.size(); i++)
    //{
      //Flight currentFlight = (Flight) flightList.get(i);
      //String origin = currentFlight.getOrigin();
      //if (origin.equals(airportName))
      //{
        //outgoingFlights.add(currentFlight);
      //}
    //}
  }

  public int findMaxValue()
  {
    int maxValue = 0;
    destinationCount = createDestinationArray();
    for (int i = 0; i < flightCount.length; i++)
    {
      int currentValue = destinationCount[i];
      if (currentValue > maxValue) maxValue = currentValue;
    }
    return maxValue;
  }


  public int[] createDestinationArray()
  {
    flightCount = new int[airportList.size()];
    for (int i = 0; i < flightList.size(); i++)
    {
      Flight currentFlight = flightList.get(i);
      String originAirport = currentFlight.getOrigin();
      String destAirport = currentFlight.getDest();
      for (int j = 0; j < airportList.size(); j++)
      {
        Airport currentAirport = airportList.get(j);
        if (currentAirport.getAirportName().equals(destAirport) && originAirport.equals(airportName))
        {
          flightCount[currentAirport.getID()]++;
        }
      }
    }
    return flightCount;
  }

  void draw()
  {
    fill(0);
    rect(CHART_BUFFER, SCREENY - CHART_BUFFER, barChartXAxisLength, 10);
    rect(CHART_BUFFER, CHART_BUFFER, 10, barChartYAxisLength);
    int point = CHART_BUFFER;
    double difference = barChartXAxisLength / 50 - 1;                      //only for 50 airports
    text("0", 80, SCREENY - CHART_BUFFER);
    for (int i = 0; i < 50; i++)
    {
      textSize(10);
      Airport currentAirport = airportList.get(i);
      String currentAirportName = currentAirport.getAirportName();
      if (!currentAirportName.equals(airportName))
      {
        point += difference;
        text(currentAirportName, point, SCREENY - 70);
      }
    }
    float maxValue = findMaxValue(); //<>//
    float valueOnY = maxValue / AMOUNT_OF_Y_VALUES;
    float differenceInValue = valueOnY;
    int positionOnY = SCREENY - CHART_BUFFER;
    int differenceInPosition = barChartYAxisLength / 10;
    int xPosition = 80;
    for (int i = 0; i < AMOUNT_OF_Y_VALUES; i++)
    {
      positionOnY -= differenceInPosition;
      String valueOnYAxis = Integer.toString((int)valueOnY);
      valueOnY += differenceInValue;
      text(valueOnYAxis, xPosition, positionOnY);
    }


    point = CHART_BUFFER;
    point += difference;
    int widthOfBar = 20;
    int[] flightCount = createDestinationArray();
    float yIncrement = barChartYAxisLength/maxValue;
    for (int i = 0; i < 50; i++)
    {
      Airport currentAirport = airportList.get(i);
      String currentAirportName = currentAirport.getAirportName();
      if (!currentAirportName.equals(airportName))
      {
        float barHeight = flightCount[i] * yIncrement;
        rect(point, SCREENY - CHART_BUFFER, widthOfBar, -barHeight);
        point += difference;
      }
    }
  }
}
