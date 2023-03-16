import java.util.Scanner;
import java.io.File;
import java.util.ArrayList;

void setup()  {
  try  {
    File myFile = new File("flights2k.csv");
    Scanner input = new Scanner(myFile);
    input.useDelimiter("\n");
    int dataIdentifier = 0;
    ArrayList<Flight> myFlights = new ArrayList<Flight>();
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
