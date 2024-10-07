#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
SECRET_NUMBER=$((RANDOM % 1000 +1))
echo "Enter your username:"
read USERNAME
USERNAME=${USERNAME:0:22}

USER_INFO=$($PSQL "SELECT username, games_played, best_game FROM user_stories WHERE username='$USERNAME'")

GAMES_PLAYED=$(echo $USER_INFO | cut -d '|' -f2)
BEST_GAME=$(echo $USER_INFO | cut -d '|' -f3)

COUNT=0


# if [[ -z $GAMES_PLAYED ]]; then
#     GAMES_PLAYED=0
# fi

# if [[ -z $BEST_GAME ]]; then
#     BEST_GAME=0
# fi

if [[ -z $GAMES_PLAYED ]]; then
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  
    NEUER_SPIELER=$($PSQL "INSERT INTO user_stories(username, games_played, best_game) VALUES ( '$USERNAME', 0, NULL)")
  
else
  
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  
fi


echo "Guess the secret number between 1 and 1000:"
while true;do
  read GUESS
  
  if [[ ! $GUESS =~ ^[0-9]+$ ]];then
    echo "That is not an integer, guess again:"
  else
    COUNT=$((COUNT + 1))
    if [[ $GUESS -lt $SECRET_NUMBER ]];then
      echo "It's higher than that, guess again:"
    elif [[ $GUESS -gt $SECRET_NUMBER ]];then
      echo "It's lower than that, guess again:"
  
    
    else
      echo "You guessed it in $COUNT tries. The secret number was $SECRET_NUMBER. Nice job!"

      GAMES_PLAYED=$((GAMES_PLAYED + 1))

      if [[ -z $BEST_GAME || $COUNT -lt $BEST_GAME ]]; then
      BEST_GAME=$COUNT
      fi

      UPDATE_RESULTS=$($PSQL "UPDATE user_stories SET games_played=$GAMES_PLAYED, best_game=$BEST_GAME WHERE username='$USERNAME'")
    
      break
    fi
  fi
done

