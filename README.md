# Opsworks commands for Kidslox

## PHP App Server:

### Setup Commands

    go-composer php::setup node::setup logs::config logs::setup

### Configure Commands

	php::ini files::create symfony::parametersnodb symfony::cache apache2::restart
    
### Deploy Commands

	symfony::logs logs::config logs::restart files::create symfony::parametersnodb symfony::permissions node::npm node::bower node::gulp symfony::composer symfony::cache apache2::restart

## Worker:

### Setup Commands

	mod_php5_apache2 go-composer php::setup node::setup resque::setup cron::setup logs::config logs::setup
    
### Configure Commands

	php::configure php::ini files::create symfony::parametersnodb symfony::cache resque::config resque::reload cron::config
    
### Deploy Commands

	deploy::php symfony::logs logs::config logs::restart files::create symfony::parametersnodb symfony::permissions symfony::composer symfony::cache resque::config resque::reload cron::config

### Undeploy Commands

	deploy::php-undeploy

### Shutdown Commands
	
	apache2::stop
