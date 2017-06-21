1. `sudo apt-get update` (always!)
2. install dependencies for ruby
  - `sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs`
3. Install RVM (ruby version manager)
  - `sudo apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev`
  - `gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3`
  - `curl -sSL https://get.rvm.io | bash -s stable`
  - `source ~/.rvm/scripts/rvm`
4. Install Ruby   
  - `rvm install 2.3.0` (this is the version used in the app)
5. Set default Ruby
  - `rvm use 2.3.0 --default`
6. Install Bundler
  - `gem install bundler`

7. Install Phusion and passenger
  - `sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7`
  - `sudo apt-get install -y apt-transport-https ca-certificates`
  - `sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger xenial main > /etc/apt/sources.list.d/passenger.list'`
  - `sudo apt-get update`
8. Actually install nginx
  - `sudo apt-get install -y nginx-extras passenger`
9. start the server, verify that it is running. 
  - `sudo service nginx start`

10 edit configuration to point passenger to the version of ruby we are using. 
  - `sudo vim /etc/nginx/nginx.conf`
  - uncomment line with `include /etc/nginx/passenger.conf;` 
  - save and exit
  - `sudo vim /etc/nginx/passenger.conf`
  - edit line `passenger_ruby /home/deploy/.rvm/wrappers/ruby-2.3.0/ruby`
  - `sudo service nginx restart` to make sure changes take effect. 

11.  