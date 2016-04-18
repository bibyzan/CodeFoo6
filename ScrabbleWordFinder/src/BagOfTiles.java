
import java.io.File;
import java.util.*;

/**
 * Created by Ben on 4/16/2016.
 */
public class BagOfTiles extends ArrayList<Tile> {
    public static HashMap<String, Integer> letterValues;

    public BagOfTiles() {
        super();

        letterValues = new HashMap<>();

        //fill bag of tiles by reading a file with the format [amount of tiles] [letter] [value]
        try {
            Scanner fileReader = new Scanner(new File("scrabblevalues.txt"));

            while (fileReader.hasNext()) {
                String[] currentLine = fileReader.nextLine().split(" ");

                int tileValue = Integer.parseInt(currentLine[2]);
                String letter = currentLine[1];
                letterValues.put(letter, tileValue);

                int amountOfTiles = Integer.parseInt(currentLine[0]);
                for (int i = 0; i < amountOfTiles; i++)
                    super.add(new Tile(letter, tileValue));

            }
        } catch (Exception e) {
            System.out.println("scrabblevalues.txt is missing from the current directory.");
        }
    }

    public void shuffle() {
        Collections.shuffle(this);
    }

    @Override
    public String toString() {
        String str = "BagOfTiles{\n";

        for (Tile tile: this)
            str += "\t" + tile.toString() + "\n";

        return str + "}";
    }
}
