# VagrantPress

*VagrantPress* is a packaged development environment for developing WordPress themes and plugins.  
[chadthompson] initially created this project to aid in developing child modules for a WordPress blog. I modified it to use a private ip (rather than a port), move WordPress into a subdirectory, and remove some components I didn't want/need.

# What's Installed

+ Ubuntu Trusty (14.04)
+ Wordpress 4.0
+ Mysql
+ Php
+ Phpmyadmin
+ Subversion
+ Git
+ ~~Composer~~
+ ~~PEAR~~
+ Xdebug
+ ~~PHPUnit - **installed via composer*~~
+ ~~phploc - **installed via composer*~~
+ ~~phpcpd - **installed via composer*~~
+ ~~phpdcd - **installed via composer*~~
+ ~~phpcs - **installed via composer*~~
+ ~~phpdepend - **installed via composer*~~
+ ~~phpmd - **installed via composer*~~
+ ~~PHP_CodeBrowser - **installed via composer*~~
+ ~~WordPress sniffs for phpcs~~
+ ~~WordPress Unit Tests - **installed via composer*~~

# Prerequisites

+ [Vagrant](http://www.vagrantup.com/downloads.html)
+ [Virtualbox](https://www.virtualbox.org/wiki/Downloads)

## Getting Started

This is a fairly simple project to get up and running.  
The procedure for starting up a working WordPress is as follows:

1. Clone the project.  (There’s only master branch.)
2. Run the command `vagrant up` from the directory
3. Open your browser to 10.231.31.31 (or whatever you set that to point to in your hosts file)

## Working with the environment

To log in to the local Wordpress installation:

`http://10.231.31.31/core/wp-admin/` the username is `admin`, the password is `vagrant`.

You can access phpMyAdmin:

`http://10.231.31.31/phpmyadmin/` with username `wordpress`, password `wordpress`.

## A Few Details

* If you're needing a password (for anything - including mysql, it should be `vagrant`)

## Getting Help

Feel free to file an issue, create a pull request, or contact me at [my website][chadthompson].

[chadthompson]: http://chadthompson.me
