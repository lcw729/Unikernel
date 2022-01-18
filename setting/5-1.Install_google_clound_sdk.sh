curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-367.0.0-linux-x86_64.tar.gz
tar -zxvf google-cloud-sdk-367.0.0-linux-x86_64.tar.gz
rm google-cloud-sdk-367.0.0-linux-x86_64.tar.gz
./google-cloud-sdk/install.sh
cp -r ./google-cloud-sdk/bin/* /bin
cp -r ./google-cloud-sdk/lib/* /lib
./google-cloud-sdk/bin/gcloud init


