# Opsworks commands for goville

## Setup Commands

    composer symfony::setup resque::setup php::ini

## Configure Commands

    symfony::parameters symfony::cache symfony::assetic resque::config resque::restart

## Deploy Commands

    symfony::logs symfony::parameters symfony::permissions symfony::legacylinks node::npm node::bower symfony::composer symfony::cache symfony::assetic resque::config resque::restart
