# Mastermind

[Mastermind](https://en.wikipedia.org/wiki/Mastermind_(board_game)) or Master Mind is a code-breaking game for two players. The modern game, which is usually played with pegs, was invented in 1970 by Mordecai Meirowitz, 
an Israeli postmaster and telecommunications expert.

In this version, the colored pegs are represented by numbers 1-6.

## Rules

1. The codemaker can set the code to any possible combination of four numbers, including duplicates.
2. The codebreaker gets twelve attempts at breaking the code.
3. After each guess, the codebreaker will receive feedback like so:

   X O  -  -
   
   The O indicates one guess is correct but in the wrong position, while the X
   represents a guess that is both correct AND in the correct position.
   Each wrong guess is represented by -. The position of the feedback does not
   necessarily correlate with its position in the guess.
4. To avoid cheating, if you chose to be the codemaker, you will
   not be able to give feedback - it will happen automatically.
   
## Repl.it

Try my version here: [repl.it](https://replit.com/@kirasupernova/Mastermind?v=1)!
