project = "example-nginx-sbd"

runner {
  profile = "sbd-runner"
  data_source "git" {
    url  = "https://github.com/krzysiekb/waypoint-test.git"
    path = "example-sbd"
  }
}

app "example-nginx-sbd" {
  labels = {
    "service" = "example-nginx-sbd",
    "env"     = "dev"
  }

  build {
    use "docker-pull" {
      image = "nginx",
      tag = "latest
    }
  }

  deploy {
    use "kubernetes" {
      namespace = "waypoint-sbd"
      probe_path = "/"
    }
  }

  release {
    use "kubernetes" {
      namespace = "waypoint-sbd"
      port          = 80
    }
  }
}