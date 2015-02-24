# Opsworks commands for Kidslox

## PHP App Server:

### Setup Commands

    go-composer php::setup node::setup

### Configure Commands

	php::ini files::create symfony::parametersnodb symfony::cache symfony::assetic apache2::restart
    
### Deploy Commands

	symfony::logs files::create symfony::parametersnodb symfony::permissions node::npm node::bower symfony::composer symfony::cache symfony::assetic apache2::restart

## Worker:

### Setup Commands

	mod_php5_apache2 go-composer php::setup node::setup resque::setup cron::setup
    
### Configure Commands

	php::configure php::ini files::create symfony::parametersnodb symfony::cache symfony::assetic resque::config resque::reload cron::config
    
### Deploy Commands

	deploy::php symfony::logs files::create symfony::parametersnodb symfony::permissions node::npm node::bower symfony::composer symfony::cache symfony::assetic resque::config resque::reload cron::config

### Undeploy Commands

	deploy::php-undeploy

### Shutdown Commands
	
	apache2::stop
