#!/usr/bin/awk -f

# Initialize variables
BEGIN {
  block_name = "";
  description = "";
  vars = "";
  content = "";
}

# Function to process and print the current block's content
function print_block() {
  if (block_name != "") {
    # Prepare content by replacing newlines with \n to keep the output to one line
    gsub(/\n/, "\\n", content);
    # Print elements separated by a unique delimiter
    print block_name "::" description "::" vars "::" content;
  }
  block_name = description = vars = content = ""; # Reset for the next block
}

# Match lines that indicate the start of a block
/^(Given|When|Then)/ {
  if (block_name != "") print_block(); # Process the previous block if it exists
  block_name = $1;
  match($0, /'([^']+)'/, arr);
  description = arr[1];

  $0 = substr($0, RSTART + RLENGTH);
  if ($0 ~ /\$/) {
    gsub(/^ +/, "");
    vars = $0;
  }

  next;
}

# Capture indented content
/^  / {
  if (block_name != "") content = content (content ? "\n" : "") substr($0, 5);
}

# At the end of the file, print the last block
END {
  print_block();
}
