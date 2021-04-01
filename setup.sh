echo "Verifying if 'wine' is installed"
if ! dpkg -s wine > /dev/null; then
	echo "The command 'wine' was not found! Installing it"
	if uname -m | grep '64' > /dev/null; then
		echo "Installing 'wine' for a 64-bit system"
		apt install wine64
	else
		echo "Installing 'wine' for a 32-bit system"
		apt install wine32
	fi
else
	echo "The command 'wine' was found! Proceeding"
fi

EXECUTABLE_DIR=not_found
if find './Among Us.exe' &> /dev/null; then
	EXECUTABLE_DIR=.
else
	if find '../Among Us.exe' &> /dev/null; then
		EXECUTABLE_DIR=..
	fi
fi

if echo $EXECUTABLE_DIR | grep 'not_found'; then
	echo "The 'Among Us.exe' file was not found"
	echo "Please check if it is present in this directory ($(pwd)) or in the directory above."
	echo "Exiting, not successfully"
	exit 1
else
	echo "The 'Among Us.exe' file was found! Proceeding"
fi

echo "Copying files to proper directories"
cp among_us_icon.png /usr/share/icons/
mkdir /opt/AmongUs &> /dev/null
cp -r $(echo $EXECUTABLE_DIR)/* /opt/AmongUs/
cp among-us.desktop /usr/share/applications
