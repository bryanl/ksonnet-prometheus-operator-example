local k = import 'k.libsonnet';
local service = k.core.v1.service;
local servicePort = k.core.v1.service.mixin.spec.portsType;

{
  prometheus+: {
    service+:
      service.mixin.spec.withPorts(servicePort.new().withPort(9090).withTargetPort('web').withName('web').withNodePort(30900)) +
      service.mixin.spec.withType('NodePort'),
  },
  alertmanager+: {
    service+:
      service.mixin.spec.withPorts(servicePort.new().withPort(9093).withTargetPort('web').withName('web').withNodePort(30903)) +
      service.mixin.spec.withType('NodePort'),
  },
  grafana+: {
    service+:
      service.mixin.spec.withPorts(servicePort.new().withPort(3000).withTargetPort('http').withName('http').withNodePort(30902)) +
      service.mixin.spec.withType('NodePort'),
  },
}
