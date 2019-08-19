#!/bin/sh

hosts=(
    1
    2
    3
    4
    5
    6
    7
    8
    9
    10
    11
    12
    13
    14
    15
    16
    17
    18
    19
    20
    21
    22
    23
    24
    25
)

case $1 in
    "ping" )
        for host in ${hosts[*]}
        do
            ping -c 1 -W 1 192.168.0.$host > /dev/null
            if [ $? -eq 0 ]
            then
                echo "192.168.0.$host up"
            else
                echo "192.168.0.$host down"
            fi
        done
    ;;

    "check" )
        for host in ${hosts[*]}
        do
            nmap -p 22 "192.168.0.$host" | grep "open" > /dev/null
            if [ $? -eq 0 ]
            then
                echo "SSH UP on 192.168.0.$host"
            else
                echo "SSH DOWN on 192.168.0.$host"
            fi
        done
    ;;

    "test" )
        for host in ${hosts[*]}
        do
            ssh root@192.168.0.$host "uname -a" &
        done
    ;;

    "rst" )
        for host in ${hosts[*]}
        do
            ssh root@192.168.0.$host "shutdown -r now" &
        done
    ;;

    "shutdown" )
        for host in ${hosts[*]}
        do
            ssh root@192.168.0.$host "shutdown now" &
        done
    ;;

    "connect" )
        ssh root@192.168.0.$2
    ;;

    * )
        echo "Invalid command"
    ;;
esac