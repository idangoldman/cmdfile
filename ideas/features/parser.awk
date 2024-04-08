#!/usr/bin/awk -f

# Initialize variables
BEGIN {
  keyword = "";
  sentence = "";
  variables = "";
  content = "";
}

# Function to process and print the current block's content
function print_block() {
  if (keyword != "") {

    # Prepare content for output by escaping newlines and removing trailing newline
    sub(/\n$/, "", content);
    gsub(/\n/, "\\n", content);

    # Print elements separated by a unique delimiter
    print keyword "::" sentence "::" variables "::" content;
  }
  keyword = sentence = variables = content = ""; # Reset for the next block
}

# Match lines that indicate the start of a block
/^(Given|When|Then)/ {
  if (keyword != "") print_block(); # Process the previous block if it exists
  keyword = $1;
  match($0, /'([^']+)'/, arr);
  sentence = arr[1];

  $0 = substr($0, RSTART + RLENGTH);
  if ($0 ~ /\$/) {
    gsub(/^ +/, "");
    variables = $0;
  }

  next;
}

# Capture indented content
/^  / {
  if (keyword != "") content = content (content ? "\n" : "") substr($0, 5);
}

# At the end of the file, print the last block
END {
  print_block();
}
