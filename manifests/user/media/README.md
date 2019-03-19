## Configuration

Plex needs this

```
kubectl --namespace=media create secret generic plex-env --from-literal=X_PLEX_TOKEN=<your-plex-token>
```

For the others, click around on their UIs a lot.
