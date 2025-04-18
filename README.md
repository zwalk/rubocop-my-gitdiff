# rubocop-my-gitdiff
zsh script that will take your files changed in git diff and then run the rubocop linter against them all

it might work in your bashrc, too, but it is meant for a zshrc.

## installation
 add the script as an alias to your .zshrc

 ```shell
 # alias name can be whatever you want
alias rubocopMyGitDiff='/your/path/rubocop-my-gitdiff/rubo-my-gitdiff.sh'
 ```

 To use it the first time, you'll need to run `source ~/.zshrc`, or just open a new terminal window.

To make the script executable, run this in your terminal:
```shell
chmod +x /your/path/rubocop-my-gitdiff/rubo-my-gitdiff.sh
```

## Usage

<sub>note: if you chose a different alias name use that in place of rubocopMyGitDiff</sub>

1. cd into the root directory of whatever git repository you have been working in
2. Make sure you are up to date with the main branch or it will run against extra unnecessary files
3. run `rubocopMyGitDiff`
4. it will use the directory you're currently in from step 1 to find your changed files

 <sub>this will run with the autocorrect feature, so rubocop will fix what it can automatically fix</sub>
