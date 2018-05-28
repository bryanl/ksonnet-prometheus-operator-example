local k = import 'k.libsonnet';
local service = k.core.v1.service;
local servicePort = k.core.v1.service.mixin.spec.portsType;

local controllerManagerServicePorts = [
  servicePort.new().withPort(10252).withTargetPort(10252) +
  + service.mixin.metadata.withName('http-metrics'),
];

local schedulerServicePorts = [
  servicePort.new().withPort(10251).withTargetPort(10251) +
  + service.mixin.metadata.withName('http-metrics'),
];

{
  prometheus+: {
    kubeControllerManagerPrometheusDiscoveryService:
      service.new() +
      service.mixin.metadata.withName('kube-controller-manager-prometheus-discovery') +
      service.mixin.metadata.withNamespace('kube-system') +
      service.mixin.metadata.withLabels({ 'k8s-app': 'kube-controller-manager' }) +
      service.mixin.spec.withClusterIp('None') +
      service.mixin.spec.withSelector({ component: 'kube-controller-manager' }) +
      service.mixin.spec.withPorts(controllerManagerServicePorts),
    kubeSchedulerPrometheusDiscoveryService:
      service.new() +
      service.mixin.metadata.withName('kube-scheduler-prometheus-discovery') +
      service.mixin.metadata.withNamespace('kube-system') +
      service.mixin.metadata.withLabels({ 'k8s-app': 'kube-scheduler' }) +
      service.mixin.spec.withClusterIp('None') +
      service.mixin.spec.withSelector({ component: 'kube-scheduler' }) +
      service.mixin.spec.withPorts(schedulerServicePorts),
  },
}
