#!/bin/bash

YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
BLUE=$(tput setaf 4)
GGG=$(tput setaf 5)
CYN=$(tput setaf 7)
STAND=$(tput sgr 0)
BOLD=$(tput bold)


GET="$1"
pwd=$(pwd)


if [ -z $GET ]; then #|| [ -z $POST ] ; then
    echo -e "$RED$BOLD
 ▀▛▘▗ ▌ ▀▛▘  ▌   ▛▀▖          ▜         ▌      
  ▌ ▄ ▌▗▘▌▞▀▖▌▗▘ ▌ ▌▞▀▖▌  ▌▛▀▖▐ ▞▀▖▝▀▖▞▀▌▞▀▖▙▀▖
  ▌ ▐ ▛▚ ▌▌ ▌▛▚  ▌ ▌▌ ▌▐▐▐ ▌ ▌▐ ▌ ▌▞▀▌▌ ▌▛▀ ▌  
  ▘ ▀▘▘ ▘▘▝▀ ▘ ▘ ▀▀ ▝▀  ▘▘ ▘ ▘ ▘▝▀ ▝▀▘▝▀▘▝▀▘▘$STAND by-$GREEN$BOLD rouze_d$STAND"
    echo -e "$YELLOW$BOLD Missing video link URL:$STAND$BOLD bash $0 https://www.tiktok.com/@tiktokuser/video/1234567890$STAND"
    exit
fi


c=$(echo $1 | cut -d '/' -f 4)
b=$(echo $1 | cut -d '/' -f 6 | cut -d '?' -f 1)

# echo -e "
# .www.tiktok.com	TRUE	/	FALSE	1614874506	MONITOR_WEB_ID	b1c73e7a-e9b7-4f6c-8b95-1b49ab3227b8
# .tiktok.com	TRUE	/	FALSE	1608332062	CONSENT	YES+
# .tiktok.com	TRUE	/	TRUE	1638633279	tt_webid	6902430212190832130
# .tiktok.com	TRUE	/	TRUE	1638633279	tt_webid_v2	6902430212190832130
# .tiktok.com	TRUE	/	TRUE	0	tt_csrf_token	Htv_7mtkaH1D_ehZr3f84Y5Y
#www.tiktok.com	FALSE	/	FALSE	0	s_v_web_id	verify_kiagygei_J4Frui45_RF6k_4r3t_AOr3_ju5FsZ6gWnNv
#" >> .t_cookie.txt

# option 1 for download method
#title=`curl --cookie $pwd/.t_cookie.txt -s -k --url https://www.tiktok.com/node/share/video/$c/$b --referer $GET --user-agent 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36' --connect-timeout 90 | grep '#' | tr '{' '\n' | head | grep 'title\"\:' | cut -d '"' -f4`
#down=`curl --cookie $pwd/.t_cookie.txt -s -k --url https://www.tiktok.com/node/share/video/$c/$b --referer $GET --user-agent 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36' --connect-timeout 90 | tr '"' '\n' | grep -i -E 'video_mp4' | tail -n 1`

# option 2 for download method
#down=`curl --cookie .t_cookie.txt -s -k --url $GET --user-agent 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36' --connect-timeout 90 | tr '"' '\n' | grep -i -E 'video/[a-z]'\|'.mp4' | tail -n 1`

# option 3 for download method
#down=`curl --cookie $pwd/.t_cookie.txt -s -k --url $GET --referer $GET --user-agent 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36' --connect-timeout 90 | tr '"' '\n' | grep video_mp4 | head -n 1 | sed 's/amp;//g'`

# option 4 for download method
#down=`curl --cookie .t_cookie.txt -s -k  --url $GET --user-agent 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36' | tr '"' '\n' | grep -i -E 'video/[a-z]'\|'.mp4' | tail -n 1 | sed 's/\\u0026/\&/g'`

# option 5 for download method
title=$(curl -s -k --url $GET --referer $GET --user-agent 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36' --connect-timeout 90 | tr '>' '\n' | grep '\/title' | cut -d '<' -f1)
down=$(curl -s -k --url $GET --referer $GET --user-agent 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36' --connect-timeout 90 | tr '"' '\n' | grep video_mp4 | head -n 1 |  sed 's/\\u002F/\//g' | sed 's/\%7C/|/g' | sed 's/\%3D/=/g')



#c=$(echo $1 | cut -d '@' -f 2 | cut -d '/' -f 1)
echo -e "\n${YELLOW}video title/caption :${BOLD}${GREEN} ${title} ${STAND}"

#curl -s -k --url ${down} --referer $GET --user-agent 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36' --connect-timeout 90 -o $c-$b.mp4

wget --quiet --referer $GET --user-agent 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36'  --show-progress -c $down -O $c-$b.mp4

#echo -e "\nvideo : ${c}-${b}.mp4\ntitle/caption : ${title}" >> ${c}-title.txt

#wget --user-agent='Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.89 Safari/537.36' --show-progress -c $down -O $c-$b.mp4
