# Introduction

This sample shows how an application can read configuration from a keyvault rather than a local appsettings file.  This improves security in the running of the application but also in the development of the application as there is a lower chance of commiting sensitive data into a source code repository.  

It also means that access to sensitive values may be controlled in the cloud centrally.

The application loads the configuration from the local `appsettings.json` and the cloud keyvault specified in the configuration file.  

The application then attempts to read and print the test values from configuration.

If the cloud vault exists it will override the values read form the .json file.  

The `terraform` folder stores the scripts to build the Azure resources required for the sample if you want to pull configuration from a keyvault.




> There is scope to create a .ps1 or .sh file to run the terraform scripts and set the `appsettings.json` keyvault address, but I have not done so yet.