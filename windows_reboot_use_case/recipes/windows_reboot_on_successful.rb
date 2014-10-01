
include_recipe 'windows::reboot_handler'
 
windows_reboot 60 do
  reason 'cause chef said so'
  action :nothing
end
 
batch "echo vars" do
  code "echo %TEMP% %SYSTEMDRIVE% %PATH% %WINDIR%"
  action :run
  notifies :request, 'windows_reboot[60]'
end
