resource "kubernetes_pod_v1" "app1" {
  metadata {
    name = "my-app1"
    labels = {
      "app" = "app1"
    }
  }

  spec {
    container {
      image = "hashicorp/http-echo"
      name  = "my-app1"
      args  = ["-text=Hello from my app 1"]
    }
  }
}

resource "kubernetes_service_v1" "app1_service" {
  metadata {
    name = "my-app1-service"
  }
  spec {
    selector = {
      app = kubernetes_pod_v1.app1.metadata.0.labels.app
    }
    port {
      port = 5678
    }
  }
}