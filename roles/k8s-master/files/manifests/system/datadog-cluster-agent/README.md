## Configuration

```
kubectl --namespace=kube-system create secret generic datadog-api-key --from-literal=key=<your-api-key>
kubectl --namespace=kube-system create secret generic datadog-auth-token --from-literal=token=<32-character-random-token>
```
