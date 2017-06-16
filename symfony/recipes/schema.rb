node[:deploy].each do |app_name, deploy|
  execute "assetic" do
      group deploy[:group]
      if platform?("ubuntu")
          user "www-data"
      elsif platform?("amazon")
          user "apache"
      end

      if app_name == "browni"
          cwd "#{deploy[:deploy_to]}/current"
          command "#{deploy[:deploy_to]}/current/app/console doctrine:schema:update --dump-sql --force"
      end
  end
end
