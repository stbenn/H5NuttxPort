## Use to clean up escape characters etc. from the log file outputs from pr_ci_run.sh
# Usage: source pr_ci_log_cleanup.sh logfile_name.log

fil=$1

cat $1 \
  | tr -d '\r' \
  | tr -d '\r' \
  | sed 's/\x08/ /g' \
  | sed 's/\x1B(B//g' \
  | sed 's/\x1B\[K//g' \
  | sed 's/\x1B[<=>]//g' \
  | sed 's/\x1B\[[0-9:;<=>?]*[!]*[A-Za-z]//g' \
  | sed 's/\x1B[@A-Z\\\]^_]\|\x1B\[[0-9:;<=>?]*[-!"#$%&'"'"'()*+,.\/]*[][\\@A-Z^_`a-z{|}~]//g' \
  >pr_tmp.log
mv pr_tmp.log $1
echo ----- "Done! $1"