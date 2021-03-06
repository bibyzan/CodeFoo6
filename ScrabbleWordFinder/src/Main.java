import java.io.File;
import java.util.ArrayList;
import java.util.Scanner;

/**
 * Created on 4/16/2016.
 * Test runner class for scrabble optimizer. This
 * is where the use interacts with the program and cheats in scrabble.
 * @author Ben Rasmussen
 */
public class Main {
    //Storage for the games dictionary
    public static ArrayList<String> dictionary;

    public static void main(String[] args) {
        //fill dictionary and initialize bag
        fillDictionary();
        BagOfTiles tileBag = new BagOfTiles();
        tileBag.shuffle();
        Scanner inputReader = new Scanner(System.in);

        //run as many times as the user wants
        char runAgain = 'y';
        while (runAgain == 'y' || runAgain == 'Y') {
            tileBag.shuffle();
            ArrayList<Tile> hand = new ArrayList<>();

            System.out.println("Scrabble optimizer!");
            System.out.println("Would you like to:");
            System.out.println("\t1: Enter a bag of tiles to use");
            System.out.println("\t2: Generate a bag");
            System.out.println("Enter choice: ");

            int choice = Integer.parseInt(inputReader.nextLine());

            switch (choice) {
                case 1:
                    System.out.println("Enter the letters to the bag you want to use: ");
                    for (char letterInBag: inputReader.nextLine().toCharArray()) {
                        String strLetterInBag = String.valueOf(letterInBag).toUpperCase();
                        hand.add(new Tile(strLetterInBag, BagOfTiles.letterValues.get(strLetterInBag)));
                    }
                    ScrabbleOptimizer.findHighestScoringWordWithOutput(hand);
                    break;
                case 2:
                    for (int i = 0; i < 7; i++)
                        hand.add(tileBag.get(i));

                    ScrabbleOptimizer.findHighestScoringWordWithOutput(hand);
                    break;
                default:
                    System.out.println("Please enter a valid input");
            }

            System.out.println("Would you like to run again? (y/n)");
            runAgain = inputReader.nextLine().toCharArray()[0];
        }
    }

    //fill dictionary arraylist from dictionary.txt
    public static void fillDictionary() {
        dictionary = new ArrayList<>();

        try {
            Scanner fileReader = new Scanner(new File("dictionary.txt"));

            while (fileReader.hasNext())
                dictionary.add(fileReader.nextLine());
        } catch (Exception e) {
            System.out.println("dictionary.txt is missing");
        }
    }
}
