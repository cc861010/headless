#!/usr/bin/env bash
### every exit != 0 fails the script
set -e
echo -e "\n------------------ startup of i3wm  window manager ------------------"

# default username and userpassword
name=bear
password=bear

# set user name
if [ $USER_NAME ];then
        name=$USER_NAME
        echo "USER_NAME = $USER_NAME"
else
        echo "USER_NAME = $name"
fi

# set user password
if [ $USER_PASSWORD ];then
        password=$USER_PASSWORD
        echo "USER_PASSWORD = $USER_PASSWORD"
else
        echo "USER_PASSWORD = $password"
fi


# create user
echo "create user.."
if [ $(getent passwd $name) ] ; then
    echo "$name exists!"
else
    useradd -m $name
    adduser $name sudo
    echo -e "${password}\n${password}" | passwd $name
fi

echo "config user.."
xhost +;
xrdb $INST_SCRIPTS/.Xresources
mkdir -p /home/$name/.config/i3
cp $INST_SCRIPTS/config /home/$name/.config/i3
cp $INST_SCRIPTS/.Xresources /home/$name/
chown -R $name /home/$name/.config
/bin/su -l $name -c 'xrdb ~/.Xresources'
usermod -s /bin/bash $name


# login with no-root user
/bin/su -l $name -c '/bin/sh -c i3 &' & pkill xterm && exit

#/bin/su -l $name -c 'i3 &' & exit


echo "i3wm start up with user $name\n..."



