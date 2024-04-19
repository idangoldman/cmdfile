#!/usr/bin/awk -f

BEGIN {
  RS = "---";
  record_num = 0;
  frontmatter = "";
  body = "";
}

function process_record() {
  gsub(/^\n|\n$/, "", frontmatter);
  gsub(/^\n|\n$/, "", body);
  gsub(/\n/, "\n  ", body);
  # gsub(/[\n"]/, "\\\\&", body);
  # gsub(/[\n"]/, "\\\\&", frontmatter);

  print frontmatter
  print body;
}

{
  record_num++;

  if (record_num == 2) {
    frontmatter = $0;
  } else if (record_num == 3) {
    if (length($0) > 0) {
      body = substr($0, 2);
    }

    body = "body: |\n" body;
  } else if (record_num > 3) {
    body = body "\n  " $0;
  }
}

END {
  process_record();
}
