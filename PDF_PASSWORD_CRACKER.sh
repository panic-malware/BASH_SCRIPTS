#!/bin/bash
cat << 'EOF'


  OOOOOOOOOOOOOOO @@              PANIC_MALWARE          @@ OOOOOOOOOOOOOOOO.
  OOOOOOOOOOOOOOOO @@                                    @@ OOOOOOOOOOOOOOOO
  OOOOOOOOOO'''''' @@                                    @@ ```````OOOOOOOOO
  OOOOO'' aaa@@@@@@@@@@@@@@@@@@@@"""                   """""""""@@aaaa `OOOO
  OOOOO,""""@@@@@@@@@@@@@@""""                                     a@"" OOOA
  OOOOOOOOOoooooo,                                            |OOoooooOOOOOS
  OOOOOOOOOOOOOOOOo,           Who needs a magnifying glass   |OOOOOOOOOOOOC
  OOOOOOOOOOOOOOOOOO           when a brute force does the   ,|OOOOOOOOOOOOI
  OOOOOOOOOOOOOOOOOO @         trick ?                        |OOOOOOOOOOOOOI
  OOOOOOOOOOOOOOOOO'@                                         OOOOOOOOOOOOOOb
  OOOOOOOOOOOOOOO'a'                                         |OOOOOOOOOOOOOy
  OOOOOOOOOOOOOO''                                        aa`OOOOOOOOOOOP
  OOOOOOOOOOOOOOb,..                                      `@aa``OOOOOOOh
  OOOOOOOOOOOOOOOOOOo                                         `@@@aa OOOOo
  OOOOOOOOOOOOOOOOOOO|                                           @@@ OOOOe
  OOOOOOOOOOOOOOOOOOO@                               aaaaaaa       @@',OOOOn
  OOOOOOOOOOOOOOOOOOO@                        aaa@@@@@@@@""        @@ OOOOOi
  OOOOOOOOOO~~ aaaaaa"a                 aaa@@@@@@@@@@""            @@ OOOOOx
  OOOOOO aaaa@"""""""" ""            @@@@@@@@@@@@""               @@@|`OOOO'
  OOOOOOOo`@@a                  aa@@  @@@@@@@""         a@        @@@@ OOOO9
  OOOOOOO'  `@@a               @@a@@   @@""           a@@   a     |@@@ OOOO3
  `OOOO'       `@    aa@@       aaa"""          @a        a@     a@@@',OOOO'"
			    
			       Lets Start The Game 	

EOF
pyfiglet --color green "PDF CRACKER"
sleep 0.5
GET_PDF() {
#FULL PATH IS ESSENTIAL
echo "Enter Your PDF Location"
read PDF_LOCA
if [[ -f "$PDF_LOCA" && "$PDF_LOCA" == *.pdf ]]
then
	sleep 0.1
	echo "PDF FOUND"
else
	echo "PDF NOT FOUND,run $0 again"
	exit 1
fi
}
GET_WORD() {
echo "ENTER Your WORDLISTS Location"
read WORD_LOCA
if [[ -f "$WORD_LOCA" && "$WORD_LOCA" == *.txt ]]
then
	sleep 0.1
	echo "WORDLIST FOUND"
else
	echo "WORDLIST NOT FOUND,run $0 again"
	exit 1
fi
}

GET_PASS() {
  while IFS= read -r PASSWORD; do
    qpdf --password="$PASSWORD" --decrypt "$PDF_LOCA" temp.pdf 2>/dev/null
    if [[ $? -eq 0 ]]; then
      echo "Password found: $PASSWORD"
      rm -f temp.pdf
      exit 0
    else
      echo "Trying password: $PASSWORD"
    fi
  done < "$WORD_LOCA"
  echo "No password matched from the wordlist."
}
GET_CHECK() {
echo -e "YOUR PDF => $PDF_LOCA\nYOUR WORDLIST =>$WORD_LOCA"
echo ""
echo "WHAT DO YOU WANT TO DO? (proceed/change_PDF/change_wordlist/exit)"
read "RESPONSE"
 case $RESPONSE in
    [Pp][Rr][Oo][Cc][Ee][Ee][Dd])
	GET_PASS
        ;;
    [Cc][Hh][Aa][Nn][Gg][Ee]_[Pp][Dd][Ff])
        sleep 0.3
        echo " "
        GET_PDF
        GET_CHECK
	;;
    [Cc][Hh][Aa][Nn][Gg][Ee]_[Ww][Oo][Rr][Dd][Ll][Ii][Ss][Tt])
        sleep 0.3
        echo " "
        GET_WORD
        GET_CHECK
	;;
    [Ee][Xx][Ii][Tt])
        sleep 0.3
        echo " "
        echo "Exiting the script. Goodbye!"
        exit 0
        ;;
 esac
}
GET_PDF
GET_WORD
echo ""
GET_CHECK

