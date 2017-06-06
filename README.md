# Chef recipes for Symfony

Chef recipes for running Symfony apps on Opsworks

[![Version](https://img.shields.io/github/release/ekreative/symfony-chef.svg)](https://github.com/ekreative/symfony-chef)
[![GitHub license](https://img.shields.io/github/license/ekreative/symfony-chef.svg)](https://github.com/ekreative/symfony-chef)
[![Build Status](https://travis-ci.org/ekreative/symfony-chef.svg?branch=master)](https://travis-ci.org/ekreative/symfony-chef)

## Recipes

### Apache2

* `apache2::restart` - Restart apache (important to clear the apc cache)

#### Attributes

* `[:apache][:prefork][:maxrequestworkers]` - Default is instance memory / 80Mb
* `[:apache][:log_filter]` - Array of ``{variable => regex}`` pairs to filter from logs, defaults:
  * `{'User-Agent' => 'ELB-HealthChecker'}`
  * `{'User-Agent' => 'Amazon Route 53 Health Check Service'}`
  * `{'Remote_Addr' => '127\.0\.0\.1'}`

### Files

* `files:create` - create files in the app directory from JSON (useful for key files etc)

### Go Composer

* `go-composer` - Install composer

### Logs

* `logs::config` - Create config file for CloudWatch logs (Must be done before the daemon is installed)
* `logs::setup` - Install CloudWatch daemon
* `logs::restart` - Restart CloudWatch daemon

You will need to give your instances permission to access cloud watch logs, this IAM policy on your instance role should work

    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "logs:*"
          ],
          "Resource": [
            "arn:aws:logs:*:*:*"
          ]
        }
      ]
    }

#### Attributes

* `[:logs][:apache]` - enable sending apache logs to CloudWatch logs
* `[:logs][:symfony]` - enable sending symfony logs (prod and dev) to CloudWatch logs

### Metrics

* `metrics::setup` - Setup the CloudWatch monitoring - will report disk usage stats

You will need to give your instances permission to access cloud watch, this IAM policy on your instance role should work

    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "Stmt1441183867000",
                "Effect": "Allow",
                "Action": [
                    "cloudwatch:PutMetricData"
                ],
                "Resource": [
                    "*"
                ]
            }
        ]
    }

### Node

* `node::bower` - Run bower install (bower should be installed using the package.json of the project)
* `node::gulp` - Runs gulp in the application dir (default task)
* `node::npm` - Runs npm install in the application dir
* `node::setup` - Install nodejs/npm (With "legacy" support)

### Yarn

* `yarn::yarn` - Runs yarn install in the application dir
* `yarn::setup` - Install yarn

### Resque

* `resque::config` - Configure workers

### Supervisor

* `supervisor::setup` - Installs supervisor
* `supervisor::reload` - Restart supervisor after a config change

### Symfony

* `symfony::assetic` - assetic:dump --env=prod
* `symfony::cache` - Clear the Symfony cache
* `symfony::composer` - Run composer install in application dir
* `symfony::cron` - Create cron jobs for the Symfony commands in JSON
* `symfony::daemon` - Create supervisor daemons configs for the Symfony commands in JSON
* `symfony::ini` - php.ini settings
* `symfony::logs` - Link Symfony log files into the shared logs folder
* `symfony::migrate` - Run doctrine migrations
* `symfony::parameters` - Create the Symfony parameters files from JSON
* `symfony::permissions` - Set permissions on logs and cache so that apache can write to them
* `symfony::setup` - Install some common php packages

#### Attributes

* `[:symfony][:ini]` - PHP ini settings to add
* `[:symfony][:console]` - The location of the symfony console - *change for Symfony 3+*, default `'app/console'`
* `[:symfony][:logs]` - The location of the symfony logs dir - *change for Symfony 3+*, default `'app/logs'`
* `[:symfony][:cache]` - The location of the symfony cache dir - *change for Symfony 3+*, default `'app/cache'`
* `[:symfony][:writable]` - array of folders that should be writable by the web server - *change for Symfony 3+*, default `['app/cache']`
  * `{'User-Agent' => 'ELB-HealthChecker'}`
  * `{'User-Agent' => 'Amazon Route 53 Health Check Service'}`
  * `{'Remote_Addr' => '127\.0\.0\.1'}`

### Slack

* `slack::notify` - Send a notification to the configured slack hook

#### Attributes

* `[:slack][:hook]` - The slack hook to send to
* `[:slack][:channel]` - Override the channel setting for the hook

## Sample JSON

The top key should match the application name in Opsworks

* `parameters` - your Symfony parameters file - If a database is attached in Opsworks then the parameters `database_*`
will be set automatically.
* `files` - the name and content of any files you need to create, file names are relative to the project directory, or start with a /
* `crons` - the settings for cron jobs that you need to run
  * `command` - the command and arguments
  * `symfony` - default true - means you are running a symfony command, it will be run in `prod`
  * `minute` - cron format for the time to run at, default `*`
  * `hour` - default `*`
  * `day` - default `*`
  * `month` - default `*`
  * `weekday` - default `*`
* `daemons` - the settings for daemons that you need to run
  * `command` - the command and arguments
  * `symfony` - default true - means you are running a symfony command, it will be run in `prod`
  * `name` - a name for your daemon to go in the config
  * `number` - the number of processes to run, default `1`
  * `startretries` - the number of times supervisor attemps to restart the process, default `3`
* `writable` - array of directorys that should be writable by apache
* `resque` - settings for resque - this section must exist for resque to be setup for this app. If this is set then parameters `redis_host`, `redis_port` and `resque_queue` will be set in Symfony
  * `workers` - number of worker, default `node['cpu']['total']`
  * `queue` - queue name, default `default`, multiple queues can be separated with a comma, and the order that they're supplied in is the order that they're checked in.
  * `bin` - location of resque commands, default `bin/resque`
  * `scheduler` - enable resque_scheduler, default `false`
  * `scheduler_bin` - location of scheduler command, default `bin/resque_scheduler`
  * `redis.host` - redis host name, default `localhost`
  * `redis.port` - redis port, default `6379`
  * `app_include` - defaults to `app/bootstrap.php.cache` to make sure annotations are loaded an improve load time
  * `prefix` - set the prefix for all redis keys
  * `interval` - how long, in seconds, to sleep between jobs, default `5`
  * `interval_scheduler` - how long, in seconds, to sleep between checking for scheduled jobs, default `5`
  * `blocking` - if true the worker uses BLPOP to wait for jobs, and `interval` is the timeout, default `false`
* `aliases` - a set of aliases that you want to setup in your virtual host

Sample:

    {
        "my_application": {
            "parameters": {
                "database_driver": "pdo_mysql",
                "database_host": "db.app.com",
                "database_name": "db_name",
                "database_password": "db_pass",
                "database_port": null,
                "database_user": "db_user",
                "custom_param": "my param",
                "locale": "en",
                "mailer_encryption": "tls",
                "mailer_host": "email-smtp.eu-west-1.amazonaws.com",
                "mailer_password": "smtp user secret",
                "mailer_transport": "smtp",
                "mailer_user": "smtp user key",
                "router.request_context.host": "www.app.com",
                "router.request_context.scheme": "https",
                "secret": "Some symfony secret",
            },
            "files": {
                "app/my secret file.pem": "-----BEGIN CERTIFICATE-----\nABCD...EF==\n-----END CERTIFICATE-----"
            },
            "crons": [
                {
                    "name": "My regular command",
                    "command": "app:command",
                    "minute": "1"
                }
            ],
            "daemons": [
                {
                  "command":"app:daemon-cmmand",
                  "name":"app-daemon"
                }
            ],
            "writable": [
                "web/uploads"
            ],
            "resque": {
                "redis": {
                    "host": "localhost",
                    "port": 6379
                },
                "queue": "default",
                "scheduler": true,
                "prefix": "my_app"
            },
            "aliases": [{
                "url_path": "/url",
                "file_path":  "/alternative/path"
            }]
        },
        "thumbor": {
            "key": "This-Is-A-Secret-Key",
            "options": {
                "ALLOW_UNSAFE_URL": false
            }
        },
        "symfony": {
            "ini": {
                "upload_max_filesize": "2M"
            }
        },
        "blackfire": {
            "agent": {
                "server_id": "your-server-id",
                "server_token": "your-server-token"
            }
        },
        "slack": {
            "hook": "https://hooks.slack.com/..."
        }
    }

## Typical PHP App Server layer:

If built on the 'php app layer' settings:

### Setup Commands

    go-composer symfony::setup node::setup logs::config logs::setup metrics::setup blackfire

### Configure Commands

    symfony::ini files::create symfony::parameters symfony::cache apache2::restart

### Deploy Commands

    symfony::logs logs::config logs::restart files::create symfony::parameters symfony::permissions node::npm node::bower node::gulp symfony::composer symfony::assetic symfony::migrate symfony::cache apache2::restart slack::deploy

## Typical Worker layer

If built on the 'custom layer' settings:

### Setup Commands

    go-composer symfony::setup supervisor::setup logs::config logs::setup metrics::setup blackfire

### Configure Commands

    php::configure symfony::ini files::create symfony::parameters symfony::cache symfony::daemon resque::config supervisor::reload symfony::cron

### Deploy Commands

    deploy::php symfony::logs logs::config logs::restart files::create symfony::parameters symfony::permissions symfony::composer symfony::migrate symfony::cache symfony::daemon resque::config supervisor::reload symfony::cron slack::deploy

### Undeploy Commands

    deploy::php-undeploy

## Typical Thumbor layer

If built on the 'custom layer' settings:

### Setup Commands

    thumbor::default

## Testing

So far I have tested a few receipes just using chef solo.

Create a `solo.json` with a run list and other data it requires

    {
      "run_list": [ "recipe[slack::deploy]" ],
      "deploy": {
        "x": {}
      },
      "slack": {
        "hook": "https://hooks.slack.com/..."
      }
    }
    
run it
    
    berks vendor cookbooks
    chef-solo -c solo.rb -j solo.json
