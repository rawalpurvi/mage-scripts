#!/bin/sh

# the script must be run from magento root folder
path="./app/code"

isMage2RootCorrect () {
	if [ ${PWD##*/} = "magento" ]; then
        echo "Script run from correct directory... moving on!"
    elif [ -d "$PATH" ]; then
     	echo "Script run from correct directory... moving on!"
    else 
    	echo "The script must be run from document root and not from "
        exit
    fi
}

echo "Begin bootstraping theme...\n"

# Check for correct root
echo "Checking for correct root folder..."
isMage2RootCorrect
echo "Running from correct root...\n"

# Get the Vendor Name
read -p "Please provide the Vendor Name: " vendor
# echo "$answer"

# Get the Module Name
read -p "Please provide the Module Name: " module
# echo "$answer"

# Creating required directories
cd app

if [ -d "./code" ]; then 
	echo "Creating module directories...\n"
else 
	read -p "Do you want to create /code directory? [y/n]: " yes_no
	if [ "$yes_no" = "y" ]; then
		mkdir "code"
		echo "/code directory created... on to module directories...\n"
	else
		echo "Cannot continue without /code directory! Exiting...\n"
		exit
	fi
fi

# Create Vendor Directory
cd "code"
mkdir "$vendor"
cd "$vendor"

# Create Module Directory
mkdir "$module"
cd "$module"

# Create the first level Directories
mkdir Api Block Controller Helper etc Model view Setup Ui i18n Plugin Test

# Create the required sub-directories
mkdir Controller/Index etc/adminhtml etc/frontend view/adminhtml view/frontend view/frontend/layout view/frontend/templates Plugin/Block Test/Unit

# At this point we are in app/code/Demo/HelloWorld directory

# copy the sample files in appropriate directories
echo "woot! Directories created, on to moving sample files...\n"

cp ./../../../../mage-scripts/samples/module/registration.php .

cp ./../../../../mage-scripts/samples/module/module.xml etc/

cp ./../../../../mage-scripts/samples/module/routes.xml etc/frontend/

cp ./../../../../mage-scripts/samples/module/index.php Controller/Index/

cp ./../../../../mage-scripts/samples/module/helloworld_index_index.xml view/frontend/layout/

cp ./../../../../mage-scripts/samples/module/HelloWorld.php Block/

cp ./../../../../mage-scripts/samples/module/helloworld.phtml view/frontend/templates/

read -p "Do you want to enable the module? [y/n]: " module_yes_no
if [ "$module_yes_no" = "y" ]; then
	echo "Running Setup:upgrade, this may take a few momemnts...\n"
	php ./../../../../bin/magento setup:upgrade
else
	echo "Your module may not be enabled, try running php bin/magento setup:upgrade manually...\n"
	exit
fi 

#If you get the message "Please re-run Magento compile command" then run the following command
echo "Running Magento compile command, this may take a few moments...\n"
php ./../../../../bin/magento setup:di:compile

echo "All set!!! Now go to <your magento store>/Index/index"

# To disable the module, please run the following command
# php bin/magento module:disable --clear-static-content  Demo_HelloWorld


