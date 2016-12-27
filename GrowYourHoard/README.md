Partial Port of https://github.com/jrdoughty/GrowYourHoard for the purposes of learning more about Kha and Kha2d.

Things to know:
I created a bunch of helper classes through out this and my many other examples. The helpers include
Text: Simple class that creates a text string on screen. All it requires is a string and it will render it in the top right, so long as you have the font in your assets of course! Text features static clearing functions to help clean up the scene.
Button and Button Manager: Relatively simple button class that came originally from the Grow Your Hoard project. Button Manager Runs all of the buttons and takes clicks, making them trigger delegate functions

The bulk of the Scene code belongs to the states. I began with a simple interface with a init, update, and kill functions, but created a base state that cleared Kha2d's Scene, All of the Text, and All of the Buttons. Working with the scenes is relatively simple. You call the 'Project.the' singleton and tell it to change to the state you want to be in by passing a state object. A scene manager was never needed since the change state was really all that was needed

Main Take Aways:
Kha is very easy to use for being as low level as it is.
Kha2d is a great simple 2d engine. It does almost everything i need it to, and its simple enough that I can read it without needing to take calculous. Its biggest 'failing' is it doesn't incorporate font rendering into it. Other than having to layer simple font renders over the game, I felt like I got the best parts of Grow Your Hoard ported with minimal effort despite the fact that Grow Your Hoard came from a much more robust and mature engine.
Verlet is a really cool physics engine. It didn't do alot of things for me that nape/haxeflixel handled for me, so working with it was fun to emulate all of the things that made arrows flying work in the old version of this game.


Over all, I'm pretty happy with this. I didn't finish the knight or the double tap functionaility because I felt the game was solid as is, and the knight in particular didn't work well in the original game. Everything that made the game fun the first time is here, and that is what matters most.

Libraries:
Kha2d
VerletKha
