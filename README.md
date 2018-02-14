# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  2.3.3

* Rails version
  5.1.4

* System dependencies
  
   Install phantonJS and add into PATH

     Linux:
    - curl -L -O https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2
    - tar -jxvf phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 phantomjs-$PHANTOMJS_VERSION-linux-x86_64/bin/phantomjs
    - mv phantomjs-$PHANTOMJS_VERSION-linux-x86_64/bin/phantomjs /usr/local/bin/
    - phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 && rm -rf phantomjs-$PHANTOMJS_VERSION-linux-x86_64/bin
    - chmod 755 /usr/local/bin/phantomjs
    
     MacOS:
    - Homebrew: brew install phantomjs
    
    Windows:
    Download the precompiled binary for Windows
    - https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-windows.zip
    
* Gems
  devise;
  rubocop;
  rspec-rails;
  simplecov;
  factory_bot_rails;
  poltergeist

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
