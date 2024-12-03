#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess --tuples-only -c"

MAX=1000
MIN=1

SECRET_NUMBER=$(($RANDOM%($MAX-$MIN)+$MIN))

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
read PLAYER_GUESS
