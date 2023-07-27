module "kube" {
  source = "./kube-prometheus"
  kube-version = "36.2.0"
}