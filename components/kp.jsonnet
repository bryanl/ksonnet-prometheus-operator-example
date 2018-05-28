local x1 = import 'kube-prometheus/prometheus-operator/kube-prometheus.libsonnet';
local x2 = import 'kube-prometheus/prometheus-operator/kube-prometheus-kubeadm.libsonnet';
local x3 = import 'kube-prometheus/prometheus-operator/kube-prometheus-node-ports.libsonnet';

local kp =
    x1 + x2 + x3 +
    {
        _config+:: {
        namespace: 'monitoring',
        },
    };

local objects =
    { ['00namespace-' + name]: kp.kubePrometheus[name] for name in std.objectFields(kp.kubePrometheus) } +
    { ['0prometheus-operator-' + name]: kp.prometheusOperator[name] for name in std.objectFields(kp.prometheusOperator) } +
    { ['node-exporter-' + name]: kp.nodeExporter[name] for name in std.objectFields(kp.nodeExporter) } +
    { ['kube-state-metrics-' + name]: kp.kubeStateMetrics[name] for name in std.objectFields(kp.kubeStateMetrics) } +
    { ['alertmanager-' + name]: kp.alertmanager[name] for name in std.objectFields(kp.alertmanager) } +
    { ['prometheus-' + name]: kp.prometheus[name] for name in std.objectFields(kp.prometheus) } +
    { ['grafana-' + name]: kp.grafana[name] for name in std.objectFields(kp.grafana) };

[ objects[key] for key in std.objectFields(objects) ]