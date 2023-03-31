class Search {
  String dataReturned ="";
  String extraData="";
  String thirdDataString="";
  String fourthDataString="";
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
        int countData=0;
        dataReturned="";
        extraData="";
        String[] flightNoAndDate= text1.split(",");
        boolean gotFlight = false;
        for (int i =0; i< myFlights.size(); i++) {
          //if(gotFlight== true){break;}
          Flight currentFlight = myFlights.get(i);
          String currentFlightNumber = currentFlight.getFlightNumber();
          if (currentFlightNumber.equals(flightNoAndDate[0]) && currentFlight.getFlightDate().equals(flightNoAndDate[1]) && countData<3) {
            countData++;
              dataReturned += "Flight Number: " + flightNoAndDate[0] + "\nOrigin Airport Code: " + currentFlight.getOrigin() +
              "\nStatus: " + currentFlight.getStatus() +
                "\nDestination Airport Code: " + currentFlight.getDest() +
                "\nDate of Departure: " + currentFlight.getFlightDate();
                if(!currentFlight.getStatus().equals("Cancelled")||!currentFlight.getStatus().equals("Diverted")){
                dataReturned += "\nEstimated Departure Time: " + depArrTimeFormatter(currentFlight.getEstimatedDepartureTime()) +
                "\nEstimated Arrival Time: " + depArrTimeFormatter(currentFlight.getEstimatedArrivalTime()) +
                "\nActual Departure Time: " + depArrTimeFormatter(currentFlight.getDepartureTime())
                + "\nActual Arrival Time: " + depArrTimeFormatter(currentFlight.getArrivalTime());};
               dataReturned +="\nDeparture City: " + currentFlight.getCityName() + 
                "\nArrival City: " + currentFlight.getArrivalCityName()+
                "\nDistance: " + currentFlight.getDistance() + " miles\n\n" ;
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
    {float barDist = (text1.length()*12)-4;
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
    text("Enter a flight number followed by the departure date, separated by a comma, in the format DD/MM/YYYY", 380, 50);
    text(text1, 160, 50);
    text(dataReturned, 150, 80);
    //text(extraData, 550, 80);
    //text(thirdDataString, 900, 80);
    //text(fourthDataString,1200, 80);
    textAlign(CENTER);
    flashingTypingYoke();
  }
}
