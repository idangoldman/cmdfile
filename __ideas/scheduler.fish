#!/usr/bin/fish

set -l cron_jobs_folder "$DOTFILES/scripts"
set -l cron_jobs '0 6 * * *' 'update/dotfiles'

for cron_job in $cron_jobs
  set schedule (echo $cron_job | cut -d ' ' -f 1-5)
  set job_name (echo $cron_job | cut -d ' ' -f 6)
  set full_job_path "$cron_jobs_folder/$job_name.fish"

  if not crontab -l | grep -q $full_job_path
    echo -e "$schedule $full_job_path" | crontab -u $USER -

    echo "\
      Cron job added with the following schedule: $schedule\
      Job to run: $full_job_path\
    "
  end
end
