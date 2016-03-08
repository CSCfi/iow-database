#!/bin/bash

if [ ! -d /home/cloud-user/iow-api ]; then
	cd /home/cloud-user/
	git clone https://github.com/CSC-IT-Center-for-Science/iow-api.git
fi

cd /home/cloud-user/iow-api

if git checkout master &&
        git fetch origin master &&
        [ $(git rev-parse HEAD) = $(git ls-remote origin master | cut -f1) ]; then
	echo "iow-api not updated"
else
	git fetch
        git reset --hard origin/master # overwrite local rep
        mvn install "-Dproject.endpoint=http://86.50.169.129" "-Dproject.debug=false"
        sudo cp target/api.war /usr/share/tomcat/webapps
        sudo rm -rf /usr/share/tomcat/webapps/api/
        #sudo systemctl restart tomcat.service
fi

if [ ! -d /home/cloud-user/iow-ui ]; then
        cd /home/cloud-user/
        git clone https://github.com/CSC-IT-Center-for-Science/iow-ui.git
fi

cd /home/cloud-user/iow-ui

if git checkout master &&
       git fetch origin master &&
       [ $(git rev-parse HEAD) = $(git ls-remote origin master | cut -f1) ]; then
        echo "iow-ui not updated"
else
        git fetch
        git reset --hard origin/master
        npm install
        export NODE_ENV=production
	npm run-script build
	sudo cp -R public/* /var/www/html/
fi
