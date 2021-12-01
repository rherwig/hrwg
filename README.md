## Development
In order to start developing, follow the steps in this section.

### Pre-Requisites
* Docker >= 19.x

### Starting the Application
```bash
docker compose up
```

## Infrastructure
The infrastructure for this project is created by [Terraform](https://terraform.io).

### Pre-Requisites
First, you want to download the latest version of Terraform from the [downloads page](https://www.terraform.io/downloads.html)
and, extract it and add it to your `PATH`.

In order for Terraform to work, you want to create a `terraform.tfvars` file
inside the `terraform/` directory. This file needs to have the following
content:

```hcl
do_token = "<DIGITALOCEAN_TOKEN>"
```

The `DIGITALOCEAN_TOKEN` can be optained via your DigitalOcean web interface.

### Using Terraform
All the following commands are executed from within the `infrastructure/`
directory.

**Initialize Terraform**
```bash
terraform init
```

**Format and validate the configuration**
```bash
terraform fmt
terraform validate
```

**Plan infrastructure changes**
```bash
terraform plan
```

**Apply infrastructure changes**
```bash
terraform apply
```

## Deployment
This project is powered by Docker, thus deployed as containers.

### Creating a Docker Context
```bash
docker context create hrwg --docker "host=ssh://root@hrwg"
```

### Deploying
```bash
docker --context hrwg compose -f docker-compose.yml -f docker-compose.production.yml up -d
```
