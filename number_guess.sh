#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess --tuples-only -c"

MAX=1000
MIN=1

SECRET_NUMBER=$(($RANDOM%($MAX-$MIN)+$MIN))
# echo $SECRET_NUMBER

echo -e "\nEnter your username:"
read USER_NAME

USER_LIST_RESULT=$($PSQL "
  SELECT 
    username,
    (
      SELECT
        COUNT(*)
      FROM
        games g
      INNER JOIN
        players p
      USING(player_id)
      WHERE
        p.username = '$USER_NAME'
    ) AS games_count,
    (
      SELECT
        MIN(g.guesses)
      FROM
        games g
      INNER JOIN
        players p
      USING(player_id)
      WHERE
        p.username = '$USER_NAME'
    ) AS best_game
  FROM
    players
  WHERE
    username = '$USER_NAME' 
" )

if [[ -z $USER_LIST_RESULT ]]
then
  #if not found
  echo -e "\nWelcome, $USER_NAME! It looks like this is your first time here."
  #if the user is a new player we generate a new row in the db to later track his games
  NEW_PLAYER_INSERT_RESULT=$($PSQL "INSERT INTO players(username) VALUES('$USER_NAME')" )

  if [[ $NEW_PLAYER_INSERT_RESULT != 'INSERT 0 1' ]]
  then
    echo -e "\nError, couldn't generate new player entry"
    exit 128
  fi

  echo -e "\nGuess the secret number between 1 and 100:"
else
  #if found
  echo $USER_LIST_RESULT | while read USERNAME BAR GAMES_COUNT BAR BEST_GAME
  do
    echo "Welcome back, $USERNAME! You have played $GAMES_COUNT games, and your best game took $BEST_GAME guesses."
  done
  echo -e "\nGuess the secret number between 1 and 1000:"
fi

TRYS=0;

while [[ $PLAYER_GUESS != $SECRET_NUMBER ]]
do
  (( TRYS++ ))
  # echo -e "\nTrys: $TRYS"
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

    # if [[ $PLAYER_GUESS == $SECRET_NUMBER ]] 
    # then
      
    # fi
  else
    echo -e "\nThat is not an integer, guess again:"
  fi
done

#Save game info. 
PLAYER_ID=$($PSQL "SELECT player_id FROM players WHERE username = '$USER_NAME'")

INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(player_id, guesses) VALUES($PLAYER_ID, $TRYS)" )
echo "You guessed it in $TRYS tries. The secret number was $SECRET_NUMBER. Nice job!"
