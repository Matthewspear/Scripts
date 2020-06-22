#/usr/bin/env bash

# adapted from: https://gist.github.com/pmbauer/9285d6a6c72fc86d9300f28042642ca6

set -euo pipefail
IFS=$'\n\t'

roam_date() {
  gdate -d "${*}" '+%B %eXX, %Y' \
    | sed -e 's/11XX/11th/; s/12XX/12th/; s/13XX/13th/' \
          -e 's/1XX/1st/;   s/2XX/2nd/;   s/3XX/3rd/' \
          -e 's/XX/th/; s/  / /'
}

ONE_DAY=$((60 * 60 * 24))
week_start=$(gdate -d "${*:-next Monday}" "+%s")

cat <<END
Week:: [[$(roam_date @$((${week_start} + ${ONE_DAY} * 0)))]]
### Top Weekly Goals
### [[Weekly Habits]]
  -
### Daily Goals
  - Monday: [[$(   roam_date @$((${week_start} + ${ONE_DAY} * 0)))]]
  - Tuesday: [[$(  roam_date @$((${week_start} + ${ONE_DAY} * 1)))]]
  - Wednesday: [[$(roam_date @$((${week_start} + ${ONE_DAY} * 2)))]]
  - Thursday: [[$( roam_date @$((${week_start} + ${ONE_DAY} * 3)))]]
  - Friday: [[$(   roam_date @$((${week_start} + ${ONE_DAY} * 4)))]]
  - Saturday: [[$( roam_date @$((${week_start} + ${ONE_DAY} * 5)))]]
  - Sunday: [[$(   roam_date @$((${week_start} + ${ONE_DAY} * 6)))]]
END

