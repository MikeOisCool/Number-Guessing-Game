#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
number=$((RANDOM % 1000 +1))
echo "Enter your username:"
read USERNAME
NAME=$($PSQL "SELECT username from user_stories WHERE username='$USERNAME'")
echo "$NAME und EINGABE $USERNAME und die Nummer $number"
if [[ -z $NAME ]]; then
echo "Welcome, $USERNAME! It looks like this is your first time here."
else
echo "Hallo $NAME, warst schonmal hier"
fi
