/**
 * Created on 4/16/2016.
 * Class made to represent a scrabble tile.
 * Contains a letter and value for it
 * @author Ben Rasmussen
 */
public class Tile {
    private String letter;
    private int value;

    public Tile(String letter, int value) {
        this.letter = letter;
        this.value = value;
    }

    public Tile(Tile copy) {
        this.letter = copy.getLetter();
        this.value = copy.getValue();
    }

    public String getLetter() {
        return letter;
    }

    public int getValue() {
        return value;
    }

    @Override
    public String toString() {
        return "Tile{" +
                "letter='" + letter + '\'' +
                ", value=" + value +
                '}';
    }
}
