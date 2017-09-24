# Matrix Shell Animation: Background Only
# License: GNU General Public License, version 2 (GPLv2)

# This script creates a Matrix-like text animation in the terminal window. It builds upon the 'matrixish.sh' script, which was originally written by Brett Terpstra and other contributors. See https://gist.github.com/ttscoff/3729164#file-matrixish-sh for the original script.

# Author: Tyrell McCurbin
# Date created: September 20, 2017
# Host: https://github.com/tmccurbin
# Last modified by: Tyrell McCurbin
# Last modified date: September 21, 2017

# ANIMATION PARAMETER DESCRIPTIONS
# symbols: type of characters to appear: alphanumeric, numeric, hexadecimal, katakana, emoji
# frequency: non-linear chance that a randomly-selected character is replaced; must be an integer between 1 and 199; 1=>1%, 101=>2%, 151=>4%, 161=>5%, 181=>10%, 191=>20%, 193=>25%, 195=>33.33%, 197=>50%, 199=>100%
# scroll_speed: enter 0 for static; greater positive integers increase scroll speed
# font_color: choose black, red, green, yellow, blue, magenta, cyan, light_gray, dark_gray, light_red, light_green, light_yellow, light_blue, light_magenta, light_cyan, or white
# is_bold: make the font bold: "true" or "false"
# is_dim: decrease the brightness of the text; "true" or "false"
# is_underlined: underline the text using the font color; "true" or "false"
# is_flashing: blinking text; "true" or "false"
# is_inverted: swap the background color and text color; "true" or "false"
# is_hidden: characters are invisible; "true" or "false"
# more info available at: https://misc.flogisoft.com/bash/tip_colors_and_formatting

# ANIMATION PARAMETERS
# Change these parameters to customize your animation. See descriptions above.
# Characters
symbols="hexadecimal"
frequency=1
scroll_speed=0
# Font 1
font_color_1="light_gray"
background_color_1="default"
is_bold_1="false"
is_dim_1="false"
is_underlined_1="false"
is_flashing_1="false"
is_inverted_1="false"
is_hidden_1="false"
# Font 2
font_color_2="light_gray"
background_color_2="default"
is_bold_2="true"
is_dim_2="false"
is_underlined_2="false"
is_flashing_2="false"
is_inverted_2="false"
is_hidden_2="false"

# Color definitions; do not edit
case $font_color_1 in
black)          color_1="30";;
red)            color_1="31";;
green)          color_1="32";;
yellow)         color_1="33";;
blue)           color_1="34";;
magenta)        color_1="35";;
cyan)           color_1="36";;
light_gray)     color_1="37";;
dark_gray)      color_1="90";;
light_red)      color_1="91";;
light_green)    color_1="92";;
light_yellow)   color_1="93";;
light_blue)     color_1="94";;
light_magenta)  color_1="95";;
light_cyan)     color_1="96";;
white)          color_1="97";;
*) echo "Invalid font_color_1 option"; exit ;;
esac

case $font_color_2 in
black)          color_2="30";;
red)            color_2="31";;
green)          color_2="32";;
yellow)         color_2="33";;
blue)           color_2="34";;
magenta)        color_2="35";;
cyan)           color_2="36";;
light_gray)     color_2="37";;
dark_gray)      color_2="90";;
light_red)      color_2="91";;
light_green)    color_2="92";;
light_yellow)   color_2="93";;
light_blue)     color_2="94";;
light_magenta)  color_2="95";;
light_cyan)     color_2="96";;
white)          color_2="97";;
*) echo "Invalid font_color_2 option"; exit ;;
esac

# Background definitions; do not edit
case $background_color_1 in
black)          bg_color_1=";40";;
red)            bg_color_1=";41";;
green)          bg_color_1=";42";;
yellow)         bg_color_1=";43";;
blue)           bg_color_1=";44";;
magenta)        bg_color_1=";45";;
cyan)           bg_color_1=";46";;
light_gray)     bg_color_1=";47";;
default)        bg_color_1=";49";;
dark_gray)      bg_color_1=";100";;
light_red)      bg_color_1=";101";;
light_green)    bg_color_1=";102";;
light_yellow)   bg_color_1=";103";;
light_blue)     bg_color_1=";104";;
light_magenta)  bg_color_1=";105";;
light_cyan)     bg_color_1=";106";;
white)          bg_color_1=";107";;
*) echo "Invalid background_color_1 option"; exit ;;
esac

case $background_color_2 in
black)          bg_color_2=";40";;
red)            bg_color_2=";41";;
green)          bg_color_2=";42";;
yellow)         bg_color_2=";43";;
blue)           bg_color_2=";44";;
magenta)        bg_color_2=";45";;
cyan)           bg_color_2=";46";;
light_gray)     bg_color_2=";47";;
default)        bg_color_2=";49";;
dark_gray)      bg_color_2=";100";;
light_red)      bg_color_2=";101";;
light_green)    bg_color_2=";102";;
light_yellow)   bg_color_2=";103";;
light_blue)     bg_color_2=";104";;
light_magenta)  bg_color_2=";105";;
light_cyan)     bg_color_2=";106";;
white)          bg_color_2=";107";;
*) echo "Invalid background_color_2 option"; exit ;;
esac

# Other formatting definitions; do not edit
bold_1=$([ "$is_bold_1" = "true" ] && echo ";1" || echo "")
bold_2=$([ "$is_bold_2" = "true" ] && echo ";1" || echo "")
dim_1=$([ "$is_dim_1" = "true" ] && echo ";2" || echo "")
dim_2=$([ "$is_dim_2" = "true" ] && echo ";2" || echo "")
underline_1=$([ "$is_underlined_1" = "true" ] && echo ";4" || echo "")
underline_2=$([ "$is_underlined_2" = "true" ] && echo ";4" || echo "")
flashing_1=$([ "$is_flashing_1" = "true" ] && echo ";5" || echo "")
flashing_2=$([ "$is_flashing_2" = "true" ] && echo ";5" || echo "")
inverted_1=$([ "$is_inverted_1" = "true" ] && echo ";7" || echo "")
inverted_2=$([ "$is_inverted_2" = "true" ] && echo ";7" || echo "")
hidden_1=$([ "$is_hidden_1" = "true" ] && echo ";8" || echo "")
hidden_2=$([ "$is_hidden_2" = "true" ] && echo ";8" || echo "")

# Compile the fonts; do not edit
font_prefix="\033["
font_suffix="m"
font_reset="\033[0;0m"
font_1=$font_prefix$color_1$bg_color_1$hidden_1$inverted_1$flashing_1$underline_1$dim_1$bold_1$font_suffix
font_2=$font_prefix$color_2$bg_color_2$hidden_2$inverted_2$flashing_2$underline_2$dim_2$bold_2$font_suffix

# Store chosen font settings in an array.
colors=($font_1 $font_2)

# Terminal window parameters
screenlines=$(expr `tput lines` - 1 + $scroll_speed)
screencols=$(expr `tput cols` / 2)
# Terminal window parameters
rows=`tput lines`
columns=`tput cols`
middle_line=`expr $rows / 2`
center_column=`expr $columns / 2`

# Characters
case $symbols in 
alphanumeric)
  chars=(a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z 0 1 2 3 4 5 6 7 8 9 ^) ;;
numeric) 
  chars=(0 1 2 3 4 5 6 7 8 9) ;;
hexadecimal)
  chars=(0 1 2 3 4 5 6 7 8 9 A B C D E F) ;;
katakana)
  chars=(ｱ ｲ ｳ ｴ ｵ ｶ ｷ ｸ ｹ ｺ ｻ ｼ ｽ ｾ ｿ ﾀ ﾁ ﾂ ﾃ ﾄ ﾅ ﾆ ﾇ ﾈ ﾉ ﾊ ﾋ ﾌ ﾍ ﾎ ﾏ ﾐ ﾑ ﾒ ﾓ ﾔ ﾕ ﾖ ﾗ ﾘ ﾙ ﾚ ﾛ ﾜ ヰ ヱ ヲ ﾝ) ;;
emoji)
  chars=( $(ruby -KUe 'print ((["1f600".hex].pack("U"))..(["1f6b0".hex].pack("U"))).to_a.join(" ")') ) ;;
*)
  echo "Invalid input for symbols"; exit ;;
esac

# Measure array sizes for RANDOM selection of color and characters
count=${#chars[@]}
color_count=${#colors[@]}

# Compute the divisor for the random modulus
probability_divisor=`expr 201 - $frequency`

# The commands in quotes are run on signals interrupt (Ctrl + C), and stop (Ctrl + Z), and on errors producing a signal token of 0, 1, 9, and 15
trap "tput sgr0; tput cnorm; clear; exit" SIGTERM SIGINT SIGTSTP 0 1 9 15

# Help message
if [[ $1 =~ '-h' ]]; then
	echo "Display a Matrix-like screen in the terminal"
	echo "Example:	sh matrix_background_only.sh"
	exit 0
fi

clear

# Hide and position the cursor
tput civis
tput cup 0 0

# Read lines from text
terminal=`tty`
exec < lines.txt

# Bookkeeping
line_index=0
interval=1
animation_count=0
text_index=0
read_line_flag=0
print_flag=0

while true
do

  if [ $animation_count -eq 35 -o $animation_count -eq 75 -o $animation_count -eq 110 ]
  then
    read_line_flag=1
  fi
  
  if [ $read_line_flag -eq 1 ]
  then
    read line
    # Compute line length. 
    # Subtract 1 for the new line char
    line_length=`echo $line | wc -c`
    line_length=`expr $line_length - 1`

    # Compute cursor positioning
    home_position=`expr $center_column - $line_length / 2`
    end_position=`expr $home_position + $line_length`
    
    # Handle flags
    read_line_flag=0
    print_flag=1
    text_index=0
  fi
  
  
  if [ $print_flag -eq 1 ] # You could also use the interval: if [ `expr $animation_count % $interval` -eq 0 ]
  then
    tput cup $middle_line `expr $home_position + $text_index`
    echo "\033[30m${line:$text_index:1}\033[0m\c" # Print char in new color
    text_index=`expr $text_index + 1`
    
    # Reset the cursor so the matrix animation doesn't run off screen
    tput cup 0 0

    # Reset flag
    if [ $text_index -eq `expr $line_length - 1` ]
    then
      print_flag=0
    fi
  fi
  
  # Pause the animation if scroll is on and the print flag is raised
  if  [ $scroll_speed -eq 0 ] || ( [ $scroll_speed -gt 0 ] && [ $print_flag -ne 1 ] ) 
  then
    for i in $(eval echo {1..$screenlines})
    do
      # Avoid overwriting the text while printing
      if [ $print_flag -ne 1 ] && [ $i -ne $middle_line ]  # I COULD ADD THIS CONDITION TO BE MORE PRECISE: $i -ne $middle_line
      then
        for j in $(eval echo {1..$screencols})
        do
          rand=$(($RANDOM%$probability_divisor))
          case $rand in
          0) printf "${colors[$RANDOM%$color_count]}${chars[$RANDOM%$count]} " ;;
          1) printf " ${colors[$RANDOM%$color_count]}${chars[$RANDOM%$count]}" ;;
          2-3) printf "  " ;; # Maintain some blank space in the animation
          *) printf "\033[2C" ;; # move the cursor two spaces forward
          esac
        done
      fi
      printf "\n"
    done
  fi
  animation_count=`expr $animation_count + 1`
  tput cup 0 0
done