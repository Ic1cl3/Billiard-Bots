Welcome to the Billard Bots general bot template!

Section 1: File Descriptions
 - README.txt: Info text file with all information needed to begin creating a bot for "Billiard Bots."
 - tempIn.json: File for storing temporary data which is read by the bot and written by the Billiard Bots program.
 - tempOut.json: File for storing temporary data which is read by the Billiard Bots program and written by the bot.

Section 2: Game Description
 In this game, one ball (controlled either by human or bot) will fight against another identical ball by rolling around and knocking into eachother.
 If whacked out of the arena's edges, a ball loses that round.
 The arena is a circle of radius 256px and center at (576, 324).
 Each ball is a circular physics object of radius 25px, movement force 100n, friction coefficient 15, mass 500g, and bounciness 4.
 Each bot will begin positioned exactly accross from its opponent, 156px from the center of the arena.
 A random "wind" force is applied to each ball with a strength of 5n in a random direction to keep each battle from being identical.
 After 50 seconds of play, if no one has won, a 10 second timer will apear on the screen. If this expires, the game is a draw.
 If both balls exit the arena on the same frame, the game is a draw.
 In the event that a bot fails during a game, its inputs will simply not be updated.
 If communication with a bot fails at any point, the bot's input will be replaced by pointing them in the direction that would have been towards their opponent at the start of the game (strait ahead).
 When prompted to load your bot in the program, select the directory with your primary bot file.
 A bot sends exactly one value as input:
     - direction (float) - The angle measure, in degrees which the bot should point towards as it moves.
 A bot can receive exactly 10 different properties from the program:
     - action (bool) - True only if the game is actively taking place.
     - opponentDirection (float) - Direction their opponent is facing, in degrees.
     - opponentPositionX and opponentPositionY (floats) - Opponent's X and Y position respectively.
     - opponentVelocityX and opponentVelocityY (floats) - Opponent's X and Y linear velocities respectively.
     - positionX and positionY (floats) - Bot's X and Y position respectively.
     - velocityX and velocityY (floats) - Bot's X and Y linear velocities respectively.

Section 3: Creating Bots
 In whatever language you choose, you will need to create a script which can accomplish three tasks in order to successfully create a bot:
     - Read tempIn.json
     - Process data while running
     - Write to tempOut.json
 When reading tempIn.json, you should will receive a dictionary with the exact 10 properties listing above. You should never write to tempIn.json.
 Due to windows not allowing two programs to begin accessing the same file at the same time, you may happen to receive a null value when parsing the json. You will need to account for this when fetching data so you do not feed your bot null data.
 You can use the data received from tempIn.json to determine what direction your bot should move.
 In order to update the direction your bot should be moving, you can write a dictionary to tempOut.json with only the above described "direction" property.