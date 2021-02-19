#/bin/sh

openssl genrsa -out ca.key 2048
openssl genrsa -out client-key.pem 2048
openssl genrsa -out broker-key.pem 2048

openssl req -x509 -new -sha256  -text -out cacert.pem -key ca.key -config openssl.cnf -extensions v3_ca -days 1095
openssl req -new -sha256  -text -out client.csr -key client-key.pem -config openssl.cnf -extensions v3_req
openssl req -new -sha256 -text -out broker.csr -key broker-key.pem -config openssl.cnf -extensions v3_req

openssl x509 -req -sha256 -extfile openssl.cnf -extensions v3_req -in client.csr -out client.crt -CA cacert.pem -CAkey ca.key -CAcreateserial -days 3650
openssl x509 -in client.crt -text > client-cert.pem
openssl x509 -req -sha256 -extfile openssl.cnf -extensions v3_req -in broker.csr -out broker.crt -CA cacert.pem -CAkey ca.key -CAcreateserial -days 3650
openssl x509 -in broker.crt -text > broker-cert.pem

rm *.crt *.csr *.key *.srl