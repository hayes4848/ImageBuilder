1. sudo apt-get update (always!)
2. install dependencies for ruby
  - `sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs`
3. Install RVM (ruby version manager)
  - `sudo apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev`
  - `gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3`
  - `curl -sSL https://get.rvm.io | bash -s stable`
  - `source ~/.rvm/scripts/rvm`
  - `rvm install 2.3.0` (this is the version used in the app)
   