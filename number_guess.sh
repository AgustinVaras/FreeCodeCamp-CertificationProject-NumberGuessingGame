#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"

echo -e "\nEnter your username:"
READ USER_NAME

#if found
echo -e "\nWelcome back, <username>! You have played <games_played> games, and your best game took <best_game> guesses"
