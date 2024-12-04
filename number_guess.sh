#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

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
  echo -e "\nWelcome, $USER_NAME! It looks like this is your first time here."
  echo -e "\nGuess the secret number between 1 and 100:"
else
  #if found
  echo -e "\nWelcome back, $USER_LIST_RESULT! You have played <games_played> games, and your best game took <best_game> guesses"
  echo -e "\nGuess the secret number between 1 and 1000:"
fi

TRYS=0;

while [[ $PLAYER_GUESS != $SECRET_NUMBER ]]
do
  (( TRYS++ ))
  echo -e "\nTrys: $TRYS"
  read PLAYER_GUESS

  if [[ $PLAYER_GUESS =~ ^[0-9]+$ ]]
  then
    
    #When the guess is higher
    if [[ $PLAYER_GUESS > $SECRET_NUMBER ]]
    then
      echo -e "\nIt's lower than that, guess again:"
    fi
    
    #When the guess is lower
    if [[ $PLAYER_GUESS < $SECRET_NUMBER ]]
    then
      echo -e "\nIt's higher than that, guess again:"
    fi

    if [[ $PLAYER_GUESS == $SECRET_NUMBER ]] 
    then
      echo -e "\nYou guessed it in $TRYS tries. The secret number was $SECRET_NUMBER. Nice job!"
    fi
  fi
done