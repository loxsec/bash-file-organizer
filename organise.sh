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


for file in "$dir"/*; do
	[[ "$file" == organise.sh ]] && continue

	if [[ "$file" == *.zip ]]; then
		move_file "$file" "$dir/zip-files"

	elif [[ "$file" == *.txt ]]; then
		move_file "$file" "$dir/text-files"

	elif [[ "$file" == *.mp3 ]]; then
		move_file "$file" "$dir/audios"

	elif [[ "$file" == *.csv ]]; then
		move_file "$file" "$dir/CSVs"

	elif [[ "$file" == *.pdf ]]; then
		move_file "$file" "$dir/PDFs"

	elif [[ "$file" == *.sh ]]; then
		move_file "$file" "$dir/scripts"

	elif [[ "$file" == *.jpg ]]; then
		move_file "$file" "$dir/images"

	elif [[ "$file" == *.png ]]; then
		move_file "$file" "$dir/images"

	elif [[ -f "$file" && "$file" != *.* ]]; then
		move_file "$file" "$dir/noext"

	fi
done

echo "All Done!!!"

