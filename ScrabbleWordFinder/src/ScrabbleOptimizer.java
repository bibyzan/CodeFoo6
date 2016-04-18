import java.util.ArrayList;

/**
 * Created by Ben on 4/16/2016.
 */
public class ScrabbleOptimizer {
    public static void findHighestScoringWordWithOutput(ArrayList<Tile> tiles) {
        String str = "";
        for (Tile tile: tiles)
            str += tile.getLetter();
        System.out.println(str);

        ArrayList<String> possibleWords = possibleWordsFromTiles(tiles);

        if (possibleWords.size() == 0) {
            System.out.println("There are no possible words from these tiles");
        } else {
            System.out.println("Possible words from this set of tiles: ");
            for (String word : possibleWords)
                System.out.println("\t" + word);

            String optimalWord = highestScoringWord(possibleWords);
            System.out.println("The highest scoring word is: " + optimalWord + " = " + scoreWord(optimalWord) + " points");
        }
    }

    public static String highestScoringWord(ArrayList<String> wordList) {
        String optimalWord = "";
        int optimalScore = 0;

        for (String currentWord: wordList) {
            int currentWordScore = scoreWord(currentWord);
            if (optimalScore < currentWordScore) {
                optimalScore = currentWordScore;
                optimalWord = currentWord;
            }
        }

        return optimalWord;
    }

    public static ArrayList<String> possibleWordsFromTiles(ArrayList<Tile> tiles) {
        ArrayList<String> words = new ArrayList<>();

        for (String dictionaryWord: Main.dictionary)
            if (canMakeWord(tiles, dictionaryWord))
                words.add(dictionaryWord);

        return words;
    }

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

    public static int scoreWord(String word) {
        int score = 0;

        for (char letter: word.toCharArray())
            score += BagOfTiles.letterValues.get(String.valueOf(letter).toUpperCase());

        return score;
    }
}
