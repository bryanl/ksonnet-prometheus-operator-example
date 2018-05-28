# ksonnet-prometheus-operator-example

Example demonstrating ksonnet with [coreos/prometheus-operator](https://github.com/coreos/prometheus-operator).

## Notes

* This won't evaluate with ksonnet as of (2018/05/25) due to an issue with [handling binary objects as field keys](https://github.com/ksonnet/ksonnet-lib/issues/142). This should be resolved soon.

To see the output, run the following with jsonnet (>= 0.10.0)

```sh
jsonnet -J lib/v1.9.6/ -J vendor components/kp.jsonnet
```