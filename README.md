# Configure vault

## setup

```sh
./up.sh
./00-init.sh
./01-pg.sh
./02-vault.sh
./03-boundary.sh
```

```sh
vault operator init --key-shares=1 --key-threshold=1
vault operator unseal
vault status
```

```sh
export VAULT_ADDR="http://vault.dev.134.209.133.207.nip.io"
export VAULT_TOKEN="xxxxxxxxxxxxxx"
```

```sh
kubectl create secret -n labs generic vault-secret --from-literal "VAULT_TOKEN=$VAULT_TOKEN"
```

## setup vault requirements for boundary

```sh
cd terraform/01-vault-setup
# edit terraform.tfvars
terraform init
terraform apply
```

## setup boundary server

```sh
# edit .secrets/recovery.hcl to reflect your vault addr
```

```sh
cd terraform/02-boundary-setup
# edit terraform.tfvars
terraform init
terraform apply
```

## Sources

- <https://github.com/hashicorp/learn-boundary-vault-quickstart>
- <https://www.boundaryproject.io/docs/installing/no-gen-resources>
- [Vault as OIDC provider](https://learn.hashicorp.com/tutorials/vault/oidc-identity-provider?in=vault/auth-methods)
- [Boundary Permissions](https://www.boundaryproject.io/docs/concepts/security/permissions#resource-table)
