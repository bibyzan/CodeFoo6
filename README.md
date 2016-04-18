# CodeFoo6

This repo contains 2 projects:
	A scrabble hand optimizer made in jave
	A native iphone app that pulls a list of articles and videos and displays them

The Scrabble project:
I made using intellij 14 on windows in java 8, however it should work on mac and linux (not tested)

The project is command line only but you can either choose to generate a random hand of 7 tiles, or input your own hand to optimize.

The output should look something like this:
	Scrabble optimizer!
	Would you like to:
		1: Enter a bag of tiles to use
		2: Generate a bag
	Enter choice: 
	2
	EZTPESY
	Possible words from this set of tiles: 
		espy
		yet
		zees
		zest
		zesty
		more possible words not shown (in this readme)...
	The highest scoring word is: zesty = 17 points
	Would you like to run again? (y/n)
	n

	Process finished with exit code 0
The IOS app:
	I developed it in xcode 7.2.1 for OSX in swift 2

	The app pulls a list of Articles and videos then displays them in a UIListView

	You can then tap on any of the articles or videos and it will display them in a webview within the app

	I have tested it on iphone 4, 5, 6, and 6 plus and it formats correctly on all of them

	However, this is ONLY for iphone. When observing this project in main.storyboard, you have to:
		Click on the bottom of the storyboard builder where it says wAny hAny,
		Select the layout for all iphones in portrait,
		It should now say wCompact hRegular and everything will look right!