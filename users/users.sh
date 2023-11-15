#!/bin/bash

read -r -p "Give users number: " number_user
number_user=$number_user
while [[ $number_user -gt 0 ]]; do
    user_login="user_${number_user}"
    echo "Creating user $user_login"
    sudo useradd -m $user_login
    number_user=$(($number_user - 1))
done

users=`sudo cat /etc/passwd | grep /home | tr ' ' '_'`

function showUsers() { 
    for user in ${users}; do
        echo "User found!"
        login=$(echo $user | cut -d: -f1)
        echo login: $login 
        home=$(echo $user | cut -d: -f6)
        echo home: $home 
        shell=$(echo $user | cut -d: -f7)
        echo shell: $shell 
    done
}

showUsers $users

read -p "Press enter to continue" press;

if $press; then
    for user in ${users}; do
        login=$(echo $user | cut -d: -f1)
        str="user_"
        if grep -q "$str" <<< $login; then 
            echo 'Deteling user:' $login
            $(echo sudo userdel -r $login)
        fi
    done
fi

users=`sudo cat /etc/passwd | grep /home | tr ' ' '_'`
showUsers $users