bash 'InstallWeblogic' do
	cwd '/'
	code <<-EOH
	  java -jar -d64 /home/user/fmw_12_1_3_0_0_wls_generic.jar -silent -responseFile /home/user/WebLogic/OraInventory/response.rsp -invPtrLoc /home/user/WebLogic/OraInventory/oraInst.loc
	  EOH
end
