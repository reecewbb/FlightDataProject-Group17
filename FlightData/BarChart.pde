class BarChart
{
  int barChartYAxisLength, barChartXAxisLength, airportID;
  String airportName, chartName;
  ArrayList<Airport> airportList = new ArrayList();
  ArrayList<Flight> flightList = new ArrayList();
  int[] flightCount, queryCount;
  int number, maxValue, amountOfYValues, valueOnY, differenceInValue, positionOnY, xPosition, point, airportCounter, airportCounter2, amountOfQuery, query;
  float differenceInPosition, yIncrement, difference, widthOfBar;
  boolean firstTime;

  BarChart(int airportID, ArrayList airportList, ArrayList flightList, int query)
  {
    this.barChartYAxisLength = BAR_CHART_Y_AXIS_LENGTH;
    this.barChartXAxisLength = BAR_CHART_X_AXIS_LENGTH;
    this.airportID = airportID;
    this.airportList = airportList;
    this.flightList = flightList;
    this.query = query;
    Airport currentAirport = (Airport) airportList.get(airportID);
    airportName = currentAirport.getAirportName();
    queryCalculation();
    for (int i = 0; i < queryCount.length; i++)
    {
      amountOfQuery += queryCount[i];
    }
  }

  public int getQuery()
  {
    return amountOfQuery;
  }

  public int findMaxValue()
  {
    int maxValue = 0;
    queryCount = createDestinationArray();
    for (int currentValue : queryCount)
    {
      if (currentValue > maxValue)
      {
        maxValue = currentValue;
      }
    }
    return maxValue;
  }


  public int[] createDestinationArray()
  {
    int[] newFlightCount = new int[airportList.size()];
    for (Flight currentFlight : flightList)
    {
      String originAirport = currentFlight.getOrigin();
      String destAirport = currentFlight.getDest();
      for (int j = 0; j < airportList.size(); j++)
      {
        Airport currentAirport = airportList.get(j);
        if(query == OUTGOING)
        {
          if (currentAirport.getAirportName().equals(destAirport) && originAirport.equals(airportName))
          {
            newFlightCount[currentAirport.getID()]++;
          }
        }
        else if (query == INCOMING)
        {
          if (currentAirport.getAirportName().equals(originAirport) && destAirport.equals(airportName))
          {
            newFlightCount[currentAirport.getID()]++;
          }
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
    textSize(20);
    text(chartName, SCREENX/2, TOP_TEXT_BUFFER);
    textSize(10);
    if (maxValue != 0)
    {
      strokeWeight(1);
      for (int i = 0; i < amountOfYValues; i++)
      {
        positionOnY -= differenceInPosition;
        String valueOnYAxis = Integer.toString((int)valueOnY);
        valueOnY += differenceInValue;
        text(valueOnYAxis, xPosition, positionOnY);
        rect(xPosition + 20, positionOnY, barChartXAxisLength, 0.5);
      }
      fill(#2FBEE8);
      int i = 0;
      strokeWeight(2);
      while (airportCounter2 < airportCounter && i < airportList.size())
      {
        Airport currentAirport = airportList.get(i);
        String currentAirportName = currentAirport.getAirportName();
        String cityName = currentAirport.getCityName();
        if (!currentAirportName.equals(airportName) && flightCount[i] != 0)
        {
          fill(0);
          text(currentAirportName, point + (widthOfBar / 2) - (textWidth(currentAirportName)/2), SCREENY - 70);
          float barHeight = flightCount[i] * yIncrement;
          pushMatrix();
          textSize(12);
          textAlign(LEFT);
          translate(point + widthOfBar/2, SCREENY - CHART_BUFFER - barHeight - 10);
          rotate(-HALF_PI);
          text(cityName, 0, 0);
          popMatrix();
          textAlign(CENTER);
          textSize(10);
          fill(#08F4FA);
          rect(point, SCREENY - CHART_BUFFER, widthOfBar, -barHeight);
          airportCounter2++;
          point += difference;
        }
        i++;
      }
    } else text("NO DATA AVAILABLE", SCREENX/2, SCREENY/2);
  }

  void queryCalculation() {
    if (query == OUTGOING) chartName = "Number of outgoing flights from " + airportName;
    else if (query == INCOMING) chartName = "Number of incoming flights to " + airportName;
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
      if (airportCounter > 40) airportCounter = 40;
      difference = (barChartXAxisLength / airportCounter) * 0.99;
      widthOfBar = difference * 0.8;
      airportCounter2 = 0;
    }
  }

  void setBarChart()
  {
    fill(0);
    stroke(0);
    strokeWeight(1);
    rect(CHART_BUFFER, SCREENY - CHART_BUFFER, barChartXAxisLength, 10);
    rect(CHART_BUFFER, CHART_BUFFER, 10, barChartYAxisLength);
    text("0", 80, SCREENY - CHART_BUFFER);
  }
}
