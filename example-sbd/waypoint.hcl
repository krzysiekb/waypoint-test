project = "example-nodejs-sbd"

runner {
  profile = "sbd-runner"
  data_source "git" {
    url  = "https://github.com/krzysiekb/waypoint-test.git"
    path = "example-sbd"
  }
}

app "example-nodejs-sbd" {
  labels = {
    "service" = "example-nodejs-sbd",
    "env"     = "dev"
  }

  build {
    use "pack" {}
    registry {
      use "docker" {
        image = "example-nodejs"
        tag   = "1"
        local = true
      }
    }
  }

  deploy {
    use "kubernetes" {
      probe_path = "/"
    }
  }

  release {
    use "kubernetes" {
      // Sets up a load balancer to access released application
      load_balancer = true
      port          = 3000
    }
  }
}