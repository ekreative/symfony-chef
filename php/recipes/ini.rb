["/etc/php5/apache2"].each do |conf_dir|
  # Dir.mkdir(conf_dir)
  # if Dir.exist? conf_dir
    template "#{conf_dir}/conf.d/50-custom.ini" do
      source "custom.ini.erb"
      mode 0644
      mode 0660
    end
  # end
end

# ["/etc/php5/apache2", "/etc/php5/cli"].each do |conf_dir|
#   Dir.mkdir(conf_dir)
#   if Dir.exist? conf_dir
#     template "#{conf_dir}/conf.d/50-custom.ini" do
#       source "custom.ini.erb"
#       mode 0644
#       mode 0660
#     end
#   end
# end
