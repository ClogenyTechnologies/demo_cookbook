node.default['windows']['allow_reboot_on_failure'] = true
include_recipe 'windows::reboot_handler'
 
windows_reboot 60 do
  reason 'cause chef said so'
  action :nothing
end
 
batch "echo vars" do
  code "echo %TEMP% %SYSTEMDRIVE% %PATH% %WINDIR%"
  action :run
  notifies :request, 'windows_reboot[60]'
  notifies :run, "ruby_block[EndthisRun]",:immediate
end

ruby_block "EndthisRun" do
  block do
    # exit 1
    raise 'Ending Chef run to reboot after PowerShell installation which required a restart'
  end
  action :nothing
end
