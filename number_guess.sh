#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess --tuples-only -c"

MAX=1000
MIN=1

SECRET_NUMBER=$(($RANDOM%($MAX-$MIN)+$MIN))
echo $SECRET_NUMBER

echo -e "\nEnter your username:"
read USER_NAME

USER_LIST_RESULT=$($PSQL "SELECT username FROM players WHERE username = '$USER_NAME' " )

if [[ -z $USER_LIST_RESULT ]]
then
  #if not found
  echo -e "\nWelcome, <username>! It looks like this is your first time here."
else
  #if found
  echo -e "\nWelcome back, $USER_LIST_RESULT! You have played <games_played> games, and your best game took <best_game> guesses"
  echo -e "\nGuess the secret number between 1 and 1000:"
fi
read PLAYER_GUESS

if [[ $PLAYER_GUESS =~ ^[0-9]+$ ]]
then
  
  #When the guess is higher
  if [[ $PLAYER_GUESS > $SECRET_NUMBER ]]
  then
    echo -e "\nIt's lower than that, guess again:"
  fi
done

#Save game info. 
PLAYER_ID=$($PSQL "SELECT player_id FROM players WHERE username = '$USER_NAME'")

INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(player_id, guesses) VALUES($PLAYER_ID, $TRYS)" )
