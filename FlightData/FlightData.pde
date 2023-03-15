import java.util.Scanner;
import java.io.File;
import java.util.ArrayList;

final int NUMBER_OF_DATAPOINTS = 18;

void setup()  {
  try  {
    File myFile = new File("flights2k.csv");
    Scanner input = new Scanner(myFile);
    input.useDelimiter(",");
    int dataID = 0;
    ArrayList<Flight> myFlights = new ArrayList<Flight>();
    while (input.hasNext())
    {
      Flight myFlight = new Flight(int dataID);
      for (int i = 0; i < NUMBER_OF_DATAPOINTS; i++)
      {
        String data = input.next();
        myFlight.setData(String data, int i);
      }
      myFlights.add(myFlight);
      dataID++;
    }
    input.close();
  } catch (Exception e) {System.err.println(e);}
}
