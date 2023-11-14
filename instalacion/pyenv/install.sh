cat ../ucv.txt

sudo bash -c "echo -e 'Comenzando...\n'"

sudo apt-get update;
# install most common python interpreter itself compile dependencies
sudo apt-get install aria2 build-essential curl git libbz2-dev libffi-dev liblzma-dev libncurses5-dev libncursesw5-dev libreadline-dev libsqlite3-dev libssl-dev llvm make tk-dev wget xz-utils zlib1g-dev --yes;

curl https://pyenv.run | bash
