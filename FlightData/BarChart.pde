class BarChart
{
  int barChartYAxisLength, barChartXAxisLength, airportID;
  String airportName;
  ArrayList<Airport> airportList = new ArrayList();
  ArrayList<Flight> flightList = new ArrayList();
  ArrayList<Flight> outgoingFlights = new ArrayList();
  int[] flightCount, destinationCount;
  int number;

  BarChart(int airportID, ArrayList airportList, ArrayList flightList)
  {
    this.barChartYAxisLength = BAR_CHART_Y_AXIS_LENGTH;
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
    drawBarChartForOutgoingFlights();
  }

  void drawBarChartForOutgoingFlights()
  {
    setBarChart();
    int maxValue = findMaxValue();
    if (maxValue != 0)
    {
      int amountOfYValues;
      if (maxValue > MAX_Y_VALUES) amountOfYValues = MAX_Y_VALUES;
      else amountOfYValues = maxValue;
      int valueOnY = maxValue / amountOfYValues;
      valueOnY++;
      amountOfYValues = maxValue / valueOnY;
      amountOfYValues++;
      int differenceInValue = valueOnY;
      int positionOnY = SCREENY - CHART_BUFFER;
      float differenceInPosition = barChartYAxisLength/amountOfYValues;
      int xPosition = 80;
      for (int i = 0; i < amountOfYValues; i++)
      {
        positionOnY -= differenceInPosition;
        String valueOnYAxis = Integer.toString((int)valueOnY);
        valueOnY += differenceInValue;
        text(valueOnYAxis, xPosition, positionOnY);
        rect(xPosition + 20, positionOnY, barChartXAxisLength, 0.5); 
      }

      fill(#08F4FA);
      int point = CHART_BUFFER + 20;
      int[] flightCount = createDestinationArray();
      float yIncrement = differenceInPosition/differenceInValue;
      int airportCounter = 0;
      for (int i = 0; i < airportList.size(); i++)
      {
        Airport currentAirport = airportList.get(i);
        String currentAirportName = currentAirport.getAirportName();
        if (!currentAirportName.equals(airportName) && flightCount[i] != 0)
        {
          airportCounter++;
        }
      }
      if(airportCounter > 50) airportCounter = 50;
      float difference = (barChartXAxisLength / airportCounter) * 0.99;
      float widthOfBar = difference * 0.8;
      int airportCounter2 = 0;
      int i = 0;
      while (airportCounter2 < airportCounter && i < airportList.size())
      {
        Airport currentAirport = airportList.get(i);
        String currentAirportName = currentAirport.getAirportName();
        if (!currentAirportName.equals(airportName) && flightCount[i] != 0)
        {
          textSize(10);
          fill(0);
          text(currentAirportName, point + (difference / 2) - 10, SCREENY - 70);
          fill(#08F4FA);
          float barHeight = flightCount[i] * yIncrement;
          rect(point, SCREENY - CHART_BUFFER, widthOfBar, -barHeight);
          airportCounter2++;
          point += difference;
        }
        i++;
      }
    } else text("NO DATA AVAILABLE", SCREENX/2, SCREENY/2);
  }

  void setBarChart()
  {
    fill(0);
    stroke(0);
    rect(CHART_BUFFER, SCREENY - CHART_BUFFER, barChartXAxisLength, 10);
    rect(CHART_BUFFER, CHART_BUFFER, 10, barChartYAxisLength);
    text("0", 80, SCREENY - CHART_BUFFER);
  }
}
