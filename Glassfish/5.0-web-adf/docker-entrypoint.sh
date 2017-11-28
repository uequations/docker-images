#!/bin/bash
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.
# 
# Copyright (c) 2017 Oracle and/or its affiliates. All rights reserved.
if [[ -z $ADMIN_PASSWORD ]]; then
	ADMIN_PASSWORD=$(date| md5sum | fold -w 8 | head -n 1)
	echo "##########GENERATED ADMIN PASSWORD: $ADMIN_PASSWORD  ##########"
fi

echo "AS_ADMIN_PASSWORD=" > /tmp/glassfishpwd
echo "AS_ADMIN_NEWPASSWORD=${ADMIN_PASSWORD}" >> /tmp/glassfishpwd
asadmin --user=admin --passwordfile=/tmp/glassfishpwd change-admin-password --domain_name domain1

echo "########## Starting Domain ##########"
asadmin start-domain

echo "AS_ADMIN_PASSWORD=${ADMIN_PASSWORD}" > /tmp/glassfishpwd
asadmin --user=admin --passwordfile=/tmp/glassfishpwd enable-secure-admin

asadmin --user=admin --passwordfile=/tmp/glassfishpwd delete-jvm-options "-Xmx512m"
asadmin --user=admin --passwordfile=/tmp/glassfishpwd delete-jvm-options "-XX\:MaxPermSize=192m"

asadmin --user=admin --passwordfile=/tmp/glassfishpwd create-jvm-options "-Xmx2048m"
asadmin --user=admin --passwordfile=/tmp/glassfishpwd create-jvm-options "-XX\:MaxPermSize=512m"
asadmin --user=admin --passwordfile=/tmp/glassfishpwd create-jvm-options "-Doracle.mds.cache=simple"

echo "########## Listing Updated JVM Options ##########"
asadmin --user=admin --passwordfile=/tmp/glassfishpwd list-jvm-options

asadmin --user=admin stop-domain
rm /tmp/glassfishpwd
exec "$@"
