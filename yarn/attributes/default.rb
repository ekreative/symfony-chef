default[:yarn][:packages] = ['yarn']
default[:yarn][:source][:key] = 'https://dl.yarnpkg.com/debian/pubkey.gpg'
default[:yarn][:source][:deb] = 'deb https://dl.yarnpkg.com/debian/ stable main'
default[:yarn][:source][:rpm] = 'https://dl.yarnpkg.com/rpm/yarn.repo'
