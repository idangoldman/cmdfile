#!/usr/bin/awk -f

BEGIN {
  keyword = "";
  sentence = "";
  variables = "";
  content = "";
}

function print_block() {
  if (keyword != "") {
    sub(/\n$/, "", content);
    gsub(/\n/, "\\n", content);

    print keyword "::" sentence "::" variables "::" content;
  }

  keyword = sentence = variables = content = "";
}

/^(Given|When|Then)/ {
  if (keyword != "") print_block();
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

/^  / {
  if (keyword != "") content = content (content ? "\n" : "") substr($0, 5);
}

END {
  print_block();
}
