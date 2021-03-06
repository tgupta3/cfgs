git clone --bare https://github.com/tgupta3/cfgs.git $HOME/.cfgs
function config {
   /usr/bin/git --git-dir=$HOME/.cfgs/ --work-tree=$HOME $@
}
mkdir -p .config-backup
config checkout -f
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout -f 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
config checkout -f
config config status.showUntrackedFiles no
