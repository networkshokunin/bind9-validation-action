#!/bin/bash        
set -ex


if [ -z "$(which named-checkzone)" ]; then
    echo "named-checkzone is missing. Ensure you have the bindtools installed."
    exit 1
fi

if [ -z "$(which named-checkconf)" ]; then
    echo "named-checkconf is missing. Ensure you have the bind installed."
    exit 1
fi

#checking zone files
find . -type f -name 'db.*' |
while read zonefile; do
    # Use grep to find the $ORIGIN line and cut to extract the domain name
    zone=$(grep '$ORIGIN' "$zonefile" | awk '{print $2}' | sed 's/\.$//')
    named-checkzone -d -k fail -n fail -m fail -M fail $zone $zonefile

    if [ $? -ne 0 ]; then
        exit $?
    fi
done

#checking named config files
find . -type f -name 'named*.conf' |
while read namedconf; do
    named-checkconf -c $namedconf
    if [ $? -ne 0 ]; then
        exit $?
    fi
done

exit
