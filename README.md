# Configure vault

## setup

```sh
vault operator init --key-shares=1 --key-threshold=1
vault operator unseal
vault status
```

```sh
export VAULT_ADDR="http://vault.dev.192.168.77.54.nip.io"
export VAULT_TOKEN="xxxxxxxxxxxxxx"
```

```sh
kubectl create secret generic vault-secret --from-literal "VAULT_TOKEN=$VAULT_TOKEN"
```

## made by tf

```sh
vault policy write boundary-controller - # < vault-boundary-policy.hcl
```

```sh
vault token create \
 -no-default-policy=true \
 -policy="boundary-controller" \
 -orphan=true \
 -renewable=false
```

```sh
vault auth enable kubernetes
vault write auth/kubernetes/config \
        kubernetes_host="https://$KUBERNETES_PORT_443_TCP_ADDR:443" \
        token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
        kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt \
        issuer="https://kubernetes.default.svc.cluster.local"
```

```sh
vault write auth/kubernetes/role/boundary \
        bound_service_account_names=boundary \
        bound_service_account_namespaces=labs \
        policies=boundary-controller \
        ttl=24h
```

```sh
boundary scopes create -name 'labs' -scope-id 'global' -recovery-config /boundary/boundary-config-admin.hcl -skip-admin-role-creation -skip-default-role-creation
```

```sh
boundary scopes create -name 'demo' -scope-id xxxx -recovery-config /boundary/boundary-config-admin.hcl -skip-admin-role-creation -skip-default-role-creation
```

```sh
boundary auth-methods create password -name 'password' --description 'Login and password auth method' -scope-id xxxx -recovery-config /boundary/boundary-config-admin.hcl
```

```sh
boundary accounts create password -recovery-config /boundary/boundary-config-admin.hcl -login-name 'admin' -password 'mypassword' -auth-method-id yyyy
```

```sh
boundary users create -recovery-config /boundary/boundary-config-admin.hcl -name "admin" -description "default admin user" -scope-id xxxxx
```

```sh
boundary users add-accounts -recovery-config /boundary/boundary-config-admin.hcl -id xxxxx -account yyyyy
```

```sh
boundary roles create -name 'global_anon_listing' -recovery-config /boundary/boundary-config-admin.hcl -scope-id 'global'
```

```sh
boundary roles add-grants -id <global_anon_listing_id> -recovery-config /boundary/boundary-config-admin.hcl -grant 'id=*;type=auth-method;actions=list,authenticate' -grant 'id=*;type=scope;actions=list,no-op' -grant 'id={{account.id}};actions=read,change-password'
```

```sh
boundary roles add-principals -id <global_anon_listing_id> -recovery-config /boundary/boundary-config-admin.hcl  -principal 'u_anon'
```

```sh
boundary roles create -name 'org_anon_listing' -recovery-config /boundary/boundary-config-admin.hcl -scope-id <org_scope_id>
```

```sh
boundary roles add-grants -id <org_anon_listing_id> -recovery-config /boundary/boundary-config-admin.hcl -grant 'id=*;type=auth-method;actions=list,authenticate' -grant 'type=scope;actions=list' -grant 'id={{account.id}};actions=read,change-password'
```

```sh
boundary roles add-principals -id <org_anon_listing_id> -recovery-config /boundary/boundary-config-admin.hcl -principal 'u_anon'
```

```sh
boundary roles create -name 'org_admin' -recovery-config /boundary/boundary-config-admin.hcl -scope-id 'global' -grant-scope-id <org_scope_id>
```

```sh
boundary roles add-grants -id <org_admin_id> -recovery-config /boundary/boundary-config-admin.hcl -grant 'id=*;type=*;actions=*'
```

```sh
boundary roles add-principals -id <org_admin_id> -recovery-config /boundary/boundary-config-admin.hcl -principal <myuser_user_id>
```

```sh
boundary roles create -name 'project_admin' -recovery-config /boundary/boundary-config-admin.hcl -scope-id <org_scope_id> -grant-scope-id <project_scope_id>
```

```sh
boundary roles add-grants -id <project_admin_id> -recovery-config /boundary/boundary-config-admin.hcl -grant 'id=*;type=*;actions=*'
```

```sh
boundary roles add-principals -id <project_admin_id> -recovery-config /boundary/boundary-config-admin.hcl -principal <myuser_user_id>
```

## Sources

- <https://github.com/hashicorp/learn-boundary-vault-quickstart>
- <https://www.boundaryproject.io/docs/installing/no-gen-resources>
- [Vault as OIDC provider](https://learn.hashicorp.com/tutorials/vault/oidc-identity-provider?in=vault/auth-methods)
- [Boundary Permissions](https://www.boundaryproject.io/docs/concepts/security/permissions#resource-table)
