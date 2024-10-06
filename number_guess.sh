#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
SECRET_NUMBER=$((RANDOM % 1000 +1))
echo "Enter your username:"
read USERNAME

NAME=$($PSQL "SELECT min(username) from user_stories WHERE username='$USERNAME'"  | xargs )
GAMES_PLAYED=$($PSQL "SELECT sum(games_played) from user_stories WHERE username='$USERNAME'")
BEST_GAME=$($PSQL "SELECT min(best_game) from user_stories WHERE username='$USERNAME'")



if [[ -z $GAMES_PLAYED ]]; then
    GAMES_PLAYED=0
fi

if [[ -z $BEST_GAME ]]; then
    BEST_GAME=0
fi

#echo "$NAME und EINGABE $USERNAME und die SECRET_Nummer $NUMBER und die gespielten spiele $GAMES_PLAYED und bestes Spiel $BEST_GAME"

if [[ -z $NAME ]]; then
  echo "Welcome, $USERNAME! It looks like this is your first time here."

else
  echo "Welcome back, $NAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi
echo $SECRET_NUMBER
echo "Guess the secret number between 1 and 1000:"
read GUESS
count=0
if [[ $GUESS == $SECRET_NUMBER ]];then
  count=$((count+1))
  echo "You guessed it in $count tries. The secret number was $SECRET_NUMBER."
elif [[ $GUESS >= $SECRET_NUMBER ]];then
 echo "worng"
fi
