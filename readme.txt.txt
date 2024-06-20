06-07-2024 EPP7.5 
Fixed ASAI WAIT screen for EPP7.5
Fixed Main_Menu, Diagnostic_Printer menu
Added Restart kiosk script


03-12-2024 
A new kiosk parameter needs to be created for DN100 and 5500 machines.
Create parameter '5500_old_print_mode' in 'Station_parameters' table
with the following value:
'macros' for DN100 machines
'plane' for old 5500 machines
It is not necessary to create the parameter for Cash Stream machines

02-23-3034 Last Transactions
Create the following Casino parameters into LiveOffice:
last_trx_limit: 10
last_sp_limit: 10