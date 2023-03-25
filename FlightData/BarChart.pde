class BarChart
{
  int barChartYAxisLength, barChartXAxisLength, airportID;
  String airportName, chartName;
  ArrayList<Airport> airportList = new ArrayList();
  ArrayList<Flight> flightList = new ArrayList();
  int[] flightCount, destinationCount;
  int number, maxValue, amountOfYValues, valueOnY, differenceInValue, positionOnY, xPosition, point, airportCounter, airportCounter2, amountOfOutgoingFlights;
  float differenceInPosition, yIncrement, difference, widthOfBar;
  boolean firstTime;

  BarChart(int airportID, ArrayList airportList, ArrayList flightList)
  {
    this.barChartYAxisLength = BAR_CHART_Y_AXIS_LENGTH;
    this.barChartXAxisLength = BAR_CHART_X_AXIS_LENGTH;
    this.airportID = airportID; //<>//
    this.airportList = airportList;
    this.flightList = flightList;
    Airport currentAirport = (Airport) airportList.get(airportID);
    airportName = currentAirport.getAirportName();
    outgoingFlightsCalculation();
    for (int i = 0; i < destinationCount.length; i++)
    {
      amountOfOutgoingFlights += destinationCount[i];
    }
  }
  
  public int getAmountOfOutgoingFlights()
  {
    return amountOfOutgoingFlights;
  }

  public int findMaxValue()
  {
    int maxValue = 0;
    destinationCount = createDestinationArray();
    for (int i = 0; i < destinationCount.length; i++)
    {
      int currentValue = destinationCount[i];
      if (currentValue > maxValue) maxValue = currentValue;
    }
    return maxValue;
  }


  public int[] createDestinationArray()
  {
    int[] newFlightCount = new int[airportList.size()];
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
          newFlightCount[currentAirport.getID()]++;
        }
      }
    }
    return newFlightCount;
  }

  void draw()
  {
    drawBarChartForOutgoingFlights();
  }

  void drawBarChartForOutgoingFlights()
  {
    setBarChart();
    text(chartName, SCREENX/2 - textWidth(chartName)/2, TOP_TEXT_BUFFER);
    if (maxValue != 0)
    {
      for (int i = 0; i < amountOfYValues; i++)
      {
        positionOnY -= differenceInPosition;
        String valueOnYAxis = Integer.toString((int)valueOnY);
        valueOnY += differenceInValue;
        text(valueOnYAxis, xPosition, positionOnY);
        rect(xPosition + 20, positionOnY, barChartXAxisLength, 0.5);
      }
      fill(#08F4FA);
      int i = 0;
      while (airportCounter2 < airportCounter && i < airportList.size())
      {
        Airport currentAirport = airportList.get(i);
        String currentAirportName = currentAirport.getAirportName();
        if (!currentAirportName.equals(airportName) && flightCount[i] != 0)
        {
          textSize(10);
          fill(0);
          text(currentAirportName, point + (widthOfBar / 2) - (textWidth(currentAirportName)/2), SCREENY - 70);
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

  void outgoingFlightsCalculation()
  {
    chartName = "Number of outgoing flights from " + airportName;
    maxValue = findMaxValue();
    if (maxValue != 0)
    {
      if (maxValue > MAX_Y_VALUES) amountOfYValues = MAX_Y_VALUES;
      else amountOfYValues = maxValue;
      valueOnY = (maxValue / amountOfYValues) + 1;
      amountOfYValues = (maxValue / valueOnY) + 1;
      differenceInValue = valueOnY;
      positionOnY = SCREENY - CHART_BUFFER;
      differenceInPosition = barChartYAxisLength/amountOfYValues;
      xPosition = 80;
      point = CHART_BUFFER + 20;
      flightCount = createDestinationArray();
      yIncrement = differenceInPosition/differenceInValue;
      airportCounter = 0;
      for (int i = 0; i < airportList.size(); i++)
      {
        Airport nextAirport = (Airport) airportList.get(i);
        String nextAirportName = nextAirport.getAirportName();
        if (!nextAirportName.equals(airportName) && flightCount[i] != 0)
        {
          airportCounter++;
        }
      }
      if (airportCounter > 50) airportCounter = 50;
      difference = (barChartXAxisLength / airportCounter) * 0.99;
      widthOfBar = difference * 0.8;
      airportCounter2 = 0;
    }
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
