#!/usr/bin/env bash
rm -r /home/svc-ata-bitbucket/deploy/*
unzip -d /home/svc-ata-bitbucket/deploy/ agent-training-academy-ui-dev.zip
cp /home/svc-ata-bitbucket/404.html /home/svc-ata-bitbucket/deploy/404.html
cp /home/svc-ata-bitbucket/50x.html /home/svc-ata-bitbucket/deploy/50x.html
sudo find /opt/rh/rh-nginx18/root/usr/share/nginx/html/* -maxdepth 1 -type f -exec chmod 755 {} \;
sudo find /opt/rh/rh-nginx18/root/usr/share/nginx/html/ -maxdepth 1 -type f -delete
sudo find /opt/rh/rh-nginx18/root/usr/share/nginx/html/static/* -exec chmod 755 {} \;
sudo find /opt/rh/rh-nginx18/root/usr/share/nginx/html/ -name "static" -type d -exec chmod 755 {} \;
sudo find /opt/rh/rh-nginx18/root/usr/share/nginx/html/ -name "static" -exec rm -r {} \;
sudo cp -vr /home/svc-ata-bitbucket/deploy/* /opt/rh/rh-nginx18/root/usr/share/nginx/html/
sudo find /opt/rh/rh-nginx18/root/usr/share/nginx/html/* -maxdepth 1 -type f -exec chmod 644 {} \;
sudo find /opt/rh/rh-nginx18/root/usr/share/nginx/html/static/* -exec chmod 644 {} \;
sudo find /opt/rh/rh-nginx18/root/usr/share/nginx/html/ -name "static" -type d -exec chmod 644 {} \;