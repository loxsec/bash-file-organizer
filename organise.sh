#!/bin/bash

#initializing variables
dir=$1
DRY_RUN_FLAG="$2"


# gardrail check 
if [[ -z "$dir" ]]  		# checks is input is an empty string or not 
then
	echo "Usage: $0 <directory> [--dry-run]"
	exit 1
fi

if [[ ! -d "$dir" ]] 		# checks if input is a directory or not
then
	echo "Error: $dir is not a directory"
	exit 1
fi

# function 
move_file() {
	local src="$1" dest="$2" 		# initialize local variable
	if [[ "$DRY_RUN_FLAG" == "--dry-run" ]] 		# checks for --dry-run flag
	then
		echo "moving \"$src\" to \"$dest\""		# --dry-run output
	else
		mkdir -p "$dest"		# creates a directory is it doesn't exists 
		mv -- "$src" "$dest"		# moves file to directory
	fi
}

for file in "$dir"/*; do		# loops through the entire directory

	[[ "$file" == *.sh ]] && continue		# skips .sh files

	if [[ "$file" == *.txt ]]		# checks if file extension is .txt and moves it
       	then
		move_file "$file" "$dir/text/"
		
	elif [[ "$file" == *.jpg ]]		# checks if file extension is .jpg amd moves it
       	then
		move_file "$file" "$dir/image/"

	elif [[ -f "$file" && "$file" != *.* ]] 		# checks if file have no extension an moves it
	then
		move_file "$file" "$dir/noextension"
	fi
done

echo " All Done"



