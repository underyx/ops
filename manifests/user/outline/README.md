```
export CERTIFICATE_NAME=shadowbox-selfsigned-dev
export SB_CERTIFICATE_FILE="cert/${CERTIFICATE_NAME}.crt"
export SB_PRIVATE_KEY_FILE="cert/${CERTIFICATE_NAME}.key"
mkdir cert
declare -a openssl_req_flags=(
  -x509
  -nodes
  -days 36500
  -newkey rsa:2048
  -subj '/CN=localhost'
  -keyout "${SB_PRIVATE_KEY_FILE}"
  -out "${SB_CERTIFICATE_FILE}"
)
openssl req "${openssl_req_flags[@]}"
kubectl create secret tls shadowbox-tls -n outline --key ${SB_PRIVATE_KEY_FILE} --cert ${SB_CERTIFICATE_FILE}
export SHA=$(openssl x509 -noout -fingerprint \
    -sha256 -inform pem -in ${SB_CERTIFICATE_FILE} \
    | sed "s/://g" | sed 's/.*=//')
echo \{\"apiUrl\":\"https://unicorn.underyx.me:54638/api\",\"certSha256\":\"${SHA}\"\}
rm -rf cert
```
