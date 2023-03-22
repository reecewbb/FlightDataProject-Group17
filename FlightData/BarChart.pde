class BarChart
{
  int barChartYAxisLength;
  int barChartXAxisLength;
  
  BarChart()
  {
    this.barChartYAxisLength = 800;
    this.barChartXAxisLength = 1200;
  }
  
  public String findClickedAirport(ArrayList <Airport>myAirports)
  {
    String clickedAirport = "";
    for(int i = 0; i < myAirports.size(); i++)
    {
      if(myAirports.get(i).isClicked == true)
      {
        clickedAirport = myAirports.get(i).name;
      }
    }
    return clickedAirport;
  }
  
  
  public int findMaxValue(ArrayList <Airport>myAirports, ArrayList <Flight>MyFlights)
  {
    int maxValue = 0;
    BarChart bc = new BarChart();
    String clickedAirport = bc.findClickedAirport(myAirports);
    for(int i = 0; i < myAirports.size(); i++)
    {
      int numberOfFlightsFromAirportToClickedAirport = 0;
      for(int z = 0; z < myFlights.size(); z++)
      {
        if(myFlights.get(z).origin == myAirports.get(i).name && myFlights.get(z).dest == clickedAirport)
        {
          numberOfFlightsFromAirportToClickedAirport += 1;
        }
      }
      if(numberOfFlightsFromAirportToClickedAirport > maxValue)
      {
        maxValue = numberOfFlightsFromAirportToClickedAirport;
      }
    }
    return maxValue;
  }
  
  
  
  void draw()
  {
    BarChart bc = new BarChart();
    fill(0);
    rect(100, SCREENY - 30, barChartXAxisLength, 10);
    rect(100, SCREENY - 30, 10, barChartYAxisLength);
    int point = 0;
    int difference = barChartXAxisLength / 130;
    text("0", 50, SCREENY - 30);
    point += difference;
    for(int i = 0; i < myAirports.size(); i++)
    {
      textSize(10);
      text(myAirports.get(i).name, point, SCREENY + 25);
      point += difference;
    }
    int maxValue = bc.findMaxValue(myAirports, myFlights);
    int valueOnY = maxValue / 10;
    int differenceInValue = maxValue / 10;
    int positionOnY = barChartYAxisLength / 10;
    int differenceInPosition = barChartYAxisLength / 10;
    int xPosition = 50;
    while(valueOnY <= maxValue)
    {
      String valueOnYAxis = String.valueOf(valueOnY);
      text(valueOnYAxis, xPosition, positionOnY);
      valueOnY += differenceInValue;
      positionOnY += differenceInPosition;
    }                                               // so far this draws the axes of the bar chart with according max value on y and all airport names on x 
    
    
    String clickedAirport = bc.findClickedAirport(myAirports);
    point = 0;
    point += difference;
    int widthOfBar = 20;
    for(int i = 0; i < myAirports.size(); i++)
    {
      int numberOfFlightsFromAirportToClickedAirport = 0;
      for(int z = 0; z < myFlights.size(); z++)
      {
        if(myFlights.get(z).dest == clickedAirport && myFlights.get(z).origin == myAirports.get(i).name)
        {
          numberOfFlightsFromAirportToClickedAirport += 1;
        }
      }
      rect(point, numberOfFlightsFromAirportToClickedAirport, 20, numberOfFlightsFromAirportToClickedAirport); 
      point += difference;           // now have number of times a flight from a certain airport goes to the clicked airport now just have to use that value in the rectangle constructor
    }
  }
  
  
  
  
  
  
  
  
}
