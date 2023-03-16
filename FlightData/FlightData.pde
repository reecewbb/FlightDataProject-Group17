import java.util.Scanner;
import java.io.File;
import java.util.ArrayList;

PFont myFont;
ArrayList<Flight> myFlights = new ArrayList<Flight>();

void setup()  {
  size(700, 700);
  background(0);
  
  try  {
    File myFile = new File("flights2k.csv");
    Scanner input = new Scanner(myFile);
    input.useDelimiter("\n");
    int dataIdentifier = 0;
    input.next();
    while (input.hasNext())
    {
      Flight myFlight = new Flight(dataIdentifier);
      String allData = input.next();
      String[] allDataArray = allData.split("[,]", 0);
      for (int i = 0; i < NUMBER_OF_DATAPOINTS + 1; i++)
      {
        String data = allDataArray[i];
        if (i == 4 || i == 9) 
        {
          data += ", " + allDataArray[i+1]; 
          i++;
        }
        myFlight.setData(data, i);
      }
      myFlights.add(myFlight);
      dataIdentifier++;
    }
    input.close();
  } catch (Exception e) {System.err.println(e);}
  
}

int l = 0;
int j = 20;

void draw()
{
    float delay = 0;
    if (l < myFlights.size())
    {
      myFont=loadFont("Arial-Black-48.vlw");
      textFont(myFont);
      textSize(10);
      String lineOfData = myFlights.get(l).joinData();
      text(lineOfData, 50, j);
      j = j + 20;
      l++;
      while(delay<1000000)  {delay= delay + 0.04;}
      if(j==720)
      {j=20;
      background(0);}
    }

  }
