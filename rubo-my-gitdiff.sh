lint() {
  tput setaf 128; echo "Starting to rubocop your git diff. . ."
  tput sgr0; 
  echo "Getting local files . . ."
  buildFileList
  if [[ -z "$files" ]]; then
    tput setaf 154; echo "No files to inspect, Stopping. . ."
    tput sgr0; 
  else
    tput setaf 166;
    echo "Inspecting files:" && tput sgr0
    printf "$formattedFiles\n"
    gemCheck
    bundle exec rubocop --force-exclusion -A "${files[@]}"
    tput setaf 128; echo "Finished Rubocopping your git diff, Stopping. . ." && tput sgr0
  fi
}

setGlobals() {
  files=""
  skippedFiles=""
  formattedFiles=""
  counter=0
  skippedCounter=0
}

buildFileList() {
  getFileDiff
  collectRubyFiles
  tput setaf 166;
  printf "Filtered $skippedCounter non-ruby files:" && tput sgr0;
  printf "$skippedFiles\n"
}

getFileDiff() {
  local branch=$(git branch -l master main)
  if [[ "${branch##*( )}" == "main" ]]; then
    fileDiff=$(git diff --name-only origin/main)
  else
    fileDiff=$(git diff --name-only origin/master)
  fi
}

collectRubyFiles() {
  setGlobals
  while IFS= read -r line; do
    if [[ "${line}" == *".rb"* ]]; then
      files+="${line} "
      formattedFiles+=" ${line}\n"
      ((counter+=1))
    else
      if ! [[ -z "${line}" ]]; then
        skippedFiles+=" ${line}\n"
        ((skippedCounter+=1))
      fi
    fi
  done <<< "$fileDiff"
}

gemCheck() {
  echo "starting gem check..."
  echo "checking gems locally..."
  bundle check || bundle install
  echo "finished gem check / bundle install!"
}

lint