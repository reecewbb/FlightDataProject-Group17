class Flight
{
  int dataIdentifier;
  String flightDate;
  String mktCarrier;
  int mktCarrierFlNum;
  String origin;
  String originCityName;
  String originStateAbr;
  int originWAC;
  String dest;
  String destCityName;
  String destStateAbr;
  int destWAC;
  String crsDepTime;
  String depTime;
  String crsArrTime;
  String arrTime;
  boolean cancelled;
  boolean diverted;
  int distance;
  
  
  Flight(int dataIdentifier)
  {
    this.dataIdentifier = dataIdentifier;
  }
  
  
  
  public void setData(String data, int dataType)
  {
    switch(dataType) //<>//
    {
      case 0:
      this.flightDate = data;
      break;
      
      case 1:
      this.mktCarrier = data;
      break;
      
      case 2:
      this.mktCarrierFlNum = Integer.parseInt(data);
      break;
      
      case 3:
      this.origin = data;
      break;
      
      case 4:
      this.originCityName = data;
      break;
      
      case 5: //<>//
      this.originStateAbr = data;
      break;
      
      case 7:
      this.originWAC = Integer.parseInt(data);
      break;
      
      case 8:
      this.dest = data;
      break;
      
      case 9:
      this.destCityName = data;
      break;
      
      case 11:
      this.destStateAbr = data;
      break;
      
      case 12:
      this.destWAC = Integer.parseInt(data);
      break;
      
      case 13:
      this.crsDepTime = data;
      break;
      
      case 14:
      this.depTime = data;
      break;
      
      case 15:
      this.crsArrTime = data;
      break;
      
      case 16:
      this.arrTime = data;
      break;
      
      case 17:
      if(data == "0")
      {
        this.cancelled = false;
      }
      else
      {
        this.cancelled = true;
      }
      break;
      
      case 18:
      if(data == "0")
      {
        this.diverted = false;
      }
      else
      {
        this.diverted = true;
      }
      break;
      
      case 19:
      this.distance = Integer.parseInt(data);
      break;
      
    }
    
  }
  
  
  
}
