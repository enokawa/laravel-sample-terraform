# laravel-sample-terraform

## deploy

```shell
$ tfenv install
$ terraform init
$ terraform apply
```

## Create ECS(Fargate) resources

```shell
$ aws ecs create-cluster \
--cluster-name sample-cluster \
--tags "key=Name,value=sample-cluster" \
--settings "name=containerInsights,value=enabled"
```
