# Opsworks commands for goville

## PHP App Server:

### Setup Commands

    go-composer symfony::setup

### Configure Commands

	php::ini symfony::parametersnodb symfony::cache symfony::assetic
    
### Deploy Commands

	symfony::logs symfony::parametersnodb symfony::permissions symfony::legacylinks node::npm node::bower symfony::composer symfony::cache symfony::assetic

## Resque Worker:

### Setup Commands

	mod_php5_apache2 go-composer symfony::setup resque::setup
    
### Configure Commands

	php::configure php::ini symfony::parametersnodb symfony::cache symfony::assetic resque::config resque::stop

	run supervisor ONLY manually!
    
### Deploy Commands

	deploy::php symfony::logs symfony::parametersnodb symfony::permissions symfony::legacylinks node::npm node::bower symfony::composer symfony::cache symfony::assetic resque::config resque::stop

	run supervisor ONLY manually!

### Undeploy Commands

	deploy::php-undeploy

### Shutdown Commands
	
	apache2::stop
