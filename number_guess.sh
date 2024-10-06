#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
NUMBER=$((RANDOM % 1000 +1))
echo "Enter your username:"
read USERNAME
NAME=$($PSQL "SELECT username FROM user_stories WHERE username='$USERNAME'" | tr -d '[:space:]')
GAMES_PLAYED=$($PSQL "SELECT sum(games_played) from user_stories WHERE username='$USERNAME'")
BEST_GAME=$($PSQL "SELECT min(best_game) from user_stories WHERE username='$USERNAME'")

if [[ -z $GAMES_PLAYED ]]; then
    GAMES_PLAYED=0
fi

if [[ -z $BEST_GAME ]]; then
    BEST_GAME=0
fi

if [[ -z $NAME ]]; then
echo "Welcome, $USERNAME! It looks like this is your first time here."
else
echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

echo "Guess the secret number between 1 and 1000:"

