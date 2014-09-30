template "/etc/php5/apache2/conf.d/50-custom.ini" do
  source "custom.ini.erb"
  mode 0644
  mode 0660
end
