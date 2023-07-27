# EKS platform configured with external-dns using Terraform

ExternalDNS synchronizes exposed Kubernetes Services and Ingresses with DNS providers.
External DNS will automatically create the necessary DNS records in your external DNS server (like Route 53 in AWS).

For every hostname that you use in Ingress - it will create a new record to send traffic to your load balancer.

Setup:
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

# Route 53

Created a public hosted zone : priyanka.com

# Deploy the Ingress resource and app


Ingress exposes HTTP and HTTPS routes from outside the cluster to services within the cluster. Traffic routing is controlled by rules defined on the Ingress resource.
An Ingress controller is responsible for fulfilling the Ingress, usually with a load balancer.

nginx-ingress-controller
```
 repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"
```

The helm chart will create in a default namespace 2 replicas, 2 deployments, 2 pods, and 2 services for the Nginx ingress controller we will use that service with the type of Load balancer, and that LB will listen on ports 80 and 443 to expose our application from the internet.

```
To check : kubectl port-forward <pod> 5678:5678

kubectl get all -n ingress-nginx
kubectl get all -n kube-system
kubectl get all -n monitoring

kubectl logs deployment.apps/ingress-nginx-controller -n ingress-nginx
```
