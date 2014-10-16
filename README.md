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

	php::configure symfony::parametersnodb symfony::cache symfony::assetic resque::stop resque::config resque::start
    
### Deploy Commands

	deploy::php symfony::logs symfony::parametersnodb symfony::permissions symfony::legacylinks node::npm node::bower symfony::composer symfony::cache symfony::assetic resque::stop resque::config resque::start
