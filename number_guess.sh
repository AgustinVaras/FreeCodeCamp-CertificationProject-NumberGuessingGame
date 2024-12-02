#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo -e "\nEnter your username:"
read USER_NAME

#if not found
echo -e "\nWelcome, <username>! It looks like this is your first time here."

#if found
echo -e "\nWelcome back, <username>! You have played <games_played> games, and your best game took <best_game> guesses"
