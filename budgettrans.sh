#!/bin/bash
filename=TransHist.csv
win_file='UTF-8 Unicode (with BOM) text, with CRLF line terminators'

destfile=destfile.csv
#exclude=`sed  s/$/,yes/`
catagory=("transfer" "cashback" "House_Related_Improvements" "Fuel_Parking" "Groceries" "Coffee" "Internet_Shopping" "Meals_Out" "Entertainment" "hair_beauty" "streaming_and_gaming" "Sport_Marc" "Medical_Bills" "misc" "Newsagents_Books" "clothing" "car_reg_licenses" "School" "Alcohol" "Sports_Sebastian" "Pet_Related" "Holidays" "Cash" "Markets" "Jewelery" "car_service" ) #starts at zero not 1 
#eines=`wc -l $1` 
rm $destfile
# chcek that file is in unixformat
#if [ $(file $1 | grep $win_file ) = $win_file ] then  
#	echo "$1 is a Windows based file needs to be converted" 
	dos2unix $1
#else 
#	echo "$1 is a Unix file no conversion needed"
#fi
echo "Transaction Date,Description,Amount,Balance,Catagory,Exclude" >$destfile
while  read -r line; do
case $line in
	## transfer funds
	*"TRANSFER"*|*RTP*)
	echo $line | sed  s/$/,${catagory[0]}/ |  sed s/$/,yes/ >>$destfile
	#echo $line | sed  s/$/,${catagory[0]}/ |  sed s/\"-/\"/ | sed s/$/,yes/ >>$destfile   
	;;	
	*"MFI Bonus"*|*CASHBACK*)
	echo $line | sed  s/$/,${catagory[1]}/ |  sed s/$/,yes/ >>$destfile	
	#echo $line | sed  s/$/,${catagory[1]}/ |  sed s/$/,yes/ >>$destfile  
	;;	
	#household 	
	*"PLINE"*|*"CRAZY PRICE VARIETY"*|*"AP WARWICK POST SHOP"*|*"SPOTLIGHT"*|*"BARBEQUES GALORE"*|*"RED DOT STORES"*|*"JB HI FI"*|*"WATER FILTER FOR FRIDG"*|*"HOUSE WARWICK"*|*"BIG W"*|*IKEA*|*KMART*|*BUNNINGS*|*"HOME SPIRIT"*) 
	echo $line | sed  s/$/,${catagory[2]}/ |  sed s/\"-/\"/ >>$destfile
	;;
	# Fuel parking and car related charges
	*"UNITED PETROLEUM"*|*"SECURE PARKING"*|*"A88868880"*|*"CPP TERRACE ROAD"*|*"WILSON PARKING"*|*"COLES EXPRESS"*|*"SECURE PARKING WOOLS"*|*"SWANCAVE PTY LIMITED"*)  # poarking and fuel
	echo $line | sed s/$/,${catagory[3]}/ |  sed s/\"-/\"/ >>$destfile
	;;
	## groceries and shopping
	*"HOLMESYS BAKEHOUSE PTY"*|*"BARRETTS BAKERY"*|*"LENARDS WARWICK"*|*"CHOPIN PATISSERIE"*|*"FARMER JACKS"*|*"WANNEROO FRESH MKT"*|*"ABHIS BREAD"*|*"SEAFRESH INNALOO"*|*"FIVE SEASONS FRESH "*|*"INNALOO FRESH MARKETS"*|*"THE WORLDS BEST NU"*|*"GARLICIOUS GROWN P"*|*"Karrinyup Seafood"*|*"OCEANLILY PTY LTD"*|*"CLEAN HEALTHY LIVI"*|*"ALLSORTS EUROPE"*|*"T2_AU_POS"*|*"PETSTOCK PTY LTD"*|*"KARRINYUP FRESH PTY"*|*"WARWICK FRESH"*|*"CARINE CUISINE"*|*"THE FRESH MARKETS"*|*"THE BEEF SHED"*|*COLES*|*SPUD*|*WOOLWORTHS*|*ALDI*|*"BAKERS DELIGHT"*|*IGA*|*"DEJAXO ARTISAN BAK Duncraig"*|*"LIQUORICE 881119 DUNCRAIG"*) #used for groceries 
	echo $line | sed s/$/,${catagory[4]}/ |  sed s/\"-/\"/ >>$destfile
	;;	
	#Sunday market  
	*"SQ *COLLIE BLUEBERRY"*|*"SQ *KALAMUNDA AND STIR"*|*"ZLR*CLAREMONT"*|*"GMT PRODUCE"*|*"MAUS ORGANIC PRODU"*|*"PURE & HEALTHY PTY"*|*"BLUEBERRY BLISS"*|*"THE MANGO PROJECT"*|*"MANNING FARMERS"*|*"PERFECT POULTRY"*|*"ZLR*FRESH FINESSE"*|*"TASTEE TATERS"*|*"SUBIACO FARMERS"*|*"FOOD ODYSSEY OPERATION"*|*"GENNARO DIDONNA"*)
        echo $line | sed s/$/,${catagory[23]}/ |  sed s/\"-/\"/ >>$destfile
        ;;
	#coffee	
	*"MR MOCHA"*|*"LITTLE LION COFFEE"*|*"TCC WARWICK GROVE"*|*"JAMAICA BLUE"*|*"NESPRESSO"*|*"MONTY'S"*|*"TCC Warwick Grove"*|*"LADY LATTE"*|*"THE COFFEE CLUB KINGSWAY"*|*DOME*) 
	echo $line | sed s/$/,${catagory[5]}/ |  sed s/\"-/\"/  >>$destfile
	;;
	## Internet Shopping
	*"AMAZON MARKETPLACE AU"*|*"MICROSOFT*STORE"*|*APPLE.COM*|*"AMAZON AU"*|*"AMZN DIGITAL"*) #internetshopping 
	echo $line | sed s/$/,${catagory[6]}/ |  sed s/\"-/\"/ >>$destfile
	;;
	## Meals amd Takeout
	*"DOLCI DI CLARA"*|*"CASA BLANCA CAFE"*|*"BURNZ CHARCOAL CHI"*|*"OPA OPA"*|*"VILLAGE CAFE"*|*"SAN CHURRO"*|*"DOMINOS"*|*"THE PIPERS INN"*|*"MOCHACHOS"*|*"MR CHIPPY MOBILE"*|*"WHOLEY CREPE"*|*"FUDGE AFFAIRS"*|*"ATHENA"*|*"KRISPY KREME"*|*"ROMA REPUBLIC"*|*"SEAFOOD NATION"*|*"MCDONALDS"*|*"300 ACRES-AMBROSE"*|*"HARVEY BEEF"*|*"BREAD IN COMMON"*|*"3SHEETS"*|*"BASKINROBBIN"*|*"AVIJOH PTY LTD "*|*"BATHERS BEACH HOUSE"*|*"OCEANFIRE"*|*"SPLASHES FISH HOUSE"*|*"TAMMYS BAKERY"*|*"HEALTHY POWER MEALS"*|*"HUSKY COFFEE"*|*"DD'S COFFEE HUT-CO"*|*"THE COFFEE GROVE"*|*"THE CHEESECAKE SHOP"*|*"KRUSTYKOB"*|*"MISS MAUD"*|*SUSHI*|*"CHIPS PLUS FISH"*|*KFC*|*"GLENDALE SNACK"*|*"KAILIS BEACH CAFE"*|*"THE HUMBLE CUP"*) #takeout 
	echo $line | sed s/$/,${catagory[7]}/ |  sed s/\"-/\"/ >>$destfile
	;;
	## days out and fun
	*"THE BEACH HOUSE"*|*"TICKETEK"*|*"MOTOR MUSEUM OF WA"*|*"BROTZEIT JOONDALUP"*|*"CPP CONVENTION CENTRE"*|*"EVENT WHITFORD"*|*"EVENT CINEMAS"*|*"ALH VENUES"*|*"NOVOTEL VINES RESORT"*|*"MR ELMOND FOODS"*|*"SAN CHURRO KARRINYUP"*|*"COCO BAKERY"*|*"THE WILD FIG CAFE"*|*"KINGS PARK KIOSK"*|*"TIM'S ICE CREAM"*|*"HOT JAM DONUTS"*|*"STREET FOOD LAB"*|*"JDS FOOD TRUCKS"*|*"CARNIVAL AMUSEMENT"*|*"GOOD COMPANY BAR"*|*"THE ISLAND"*|*"OUTBACK SPLASH"*|*"LITTLE DUTCHIES"*|*"TOPOLINIS CAFFE WARW"*|*"ZONE BOWLING"*|*"CLANCY'S FISH PUB"*|*BOUNCE*|*"GRAND THEATRE COMPAN"*) #days out and events out 
	echo $line | sed s/$/,${catagory[8]}/ |  sed s/\"-/\"/  >>$destfile
	;;
	#@#hair and beauty
	*"JUST A TRIM MENS HAIRS"*|*"KATHY S NAILS"*|*"PLINE WARWICK"*|*"HAIROLOGY XO"*|*"DOGGY DAZZLE"*|*"MOOSH MOOSH FOR HAI"*)
	echo $line | sed s/$/,${catagory[9]}/ |  sed s/\"-/\"/  >>$destfile #used for hair dresser, nails etc
	;;
	## Streaming and gaming online 
	*"PRIME VIDEO CHANNELS"*|*"PRIMEVIDEO"*|*"MICROSOFT*REALMS"*|*"EPICINTERNA"*|*"EB GAMES"*|*"STAN.COM.AU"*|*"HBO MAX"*|*"NINTENDO"*)
	echo $line | sed s/$/,${catagory[10]}/ |  sed s/\"-/\"/ >>$destfile	
	;;
	##golf
	*"GLENEAGLES BAR"*|*"DUNCAN CROSBIE GOLF"*|*"TENGOLF MAYLANDS"*|*"MARANGAROO GOLF COURSE"*|*"Golf James"*|*"TOWN OF CAMBRIDGE"*|*"CITY OF STIRLING"*)
	 echo $line | sed s/$/,${catagory[11]}/ |  sed s/\"-/\"/ >>$destfile
	;;
	##medical
	*"KINGSLEY HEALTH CARE"*|*"MEDICAL DOCTORS ROOM"*|*"JOONDALUP HEALTH CAMPUS"*|*"WIZARD PHRMCY"*|*"COMMUNITY HEALTH WESTE"*|*"LBHC P/L"*|*"WIZARD PHARMACY JOON"*|*"DISCOUNT DRUG STORES"*|*"SORRENTO PHARMACY"*|*"WESTERN HEALTH KINGSLE"*|*"TERRYWHITE CHEMMART"*|*"PLINE PH KINGSWAY"*|*"PLINEPH KARRINYUP"*|*"OPTIMAL PHARMACY"*|*"TERRY WHITE CHEMISTS"*)
	 echo $line | sed s/$/,${catagory[12]}/ |  sed s/\"-/\"/ >>$destfile
	;;
	##misc 
	*"KAPTURE PHOTOGRAPHY"*|*"SUNSET COAST SOUVE"*|*"SDB21C9QP"*|*"CHINTA DESIGN"*|*"Yokke Verbert"*|*"GRACE REMOVALS"*|*"CORPORATE SPORTS AUSTR"*)
	echo $line | sed s/$/,${catagory[13]}/ |  sed s/\"-/\"/ >>$destfile
	;;
	##newsagemts
	*"KINDLE UNLTD"*|*"Kindle Svcs"*|*NEWSLIMITED*|*"POST WARWICK POST"*|*"WARWICK GROVE NEWSAGE"*)
	echo $line | sed s/$/,${catagory[14]}/ |  sed s/\"-/\"/ >>$destfile
	;;
	#clothes
	*"REBEL"*|*"TARGET"*|*"THE ATHLETE'S FOOT"*|*"REBEL SPORT LTD"*|*"THE ATHLETES FOOT"*|*"JDSPORTSFAS"*|*"MYER"*)
	echo $line | sed s/$/,${catagory[15]}/ |  sed s/\"-/\"/ >>$destfile
	;;
	#School education 
	*"SCHOLASTIC AUSTRALIA"*|*"IXL LEARNING"*|*"GLENDALE PRIMARY"*|*"PHONICSPLAY"*)
        echo $line | sed s/$/,${catagory[17]}/ |  sed s/\"-/\"/ >>$destfile
	;;
	#Alcohol
	*"SA DISTILLING CO"*|*"THE LANDHAUS ESTATE"*|*"BWS LIQUOR"*|*"DAN MURPHY"*|*"THREEFOLD DISTILLI"*|*"SMALL BATCH DISTIL"*|*"NEVER NEVER DISTIL"*)
	echo $line | sed s/$/,${catagory[18]}/ |  sed s/\"-/\"/ >>$destfile
	;;
	*"DOT - LICENSING"*)
        echo $line | sed s/$/,${catagory[16]}/ |  sed s/\"-/\"/ >>$destfile
        ;;
	#Boxing and Sports 
        *"HAMERSLEY ROVERS J"*|*"LACEYS BOXING GYM"*)
        echo $line | sed s/$/,${catagory[19]}/ |  sed s/\"-/\"/ >>$destfile
        ;;
	#Pet Related 
        *"VETWEST"*|*"PETBARN"*|*"CITY FARMERS"*)
        echo $line | sed s/$/,${catagory[20]}/ |  sed s/\"-/\"/ >>$destfile
        ;;
	#Holidays and Vacation 
        *"DISCOVERY PARKS - BUNB"*)
        echo $line | sed s/$/,${catagory[21]}/ |  sed s/\"-/\"/ >>$destfile
        ;;
	#Cash Withdrawal
        *"ATM SH 16D 643 BEACH ROAD WARWICK"*|*"ATM CBA"*|*"ATM WESTPACWARWICK WA"*)
        echo $line | sed s/$/,${catagory[22]}/ |  sed s/\"-/\"/ >>$destfile
        ;;
	
	#Jewelery
	*"PROUDS 319"*)
        echo $line | sed s/$/,${catagory[24]}/ |  sed s/\"-/\"/ >>$destfile
			;;
    #Car Service     
	*"B SELECT KINGSWAY"*)
        echo $line | sed s/$/,${catagory[25]}/ |  sed s/\"-/\"/ >>$destfile 
		;;
	
		
	*) 
	echo $line | sed s/\"-/\"/ 
	((i=i+1))
	;;
	esac
done < $1 
echo $i
#function sorting {
#	case  catagory
#		IKEA)
#			cut  -d "," -f2 $line | sed '/^IKEA/ s/$/household/' | grep "household"	
#		;;
#	esac
#}

	
