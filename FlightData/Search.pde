class Search {
  String dataReturned ="";
  String typeBar = "|";

  boolean alreadyRun=true;
  void searchTyping() {
    if (key==CODED) {
      alreadyRun=false;
      if (keyCode==LEFT) {
        println ("left");
      } // if
      /*else {
       // message
       println ("unknown special key");
       alreadyRun=true;
       } // else*/
    } // if
    else
    {
      if (key==BACKSPACE) {
        if (text1.length()>0) {
          text1=text1.substring(0, text1.length()-1);
        } // if
      } // if
      else if (key==RETURN || key==ENTER) {
        boolean gotFlight = false;
        for (int i =0; i< myFlights.size(); i++) {
          Flight currentFlight = myFlights.get(i);
          String currentFlightNumber = currentFlight.getFlightNumber();
          if (currentFlightNumber.equals(text1)) {
              dataReturned = "Flight Number: " + text1 + "\nOrigin Airport Code: " + currentFlight.getOrigin() +
              "\nStatus: " + currentFlight.getStatus() +
                "\nDestination Airport Code: " + currentFlight.getDest() +
                "\nDate of Departure: " + currentFlight.getFlightDate() +
                "\nEstimated Departure Time: " + depArrTimeFormatter(currentFlight.getEstimatedDepartureTime()) +
                "\nEstimated Arrival Time: " + depArrTimeFormatter(currentFlight.getEstimatedArrivalTime()) +
                "\nActual Departure Time: " + depArrTimeFormatter(currentFlight.getDepartureTime())
                + "\nActual Arrival Time: " + depArrTimeFormatter(currentFlight.getArrivalTime())  +
                "\nDeparture City: " + currentFlight.getCityName() + 
                "\nArrival City: " + currentFlight.getArrivalCityName()+
                "\nDistance: " + currentFlight.getDistance() + " miles" ;
              gotFlight = true;
            
          }
        }
        println ("ENTER");
        if (gotFlight==true) {
          println("Found");
          text1="";
          alreadyRun=true;
        } // if
        else {
          dataReturned= "Flight not found. Please try again.\nAirline carrier prefixes supported include:\nAA, AS, B6, DL, F9, G4, HA, NK, UA, WN. ";
          text1="";
          alreadyRun=true;
        }
      } // else if
      else {
        text1+=key; //<>//
      } // else
      // output
    } // else
  } // func
  
  void flashingTypingYoke(){
    float s = second()%2;
    if(s==0)
    {float barDist = (text1.length()*12)-1.5;
    text(typeBar, 166 + barDist, 47);}
  }
  
  String depArrTimeFormatter(String time){
    if(time==null){
      return "N/A";
    }
    try{ //<>//
    String[] timeSplit = time.split("");
    String toReturn = timeSplit[0] + timeSplit[1] +":" + timeSplit[2] + timeSplit[3];
    return toReturn; }
    catch(ArrayIndexOutOfBoundsException exception){return "N/A";}
  }
  
  void draw() {
    stroke(BLACK);
    rect(150, 25, 210, 30);
    textAlign(LEFT);
    textFont(myFont);
    textSize(20);
    fill(BLACK);
    text(text1, 160, 50);
    text(dataReturned, 150, 80);
    textAlign(CENTER);
    flashingTypingYoke();
  }
}
