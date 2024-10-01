#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo -e "Welcome to My Salon, how can I help you?\n" 



MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  SERVICES_ID_NAME=$($PSQL "SELECT service_id, name from services")
  echo "$SERVICES_ID_NAME" | while read SERVICE_ID bar NAME
  do
    echo "$SERVICE_ID) $NAME"
  done

  read SERVICE_ID_SELECTED

  case $SERVICE_ID_SELECTED in
    1) CUT_MENU ;;
    2) COLOR_MENU ;;
    3) PERM_MENU ;;
    4) STYLE_MENU ;;
    5) TRIM_MENU ;;
    *) MAIN_MENU "I could not find that service. What would you like today?" ;;
  esac
}

CUT_MENU() {
  echo -e "What's your phone number?"
  read CUSTOMER_PHONE
  CUSTOMER_NAME=$($PSQL "SELECT name from customers WHERE phone='$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER_NAME ]]
  then
     echo -e "\nI don't have a record for that phone number, what's your name?"
     read CUSTOMER_NAME
     CUSTOMER_NEW=$($PSQL "INSERT INTO customers(name, phone) VALUES ('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
     echo -e "\nWhat time would you like your cut, $CUSTOMER_NAME?"
     read SERVICE_TIME
     CUSTOMER_ID=$($PSQL "SELECT customer_id from customers WHERE name='$CUSTOMER_NAME'")
      APPOINTMENT_NEW=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES('$CUSTOMER_ID', 1,'$SERVICE_TIME')")

      echo -e "\nI have put you down for a cut at $SERVICE_TIME, $CUSTOMER_NAME."
    
   
  else
    echo haare schneiden
  fi
}


MAIN_MENU


