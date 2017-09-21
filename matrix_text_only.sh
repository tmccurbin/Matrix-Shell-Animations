# Matrix Shell Animation: Text Only
# License: GNU General Public License, version 2 (GPLv2)
#
# This script allows users to animate plain text in the terminal window. It provides
# four styles of text entry and five styles of text deletion (20 total permutations).
#
# Author: Tyrell McCurbin
# Date created: September 19, 2017
# Host: https://github.com/tmccurbin
# Last modified by: Tyrell McCurbin
# Last modified date: September 21, 2017

# INSTRUCTIONS
# All your text must be in a file called 'lines.txt' for this script to work.
# Your text file must be in the same directory as this file.
# Change the animation paramaters in this file to suit your needs. 
# Navigate to this directory, in the terminal, and enter 'sh matrix_text_only.sh'

# ANIMATION PARAMETER DESCRIPTIONS
# text_entry: how your your text appears: forward, reverse, random, or instant
# text_deletion: how your text vanishes: forward, reverse, random, instant, or overwrite
# char_pause: delay between characters appearing on the screen, in seconds
# word_pause: delay between words appearing on the screen, in seconds
# after_entry_pause: delay after full sentence entry, in seconds
# after_deletion_pause: delay after dull sentence deletion, in seconds
# final_pause: delay after full document completion, in seconds

# ANIMATION PARAMETERS
# Change these parameters to customize your animation
text_entry="forward"
text_deletion="forward"
char_pause=0.1
word_pause=0.18
after_entry_pause=2
after_deletion_pause=1
final_pause=3

# Terminal window parameters
rows=`tput lines`
columns=`tput cols`
middle_line=`expr $rows / 2`
center_column=`expr $columns / 2` 

clear

# Read lines from text
terminal=`tty`
exec < lines.txt

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

  case $text_entry in
  
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
    # Position the cursor
    tput cup $middle_line $end_position
    for (( i=`expr $line_length - 1`; i>=0; i-- ));
    do
      sleep $char_pause
      echo "${line:i:1}\b\b\c"
    done
    ;; # reverse case
    
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
    
  case $text_deletion in 
  
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
    # Adjust cursor
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
    # Overwrite the previous line of text
    continue
    ;;
    
  instant)
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
  
done # while read line

exec < $terminal

sleep $final_pause