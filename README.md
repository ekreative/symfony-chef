# Chef recipes for Symfony

## Recipes

### Apache2

* `apache2::restart` - Restart apache (important to clear the apc cache)

### Files

* `files:create` - create files in the app directory from JSON (useful for key files etc)

### Go Composer

* `go-composer` - Install composer

### Logs

* `logs::config` - Create config file for CloudWatch logs (Must be done before the daemon is installed)
* `logs::setup` - Install CloudWatch daemon
* `logs::restart` - Restart CloudWatch daemon

### Node

* `node:bower` - Run bower install (bower should be installed using the package.json of the project)
* `node:gulp` - Runs gulp in the application dir (default task)
* `node:npm` - Runs npm install in the application dir
* `node::setup` - Install nodejs/npm (With "legacy" support)

### Resque

* `resque::setup` - Installs supervisor
* `resque::config` - Configure workers
* `resque::reload` - Restart supervisor after a config change

### Symfony

* `symfony::assetic` - assetic:dump --env=prod
* `symfony::cache` - Clear the Symfony cache
* `symfony::composer` - Run composer install in application dir
* `symfony::cron` - Create cron jobs for the Symfony commands in JSON
* `symfony::ini` - php.ini settings
* `symfony::logs` - Link Symfony log files into the shared logs folder
* `symfony::migrate` - Run doctrine migrations
* `symfony::parameters` - Create the Symfony parameters files from JSON
* `symfony::permissions` - Set permissions on logs and cache so that apache can write to them
* `symfony::setup` - Install some common php packages

## Sample JSON

The top key should match the application name in Opsworks

* `parameters` - your Symfony parameters file - If a database is attached in Opsworks then the parameters `database_*`
will be set automatically.
* `files` - the name and content of any files you need to create
* `crons` - the settings for cronjobs that you need to run
* `writable` - array of directorys that should be writable by apache
* `resque` - settings for resque - this section must exist for resque to be setup for this app.
If this is set then parameters `redis_host`, `redis_port` and `redis_queue` will be set in Symfony
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
            "writable": [
                "web/uploads"
            ],
            "resque": {
                "workers": 1,
                "redis": {
                    "host": "localhost",
                    "port": 6379
                },
                "queue": "default",
                "scheduler": true,
                "bin": 'bin/resque',
                "scheduler_bin": 'bin/resque_scheduler'
            },
            "aliases": [{
                "url_path": "/url",
                "file_path":  "/alternative/path"
            }]
        }
    }

## Typical PHP App Server:

If built on the 'php app layer' settings:

### Setup Commands

    go-composer symfony::setup node::setup logs::config logs::setup

### Configure Commands

    symfony::ini files::create symfony::parameters symfony::cache apache2::restart

### Deploy Commands

	  symfony::logs logs::config logs::restart files::create symfony::parameters symfony::permissions node::npm node::bower node::gulp symfony::composer symfony::assetic symfony::migrate symfony::cache apache2::restart

## Typical Worker layer

If built on the 'custom layer' settings:

### Setup Commands

	  mod_php5_apache2 go-composer symfony::setup resque::setup logs::config logs::setup

### Configure Commands

	  php::configure symfony::ini files::create symfony::parameters symfony::cache resque::config resque::reload symfony::cron

### Deploy Commands

	  deploy::php symfony::logs logs::config logs::restart files::create symfony::parameters symfony::permissions symfony::composer symfony::migrate symfony::cache resque::config resque::reload symfony::cron

### Undeploy Commands

	  deploy::php-undeploy

### Shutdown Commands

	  apache2::stop
