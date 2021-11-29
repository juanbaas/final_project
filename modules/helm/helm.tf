resource "helm_release" "helm_chart" {
  create_namespace = true
  name             = var.release_name
  repository       = var.repository
  namespace        = var.ns_name
  chart            = var.chart
}

resource "helm_release" "kimai" {
  create_namespace = true
  name             = "kimai"
  repository       = "https://robjuz.github.io/helm-charts/"
  namespace        = "prod"
  chart            = "kimai2"
}

resource "kubernetes_namespace" "dev" {
  metadata {
    annotations = {
      name = "dev-namespace"
    }

    labels = {
      mylabel = "dev-namespace"
    }

    name = "dev"
  }
}

resource "kubernetes_namespace" "prod" {
  metadata {
    annotations = {
      name = "prod-namespace"
    }

    labels = {
      mylabel = "prod-namespace"
    }

    name = "prod-demo"
  }
}