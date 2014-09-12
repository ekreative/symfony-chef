execute "stop" do
  command "service supervisor stop"
end
execute "start" do
  command "service supervisor start"
end
