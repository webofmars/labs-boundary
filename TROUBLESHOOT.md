# TROUBLESHOOTING

## vault local-kms transit

```sh
vault write local-kms/encrypt/root plaintext=$(base64 <<< "my secret data")
```
