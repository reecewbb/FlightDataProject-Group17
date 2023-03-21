class BarChart
{
  int barChartYAxisLength;
  int barChartXAxisLength;
  Airport myAirport;
  
  BarChart()
  {
    
  }
  
  
  public int findMaxValue(ArrayList flights)
  {
    int maxValue = 0;
    for(int i = 0; i < ; i++)  // go through every airport name, for each airport name chcek if that airport name is in the origin data of the flight and if the dest is the airport that was clicked then 
    {                          // increase value by one at end of loop then compare maxValue to value appropriately 
      
    }
  }
  
  
  
  void draw()
  {
    fill(0);
    rect(20, SCREENY + 30, barChartXAxisLength, 10);
    rect(20, SCREENY + 30, 10, barChartYAxisLength);
    float separation = barChartXAxisLength/130;
    for(int i = 0; i < myAirports.size(); i++)
    {
      textSize(10);
      text(myAirports.get(i).name, separation, SCREENY + 25);
      separation *= 2;
      
    }
    
  }
  
  
  
  
  
  
  
  
}
