#!/bin/bash
pyfiglet --color blue "WEB-STATUS"
sleep 0.6
check_status() {
    url=$1
    # Send an HTTP request and extract only the status code
    status_code=$(curl -o /dev/null -s -w "%{http_code}" "$url")

    # Interpret the status code
    case $status_code in
        200)
            echo "$url is UP"
            ;;
        301|302)
            echo "$url is UP (Redirected)"
            ;;
        403)
            echo "$url is DOWN (Forbidden: Access is denied)"
            ;;
        404)
            echo "$url is DOWN (Not Found: The URL does not exist)"
            ;;
        500)
            echo "$url is DOWN (Internal Server Error: Server encountered an error)"
            ;;
        503)
            echo "$url is DOWN (Service Unavailable: Server is temporarily down)"
            ;;
        *)
            echo "$url is DOWN (HTTP Status: $status_code - Unknown Issue)"
            ;;
    esac
}
echo -e "[*] select the option\n1)single website-check\n2)bulk website-check"
echo "You Have Entered"
read option
case $option in 
	1)
	    echo "[*] ENTER URL OF THE WEBSITE"
	    read webone
	    check_status "$webone"
	    ;;
	2)  
	    echo " "
	    echo "[*] please make sure the websites url in your file is in the form of line by line"
	    sleep 0.5
	    echo "[*]ENTER FILE-LOCATION"
	    read location
	    
	    if [ -f "$location" ];
	    then
		while IFS= read -r url;
		do
		     check_status "$url"
		done < "$location"
	    else
       	        echo "[#] File not found.please check the file path and try again."
	    fi
	    ;;	   
        *)
	    echo " "	
	    echo "[#] invalid"
	    echo "[#] please read the instructions from read-me"
	    sleep 0.2
	    echo "[#]quiting"
	    exit 1
esac	
