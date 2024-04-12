# Project Name

TF Script

## Description

TF Script for provisioning Azure resources. Modulized and config based. Its created in a structure that is specific to my needs, which makes it easier for me to maintain things.

## Table of Contents

- [Structure](#Structure)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Structure

Apended numbers at the beginning of files for organizing types of files for easier maintenance, lowest number being the earliest required files or declarations. 

0 - Earliest prerequisites and config vars. 
  - Config vars have an additional apended value like "L2" this means its a config for resouces that have "2_" apended in the beginning of its name
1 - autovars for the configs
2 and up - module initiate/run codes. Lower number means its doesnt require resources above its number and vice versa
main.tf  - wher you specify which modules to initiate/run

## Usage

In the main.tf we created a map of object called modules, inside them are the descriptive name of what modules are avaialble in this project. 

Values for them are bool. Setting it to "true" would run that specific module, false "would" skip it

Main.tf files inside modules are renamed to the type of resource its for.
E.g storage accounts main.tf file will be modules/storageacct/storageacct.tf

Regarding private endpoints:
There is a module for it, if a resource needs one, add the module call inside the main file of that module and amend codes as required. You can use Storage account and Keyvault as an example.

Need to modify the config var , its own variable and the module call and the main file of that module. e.g

1. Go to L5-7_config_vars to add private endpoint related variables, 
2. Do the same to the modules/storageacct/variables.tf, so that it can accept the values thrown to it later.
3. On the modules/storageacct/storageacct.tf add the module call for the private endpoint and update the parameters thrown to it with the variables we added.
4. on the 5_storage.tf amend the module call and add the required parameter values to be thrown to the storage module.
