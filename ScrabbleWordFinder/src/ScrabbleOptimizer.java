import java.util.ArrayList;

/**
 * Created on 4/16/2016.
 * This class contains all the methods necessary to finding the highest
 * scoring word from a set of scrabble tiles
 * @author Ben Rasmussen
 */
public class ScrabbleOptimizer {
    /**
     * This method is a culmination of all the ones contained below that finds the highest scoring word
     * and outputs the results of its findings as it goes so the user knows what's happening
     * @param tiles list of tiles to find the best word from
     */
    public static void findHighestScoringWordWithOutput(ArrayList<Tile> tiles) {
        String str = "";
        //print the current list of tiles
        for (Tile tile: tiles)
            str += tile.getLetter();
        System.out.println(str);

        //find all the words that are possible from these tiles
        ArrayList<String> possibleWords = possibleWordsFromTiles(tiles);

        //case if now words can be made
        if (possibleWords.size() == 0) {
            System.out.println("There are no possible words from these tiles");
        } else {
            System.out.println("Possible words from this set of tiles: ");
            for (String word : possibleWords)
                System.out.println("\t" + word);

            //find highest scoring word
            String optimalWord = highestScoringWord(possibleWords);
            System.out.println("The highest scoring word is: " + optimalWord + " = " + scoreWord(optimalWord) + " points");
        }
    }

    /**
     * Takes an array of strings and finds which one would score the highest
     * @param wordList list of words to test
     * @return the highest scoring word
     */
    public static String highestScoringWord(ArrayList<String> wordList) {
        String optimalWord = "";
        int optimalScore = 0;

        //loop through all the words and score them testing to see which one is the highest
        for (String currentWord: wordList) {
            int currentWordScore = scoreWord(currentWord);
            if (optimalScore < currentWordScore) {
                optimalScore = currentWordScore;
                optimalWord = currentWord;
            }
        }

        return optimalWord;
    }

    /**
     * Finds all the words that are possible from a list of tiles
     * @param tiles list of tiles to find words for
     * @return a list of words that can be made from the tiles
     */
    public static ArrayList<String> possibleWordsFromTiles(ArrayList<Tile> tiles) {
        ArrayList<String> words = new ArrayList<>();

        //use the local dictionary.txt as a reference to testing if its a word
        for (String dictionaryWord: Main.dictionary)
            if (canMakeWord(tiles, dictionaryWord))
                words.add(dictionaryWord);

        return words;
    }

    /**
     * This method tests if it is possible to make a word from a hand of tiles
     * @param tiles to see if they can make the word
     * @param word a string to test if the word can be made from the tiles
     * @return if the word can be made from the tiles
     */
    public static boolean canMakeWord(ArrayList<Tile> tiles, String word) {
        ArrayList<Tile> tempList = new ArrayList<>(tiles);

        for (char letter: word.toCharArray()) {
            boolean listHasLetter = false;
            for (int i = 0; i < tempList.size(); i++) {
                if (tempList.get(i).getLetter().equals(String.valueOf(letter).toUpperCase())) {
                    tempList.remove(i);
                    listHasLetter = true;
                    break;
                }
            }

            if (!listHasLetter)
                return false;
        }

        return true;
    }

    /**
     * Find how many points in scrabble can be made from a word
     * @param word string to test how many points would be awarded for it
     * @return how many points in scrabble you would get from that word
     */
    public static int scoreWord(String word) {
        int score = 0;

        for (char letter: word.toCharArray())
            score += BagOfTiles.letterValues.get(String.valueOf(letter).toUpperCase());

        return score;
    }
}
