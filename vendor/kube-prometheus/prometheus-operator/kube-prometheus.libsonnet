local k = import 'k.libsonnet';

(import 'kube-prometheus/grafana/grafana.libsonnet') +
(import 'kube-prometheus/prometheus-operator/kube-state-metrics/kube-state-metrics.libsonnet') +
(import 'kube-prometheus/prometheus-operator/node-exporter/node-exporter.libsonnet') +
(import 'kube-prometheus/prometheus-operator/alertmanager/alertmanager.libsonnet') +
(import 'kube-prometheus/prometheus-operator/prometheus-operator/prometheus-operator.libsonnet') +
(import 'kube-prometheus/prometheus-operator/prometheus/prometheus.libsonnet') +
(import 'kube-prometheus/kubernetes-mixin/mixin.libsonnet') + {
  kubePrometheus+:: {
    namespace: k.core.v1.namespace.new($._config.namespace),
  },
} + {
  _config+:: {
    namespace: 'default',

    kubeStateMetricsSelector: 'job="kube-state-metrics"',
    cadvisorSelector: 'job="kubelet"',
    nodeExporterSelector: 'job="node-exporter"',
    kubeletSelector: 'job="kubelet"',
    notKubeDnsSelector: 'job!="kube-dns"',

    prometheus+:: {
      rules: $.prometheusRules + $.prometheusAlerts,
    },

    grafana+:: {
      dashboards: $.grafanaDashboards,
    },
  },
}
