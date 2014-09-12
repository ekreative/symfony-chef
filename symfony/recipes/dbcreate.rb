node[:deploy].each do |app_name, deploy|
  execute "drop" do
      group deploy[:group]
      if platform?("ubuntu")
          user "www-data"
      elsif platform?("amazon")
          user "apache"
      end

      cwd "#{deploy[:deploy_to]}/current"
      command "#{deploy[:deploy_to]}/current/bin/console doctrine:database:drop --force --env=prod"
  end
  execute "drop" do
        group deploy[:group]
        if platform?("ubuntu")
            user "www-data"
        elsif platform?("amazon")
            user "apache"
        end

        cwd "#{deploy[:deploy_to]}/current"
        command "#{deploy[:deploy_to]}/current/bin/console doctrine:database:create --env=prod"
    end
    execute "drop" do
      group deploy[:group]
      if platform?("ubuntu")
          user "www-data"
      elsif platform?("amazon")
          user "apache"
      end

      cwd "#{deploy[:deploy_to]}/current"
      command "#{deploy[:deploy_to]}/current/bin/console doctrine:schema:update --force --env=prod"
  end
  execute "drop" do
        group deploy[:group]
        if platform?("ubuntu")
            user "www-data"
        elsif platform?("amazon")
            user "apache"
        end

        cwd "#{deploy[:deploy_to]}/current"
        command "#{deploy[:deploy_to]}/current/bin/console doctrine:fixtures:load --no-interaction --env=prod"
    end
end
