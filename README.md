# Opsworks commands for goville

## Setup Commands

    composer symfony::setup resque::setup

## Configure Commands

    symfony::parameters symfony::cache symfony::assetic resque::config resque::restart

## Deploy Commands

    symfony::log symfony::parameters symfony::permissions symfony::legacylinks node::npm node::bower symfony::composer symfony::cache symfony::assetic resque::config resque::restart
