#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

MAX=1000
MIN=1

RANDOM_NUMBER=$(($RANDOM%($MAX-$MIN)+$MIN))
echo $RANDOM_NUMBER

echo -e "\nEnter your username:"
read USER_NAME

USER_LIST_RESULT=$($PSQL "SELECT username FROM players WHERE username = '$USER_NAME' " )

if [[ -z $USER_LIST_RESULT ]]
then
  #if not found
  echo -e "\nWelcome, $USER_NAME! It looks like this is your first time here."
  echo -e "\nGuess the secret number between 1 and 100:"
else
  #if found
  echo -e "\nWelcome back, $USER_LIST_RESULT! You have played <games_played> games, and your best game took <best_game> guesses"
  echo -e "\nGuess the secret number between 1 and 100:"
fi
read PLAYER_GUESS