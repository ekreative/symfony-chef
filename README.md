# Opsworks commands for goville

## PHP App Server:

### Setup Commands

    go-composer symfony::setup php::ini

### Configure Commands

	symfony::parametersnodb symfony::cache symfony::assetic
    
### Deploy Commands

	symfony::logs symfony::parametersnodb symfony::permissions symfony::legacylinks node::npm node::bower symfony::composer symfony::cache symfony::assetic

## Resque Worker:

### Setup Commands

	mod_php5_apache2 go-composer symfony::setup resque::setup php::ini
    
### Configure Commands

	php::configure symfony::parametersnodb symfony::cache symfony::assetic resque::config resque::stop

	supervisor to run only manually!
    
### Deploy Commands

	deploy::php symfony::logs symfony::parametersnodb symfony::permissions symfony::legacylinks node::npm node::bower symfony::composer symfony::cache symfony::assetic resque::config resque::stop

	supervisor to run only manually!

### Undeploy Commands

	deploy::php-undeploy

### Shutdown Commands
	
	apache2::stop
