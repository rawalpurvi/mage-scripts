#!/bin/sh

#the script must be run from magento root folder
path="./app/design"

isMage2RootCorrect () {
	if [ ${PWD##*/} = "magento" ]; then
		echo "Script run from correct directory... moving on!"
	elif [ -d "$PATH" ]; then
		echo "Script run from correct directory... moving on!"
	else
		echo "The script must be run from document root and not from"
		exit
	fi					
}

echo "Begin bootstraping theme...\n"

#Check for correct root
echo "Checking for correct root folder..."
isMage2RootCorrect
echo "Running from correct root...\n"

#Get the Vendor Name
read -p "Please provide the Vendor Name: " vendor
#echo "$answer"

#Get the Theme Name
read -p "Please provide the Theme name: " theme

#Get into frontend Directory
cd app/design/frontend

#create Vendor Direcotory
mkdir "$vendor"
cd "$vendor"

# create Theme Directory
mkdir $theme
cd "$theme"

#create the first level directories
mkdir etc Magento_Theme media web

#create the required sub-directories
mkdir Magento_Theme/layout web/css web/css/source web/fonts web/images web/js

#at this point we are in app/design/frontend/DemoStore/SampleTheme directory
echo "woot! Directories created, on to moving sample files...\n"

cp ./../../../../../mage-scripts/samples/theme/composer.json .

cp ./../../../../../mage-scripts/samples/theme/registration.php .

cp ./../../../../../mage-scripts/samples/theme/theme.xml .

cp ./../../../../../mage-scripts/samples/theme/view.xml etc/

cp ./../../../../../mage-scripts/samples/theme/default.xml Magento_Theme/layout/

cp ./../../../../../mage-scripts/samples/theme/preview.jpg media/

cp ./../../../../../mage-scripts/samples/theme/woody.jpeg web/images/

php ./../../../../../bin/magento setup:static-content:deploy

read -p "Do you want to run setup:upgrade? [y/n]: " module_yes_no
if [ "$module_yes_no" = "y" ]; then
	echo "Running Setup:upgrade, this may take a few momemnts...\n"
	php ./../../../../../bin/magento setup:upgrade
else
	echo "Your module may not be enabled, try running php bin/magento setup:upgrade manually...\n"
	exit
fi 

#If you get the message "Please re-run Magento compile command" then run the following command
echo "Running Magento compile command, this may take a few moments...\n"
php ./../../../../../bin/magento setup:di:compile

echo "All set!!! Now go to magento/admin site and configure new theme and set new theme as default. see the new logo on your magento site."
# This is the way 



