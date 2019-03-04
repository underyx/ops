## Configuration

lastfm-thing needs this

```
kubectl --namespace=public create secret generic lastfm-thing-env --from-literal=LASTFM_API_KEY=<your-api-key>
```
