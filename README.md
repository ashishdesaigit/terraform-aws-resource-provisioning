# terraform-aws-resource-provisioning

This repo consists of code required to provision aws lambdas using s3 and aws roles.

Terraform provisions following
1.  iam role
2.  iam policy to access different resources
3.  aws dynamodb tables
4.  aws lambda functions

Refer `infra/main.tf` file for details.
Please not that `backend` is configured remotely with `s3`

###Provisioning
You can provision multiple environments. For now here 2 environments are provisioned.
`terraform workspace` commands will come handy

```bash
terraform init
=> Initialises terraform. It can be run many times. no side effect

terraform workspace list
=> default

terraform workspace new qa
=> creates and selects qa workspace

terraform apply
=> creates QA environment with all resources provisioned

terraform workspace new prod
=> creates and selects prod workspace

terraform apply
=> provisions PROD environment with all resources provisioned
```

Once the workspaqces are ready next time you can just select the workspace like :
```bash
terraform workspace select qa
```

In case you are running in CICD following command will come handy
```bash
terraform workspace new qa || terraform workspace select qa
```


###Environment Variables per workspace
`infra/parameters.tf` has all the env variables. For example database names etc.






