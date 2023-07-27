# EKS platform configured with external-dns using Terraform

External DNS is a Kubernetes add-on that can automate the management of DNS records based on Ingress and Service resources.

- create an IAM Role that allows an external-dns Kubernetes service account to perform an assumeRole using our EKS OIDC provider
- create a service account for external-dns in Kubernetes that uses the above IAM Role
- create an IAM policy that allows modifying Route53 records and attach it to the above IAM Role
- create a Kubernetes cluster role (following external-dns docs) allowing external-dns to read the necessary information about the ingresses and services, and attach it to the service account with a cluster role binding.
- deploy external-dns with the Helm chart bitnami/external-dns, using the correct parameters.

We deploy our Kubernetes cluster with the EKS Terraform module.
external-dns deployed using Helm chart:
```
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"
```

# Prometheus stack added for EKS monitoring using HELM chart

Prometheus deployed in EKS cluster using Helm chart.
It automatically collects metrics from all Kubernetes components.

It comes pre-configured with some default set of alerting rules and Grafana dashboards.

The helm chart taken from Artifact Hub, which is a web-based application that contains Kubernetes packages. 
```
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
```
