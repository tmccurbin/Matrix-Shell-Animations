# IMPORTANT: All your text must be in a file called 'lines.txt' for this script to work

# IMPORTANT: Dictate how you want your text to be entered
# Values for text_entry: sequential, reverse, random
text_entry="sequential"

# IMPORTANT: Dictate how you want your text to be entered and deleted
# Values for text deletion: sequential, reverse, random, overwrite
text_deletion="reverse"

# Terminal window parameters
rows=`tput lines`
columns=`tput cols`
middle_line=`expr $rows / 2`
center_column=`expr $columns / 2` 

# Timing (seconds)
char_pause=0.1
word_pause=0.18

clear

# Read lines from text
terminal=`tty`
exec < lines.txt

while read line
do
  
  # Compute line length
  line_length=`echo $line | wc -c`
  # Compute cursor positioning
  home_position=`expr $center_column - $line_length / 2`

  case $text_entry in
  
  sequential)
    
    tput cup $middle_line $home_position

    for word in $line
    do
      for (( char_index=0; char_index<${#word}; char_index++ ));
      do
        echo "${word:$char_index:1}\c"
        sleep $char_pause
      done

      echo " \c"
      sleep $word_pause

    done # word loop
    ;;
  
  reverse)
    echo "Text entry is in reverse"
    ;;
    
  random)
    # Text appears in random order
    # Perhaps this can be done in a 2D array
    # Each row is a character
    # Second column represent whether it has appeared onscreen
    # Better yet, create two arrays: positions (1-) and characters. 
    # Randomly select from the positions array, since characters can repeat themselves
    echo "Text entry is random"
    ;;
    
  *)
    echo "Invalid value for text entry"
    exit
    ;;
    
  esac # text entry
    
  case $text_deletion in 
  
  sequential)
    # Delete text from left to right
    tput cup $middle_line $home_position
    for (( i=0; i<line_length; i++ ))
    do
      echo " \c"
      sleep 0.1
    done
    ;;
    
  reverse)
    # Delete the text from right to left
    for (( i=0; i<line_length; i++ ))
    do
      echo "\b\c"
      echo " \c"
      echo "\b\c"
      sleep 0.1
    done
    ;;
  
  random)
    # Delete the text in random order
    continue
    ;;
  
  overwrite)
    # Overwrite the previous line of text
    continue
    ;;
    
  *)
    echo "Invalid value for text deletion"
    exit
    ;;
    
  esac # text deletion
  
done # while read line

exec < $terminal
sleep 5