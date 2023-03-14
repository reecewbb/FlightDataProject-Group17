import java.util.Scanner;
import java.io.File;

void setup()  {
  try  {
    File myFile = new File("flights2k.csv");
    Scanner input = new Scanner(myFile);
    input.useDelimiter(",");
    while (input.hasNext())
    {
      System.out.println(input.next());
    }
    input.close();
  } catch (Exception e) {System.err.println(e);}
}
