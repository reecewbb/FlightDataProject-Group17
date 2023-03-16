import java.util.Scanner;
import java.io.File;
PFont myFont ;

void setup()  {
      size(600,600);
      //background(255);
  try  {
    File myFile = new File("flights2k.csv");
    Scanner input = new Scanner(myFile);
    input.useDelimiter(",");
    int i =0;
    int j = 30;
    while (input.hasNext())
    {  
      String dataLine = input.nextLine();
      text(dataLine, i, j);
      j = j + 20;
      
     /* if(j>=500)
      {int delay = 0;
        while(delay!=10000000)
        {delay = delay + 1;}
        j= 0;
        delay = 0;
        background(255);
      }*/
      
    }
    input.close();
  } catch (Exception e) {System.err.println(e);}

  

  
  
}
