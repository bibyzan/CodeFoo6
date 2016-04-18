
import java.io.File;
import java.util.*;

/**
 * Created on 4/16/2016.
 * Class containing an array of tiles to be used in a scrabble game
 * @author Ben Rasmussen
 */
public class BagOfTiles extends ArrayList<Tile> {
    //map reference used for finding points awarded for a letter
    public static HashMap<String, Integer> letterValues;

    /**
     * Constructor for the class, uses a txt file containing letters, their
     * point value, and how many should be in a scrabble bag to fill this arraylist
     */
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

    //randomize bag
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
