#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo -e "\nEnter your username:"
read USER_NAME

USER_LIST_RESULT=$($PSQL "SELECT username FROM players WHERE username = '$USER_NAME' " )

if [[ -z $USER_LIST_RESULT ]]
then
  #if not found
  echo -e "\nWelcome, <username>! It looks like this is your first time here."
else
  #if found
  echo -e "\nWelcome back, <username>! You have played <games_played> games, and your best game took <best_game> guesses"
fi