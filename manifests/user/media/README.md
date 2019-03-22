## Configuration

Plex needs this [claim token thing](https://www.plex.tv/claim/)

```
kubectl --namespace=media create secret generic plex-env --from-literal=PLEX_CLAIM=<your-plex-claim-token>
```

For the others, click around on their UIs a lot.
