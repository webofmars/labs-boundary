# TROUBLESHOOTING

## vault local-kms transit

```sh
vault write local-kms/encrypt/recovery plaintext=$(base64 <<< "my secret data")
vault write local-kms/decrypt/recovery ciphertext="vault:v1:XX/XX/XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX==" | base64 --decode
```
