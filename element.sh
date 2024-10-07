#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# Function to process the query for atomic number
PROCESS_NUMBER_QUERY() {
  ATOMIC_NUMBER=$1
  ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
  ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
  TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $TYPE_ID")
  ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  OUTPUT_STRING="The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  echo $OUTPUT_STRING
}

# Function to process the query for element symbol
PROCESS_SYMBOL_QUERY() {
  ELEMENT_SYMBOL=$1
  ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE symbol = '$ELEMENT_SYMBOL'")
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$ELEMENT_SYMBOL'")
  TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $TYPE_ID")
  ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  OUTPUT_STRING="The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  echo $OUTPUT_STRING
}

# Function to process the query for element name
PROCESS_NAME_QUERY() {
  ELEMENT_NAME=$1
  ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name = '$ELEMENT_NAME'")
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$ELEMENT_NAME'")
  TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $TYPE_ID")
  ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  OUTPUT_STRING="The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  echo $OUTPUT_STRING
}

# Check if arg1 is present
if [[ -z "$1" ]]; then
  echo "Please provide an element as an argument."
  exit 
fi

# Check if arg1 is an integer
if [[ $1 =~ ^-?[0-9]+$ ]]; then
  ATOMIC_NUMBER=$1
  ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
  if [[ -z $ELEMENT_NAME ]]; then
    echo "I could not find that element in the database."
  else
    PROCESS_NUMBER_QUERY $ATOMIC_NUMBER
  fi

# Check if $1 is a single or two-letter chemical element symbol
elif [[ $1 =~ ^[A-Za-z]{1,2}$ ]]; then
  ELEMENT_SYMBOL=$1
  ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE symbol = '$ELEMENT_SYMBOL'")
  if [[ -z $ELEMENT_NAME ]]; then
    echo "I could not find that element in the database."
  else
    PROCESS_SYMBOL_QUERY $ELEMENT_SYMBOL
  fi

# Check if $1 is the name of a chemical element
else
  ELEMENT_NAME=$1
  ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name = '$ELEMENT_NAME'")
  if [[ -z $ELEMENT_SYMBOL ]]; then
    echo "I could not find that element in the database."
  else
    PROCESS_NAME_QUERY $ELEMENT_NAME
  fi
fi

