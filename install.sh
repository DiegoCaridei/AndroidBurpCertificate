adb connect
curl http://burp/cert -x localhost:8080 > /tmp/cacert.der
openssl x509 -inform DER -in /tmp/cacert.der -out /tmp/cacert.pem
HASH=$(openssl x509 -inform PEM -subject_hash_old -in /tmp/cacert.pem | head -1)
mv /tmp/cacert.pem /tmp/$HASH.0
git clone https://github.com/Zackptg5/MMT-Extended
#In case the repository no longer exists, you can utilize the following one.: https://github.com/DiegoCaridei/MMT-Extended
cd MMT-Extended
rm customize.sh
cd ..
cp customize.sh MMT-Extended
cd MMT-Extended
mkdir -p ./system/etc/security
rm -rf ./zygisk
rm ./system/placeholder
cd ./system/etc/security
adb pull /system/etc/security/cacerts/ . 
cp /tmp/$HASH.0 ./cacerts/
cd ../../../
zip -9 -r MMT.zip .
adb push MMT.zip /storage/self/primary/Download/
