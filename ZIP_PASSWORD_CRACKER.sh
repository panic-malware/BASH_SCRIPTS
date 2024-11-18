#!/bin/bash

loading_animation() {
    local duration=$1
    local end=$((SECONDS+duration))
    
    while [ $SECONDS -lt $end ]; do
        for i in . .. ...; do
            printf "\rLoading$i"
            sleep 0.5
        done
    done
    printf "\r" 
}

loading_animation 5
sleep 3

echo "    XXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 XXXXXXXXXXXXXXXXXX         XXXXXXXX
XXXXXXXXXXXXXXXX              XXXXXXX
XXXXXXXXXXXXX                   XXXXX
 XXX     _________ _________     XXX     
  XX    |  PANIC  | MALWARE |    XX        
 ( X----I         I         I----X )          
( +I    I         I         I    I+ )
 ( I    I         I         I    I )
  (I    I______ /   \_______I    I)
   I           ( ___ )           I
   I    _  :::::::::::::::  _    I
    \    \___ ::::::::: ___/    /
     \_      \_________/      _/
       \        \___,        /
         \                 /
          |\             /|
          |  \_________/| "
		  
pyfiglet --color RED "ZIP_CRACKER"
sleep 0.5
GET_ZIP_LOCA() {
echo "ENTER THE ZIP-LOCATION"
read "LOCA_ONE"
if [[ -f "$LOCA_ONE" && "$LOCA_ONE" == *.zip ]] 
   then
	echo "ZIP FOUND"
   else
	echo "INVALID, RUN $0 AGAIN"
	GET_ZIP_LOCA
fi
}
GET_WORDLIST_LOCA() {
echo "ENTER THE WORDLIST-LOCATION"
read "LOCA_TWO"
if [[ -f "$LOCA_TWO" && "$LOCA_TWO" == *.txt ]]
   then
       echo "WORDLIST FOUND"
   else
       echo "INVALID, RUN $0 AGAIN"
       GET_WORDLIST_LOCA
fi
}

GET_ZIP_LOCA
GET_WORDLIST_LOCA

while true; do
echo ""
echo -e "YOUR ZIP TO CRACK => $LOCA_ONE \nYOUR WORDLIST TO CRACK => $LOCA_TWO"
sleep 0.5
echo ""
echo "WHAT DO YOU WANT TO DO? (proceed/change_zip/change_wordlist/exit)"
read "RESPONSE"
 case $RESPONSE in
    [Pp][Rr][Oo][Cc][Ee][Ee][Dd])
        sleep 0.3
        echo "Starting the cracking process..."
        while IFS= read -r password
	    do
		   echo "TRYING_PASSWORD:$password"
		   sleep 0.1
		   unzip -P "$password" -tq "$LOCA_ONE" >/dev/null 2>&1
	     	    	if [[ $? -eq 0 ]]
		    		then
				echo "PASSWORD FOUND : $password"
				exit 0
	    	    	fi		
	    done < "$LOCA_TWO"
	
	break # Exit loop after proceeding
        ;;
    [Cc][Hh][Aa][Nn][Gg][Ee]_[Zz][Ii][Pp])
        sleep 0.3
        echo " "
	GET_ZIP_LOCA
        ;;
    [Cc][Hh][Aa][Nn][Gg][Ee]_[Ww][Oo][Rr][Dd][Ll][Ii][Ss][Tt])
        sleep 0.3
	echo " "
        GET_WORDLIST_LOCA
        ;;
    [Ee][Xx][Ii][Tt])
        sleep 0.3
        echo " "
	echo "Exiting the script. Goodbye!"
        exit 0
	;;
 esac
done
