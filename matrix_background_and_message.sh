# Matrix Shell Animation: Background and Message
# License: GNU General Public License, version 2 (GPLv2)

# This script creates a Matrix-like text animation in the terminal window. It builds upon the 'matrixish.sh' script, which was originally written by Brett Terpstra and other contributors. See https://gist.github.com/ttscoff/3729164#file-matrixish-sh for the original script.

# Author: Tyrell McCurbin
# Date created: September 19, 2017
# Host: https://github.com/tmccurbin
# Last modified by: Tyrell McCurbin
# Last modified date: September 21, 2017

# INSTRUCTIONS
# All your text must be in a file called 'lines.txt' for this script to work.
# Your text file must be in the same directory as this file.
# Change the animation paramaters in this file to suit your needs. 
# Navigate to this directory, in the terminal, and enter 'sh matrix_background_and_message.sh'

# ANIMATION PARAMETER DESCRIPTIONS
# symbols: type of characters to appear; alphanumeric, numeric, hexadecimal, katakana, or emoji
# frequency: non-linear chance that a randomly-selected character is replaced; must be an integer between 1 and 100; 1=>1%, 51=>2%, 68=>3%, 76=>4%, 81=>5%, 91=>10%, 96=>20%, 97=>25%, 98=>33.33%, 99=>50%, 100=>100%
# scroll_speed: enter 0 for static; greater positive integers increase scroll speed
# ending: the matrix animation will randomly fade or repopulate the screen; "fade" or "repopulate"
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
intro_scroll_speed=0
outro_scroll_speed=0
ending="fade"
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
screenlines=$(expr `tput lines` - 1 + $intro_scroll_speed)
screencols=$(expr `tput cols` / 2 - 1)

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

# Measure array sizes for RANDOM modulus
count=${#chars[@]}
color_count=${#colors[@]}

# Compute the divisor for the random modulus
divisor=`expr 101 - $frequency`

# The commands in quotes are run on signals interrupt (Ctrl + C), and stop (Ctrl + Z), and on errors producing a signal token of 0, 1, 9, and 15
trap "tput sgr0; tput cnorm; clear; exit" SIGTERM SIGINT SIGTSTP 0 1 9 15

# Help message
if [[ $1 =~ '-h' ]]; then
	echo "Display a Matrix-like screen in the terminal"
	echo "Example:	sh matrix_background_and_message.sh"
	exit 0
fi

clear

# Hide and position the cursor
tput civis
tput cup 0 0

for(( x=0; x<15; x++ ))
do
  for i in $(eval echo {1..$screenlines})
  do
    for i in $(eval echo {1..$screencols})
    do
      rand=$(($RANDOM%$divisor))
      case $rand in
      0) printf "${colors[$RANDOM%$color_count]}${chars[$RANDOM%$count]} " ;;
      1) printf "  " ;; # Maintain some blank space in the animation
      *) printf "\033[2C" ;; # move the cursor two spaces forward
      esac
    done
    printf "\n"
  done
  tput cup 0 0
done

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#                       THIS IS WHERE THE MESSAGE ANIMATION BEGINS
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Return the cursor to normal
tput cnorm

# Change font
echo "\033[30m"

text_entry=("forward" "reverse" "random")
text_deletion=("reverse" "random" "overwrite")
char_pause=0.1
word_pause=0.18
after_entry_pause=2
after_deletion_pause=1
final_pause=1

# Terminal window parameters
rows=`tput lines`
columns=`tput cols`
middle_line=`expr $rows / 2`
center_column=`expr $columns / 2`

# Help message
if [[ $1 =~ '-h' ]]; then
	echo "Animate a message in the terminal"
	echo "Example:	sh matrix_background_only.sh"
	exit 0
fi

# Read lines from text
terminal=`tty`
exec < lines.txt
line_index=0

# The second condition accounts for files without new lines
while read line || [ -n "$line" ]
do
  
  # Compute line length. 
  # Subtract 1 for the new line char
  line_length=`echo $line | wc -c`
  line_length=`expr $line_length - 1`
  
  # Compute cursor positioning
  home_position=`expr $center_column - $line_length / 2`
  end_position=`expr $home_position + $line_length`

  case ${text_entry[$line_index]} in
  
  forward)    
    # Keep track of words for adding spaces
    word_count=`echo $line | wc -w`
    current_word=1
    
    # Position the cursor
    tput cup $middle_line $home_position
    
    for word in $line
    do
      # Print the characters of each word
      for (( char_index=0; char_index<${#word}; char_index++ ));
      do
        echo "${word:$char_index:1}\c"
        sleep $char_pause
      done

      # Add a space after all words except the last word
      if [ $current_word != $word_count ]
      then
        echo " \c"
        current_word=`expr $current_word + 1`
      fi

      sleep $word_pause

    done # word loop
    ;; # forward case
  
  reverse)
    # Position the cursor on the last character
    tput cup $middle_line `expr $end_position - 1`
    for (( i=`expr $line_length - 1`; i>=0; i-- ));
    do
      sleep $char_pause
      echo "${line:i:1}\b\b\c"
    done
    ;; # reverse case
    
  outside_in)
    # Make the cursor invisible
    tput civis
    
    for (( i=0; i<line_length; i++ ))
    do
      if [ `expr $i % 2` -eq 0 ] # even iterations
      then
        # Calculate index to enter
        text_index=`expr $i / 2`

        # Position cursor
        tput cup $middle_line `expr $home_position + $text_index`

        sleep `echo 0.97 \* $char_pause | bc`
        echo "${line:$text_index:1}\c"
      else # odd iterations
        # Calculate index to enter
        text_index=`expr $line_length - \( $i + 1 \) / 2`

        # Position cursor
        tput cup $middle_line `expr $home_position + $text_index`

        sleep `echo 0.97 \* $char_pause | bc`
        echo "${line:$text_index:1}\c"
      fi
    done
    
    # Position cursor
    tput cup $middle_line $end_position
    
    ;; # outside-in case
    
    random)
    # Create an array for positions
    # Randomly select from the positions array, since characters may be repeated
    
    # Populate the positions array
    for (( i=0; i<$line_length; i++ ))
    do
      position_array[$i]=$i
    done
    
    # Randomly select from the position array
    for (( i=0; i<$line_length; i++ ))
    do
    
      # Divisor needs to be one more than max index
      divisor=$line_length
      
      while true
      do
        
        # Generate a random index between 0 and max index
        random_index=$(($RANDOM%divisor))
        
        # Enter characters that have not already been entered
        if [ "${position_array[random_index]}" != "" ]
        then
          
          # Move cursor to position
          new_column=`expr $home_position + $random_index`
          tput cup $middle_line $new_column
          
          # Print character
          sleep $char_pause
          echo "${line:$random_index:1}\c"
          
          # Remove entry from position array
          unset position_array[random_index]

          # Break the while loop. Continue with the for loop
          break
        fi # Done printing character
      done # Done generating random indices
      
    done # Line printing done
    
    # Delete the array
    unset position_array
    
    # Relocate cursor to end of sentence
    tput cup $middle_line $end_position
    
    ;; # random case
  
  instant)
    tput cup $middle_line $home_position
    echo "$line\c"
    ;;
    
  *)
    echo "Invalid value for text entry"
    exit
    ;;
    
  esac # text entry
  
  sleep $after_entry_pause # Rest between text entry and deletion
  
  if [ ${text_entry[line_index]} = "outside_in" ]
  then
    tput cnorm # make the cursor visible
  fi
  
  case ${text_deletion[$line_index]} in 
  
  forward)
    # Delete text from left to right
    tput cup $middle_line $home_position
    for (( i=0; i<line_length; i++ ))
    do
      echo " \c"
      sleep $char_pause
    done
    ;;
    
  reverse)
    # Place the cursor at the end of the line
    tput cup $middle_line $end_position
    
    # Delete the text from right to left
    for (( i=0; i<line_length; i++ ))
    do
      echo "\b \b\c"
      sleep $char_pause
    done
    ;;
  
  random)
    # Delete the text in random order
    # Create an array for positions
    # Randomly select from the positions array, since characters can repeat themselves
    
    # Populate the positions array
    for (( i=0; i<$line_length; i++ ))
    do
      position_array[$i]=$i
      # echo "Position $i is ${position_array[$i]}"
    done
    
    # Randomly select from the position array
    for (( i=0; i<$line_length; i++ ))
    do
    
      # Divisor needs to be one more than max index
      divisor=$line_length
      
      while true
      do
        
        # Generate a random index between 0 and line_length - 1
        random_index=$(($RANDOM%divisor))
        
        # Enter characters that have not already been entered
        if [ "${position_array[random_index]}" != "" ]
        then
          
          # Move cursor to position
          new_column=`expr $home_position + $random_index`
          tput cup $middle_line $new_column
          
          # Delete character by overwriting it with a space
          sleep $char_pause
          echo " \c"
          
          # Remove entry from position array
          unset position_array[random_index]

          # Break the while loop. Continue with the for loop
          break
        fi # Done printing character
      done # Done generating random indices
      
    done # Line printing done
    
    # Delete the array
    unset position_array
    ;;
  
  overwrite)
    # Overwrite the previous line of text.
    # Be sure to increment line_number before leaving the loop
    line_index=`expr $line_index + 1`
    continue
    ;;
    
  instant)
  
    # Place the cursor at the end of the line
    tput cup $middle_line $end_position
    
    # Delete the text from right to left
    for (( i=0; i<line_length; i++ ))
    do
      echo "\b \b\c"
    done
    ;;
    
  *)
    echo "Invalid value for text deletion"
    exit
    ;;
    
  esac # text deletion
  
  sleep $after_deletion_pause
  
  line_index=`expr $line_index + 1`
  
done # while read line

exec < $terminal

sleep $final_pause

# Font Reset
echo "\033[0;0m"

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#                       THIS IS WHERE THE FINAL ANIMATION BEGINS
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Hide and position the cursor
tput civis
tput cup 0 0

# Terminal window parameters
screenlines=$(expr `tput lines` - 1 + $outro_scroll_speed)

for(( x=0; x<60; x++ ))
do
  for i in $(eval echo {1..$screenlines})
  do
    for i in $(eval echo {1..$screencols})
    do
      rand=$(($RANDOM%$divisor))
      case $rand in
      0) 
        case $ending in 
        fade) printf "  " ;; # Fade out
        repopulate) printf "${colors[$RANDOM%$color_count]}${chars[$RANDOM%$count]} " ;;
        *) echo "Invalid ending parameter"; exit ;;
        esac ;;
      1) printf "  " ;; # Maintain some blank space in the animation
      *) printf "\033[2C" ;; # move the cursor two spaces forward
      esac
    done
    printf "\n"
  done
  tput cup 0 0
done