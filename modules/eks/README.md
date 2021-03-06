# EKS Module

## Issues and fixes

<b>Issue 1: When installing GItLab Runner from the GitLab Kubernetes admin page I get `Something went wrong while installing GitLab Runner Operation timed out. Check pod logs for install-runner for more details.`</b>

Inspecting the issue
* To debug this issue, I ran `kubectl get pods -n  gitlab-managed-apps` and found out that the `STATUS` was `PENDING`
* I then ran `kubectl describe pod install-runner  -n  gitlab-managed-apps ` and saw that the error message was `no nodes available to schedule pods`

Fix:
* Create a `aws_eks_node_group` and attach it to the `aws_eks_cluster`. This explicitly creates a node group to launch the pods in

<b>Issue 2: After setting up EKS installing the runner, destroying EKS and then installing the runner again, the admin/Runners page has a 500 error</b>

This [link](https://stackoverflow.com/questions/54216933/internal-server-error-500-while-accessing-gitlab-admin-runners) contained the fix. Supported by [oddicial documentation](https://docs.gitlab.com/ee/raketasks/backup_restore.html#reset-runner-registration-tokens)

Fix: On the GitLab instance, run the following

```bash
gitlab-rails dbconsole

# Once inside the DB after entering the RDS DB password
UPDATE projects SET runners_token = null, runners_token_encrypted = null;
UPDATE namespaces SET runners_token = null, runners_token_encrypted = null;
UPDATE application_settings SET runners_registration_token_encrypted = null;
UPDATE ci_runners SET token = null, token_encrypted = null;
```

## Additional details

<b>Detail 1: Creating the Amazon EKS cluster role</b>

This [link](https://docs.aws.amazon.com/eks/latest/userguide/service_IAM_role.html#create-service-role) has a sample CloudFormation script that was easy to convert to Terraform

<b>Detail 2: Manual part of setup</b>

This is the [link](https://docs.gitlab.com/ee/user/project/clusters/add_remove_clusters.html#add-existing-clusterhttps://docs.gitlab.com/ee/user/project/clusters/add_remove_clusters.html#add-existing-cluster) specifying how to add a cluster to GitLab

Steps

1. This [link](https://docs.aws.amazon.com/cli/latest/reference/eks/update-kubeconfig.html) details how to configure kubectl so that you can connect to an Amazon EKS cluster. Run the following command to add the context to `.kube\config`. If `aws configure` wasn't used to set the region, use the `--region` flag in the command below. Use the name of the EKS cluster that was created
```bash
aws eks update-kubeconfig --name gitlab
<<'OUTPUT'
  Added new context arn:aws:eks:ap-southeast-1:<AWS_ACCOUNT_ID>:cluster/gitlab to C:\Users\<OS_USER>\.kube\config

OUTPUT
```  
2. Run the following to execute the yaml file provided
```bash
kubectl apply -f gitlab-admin-service-account.yaml
<<'OUTPUT'
  serviceaccount/gitlab-admin created
  clusterrolebinding.rbac.authorization.k8s.io/gitlab-admin created

OUTPUT
```  
3. Run the following command. Note that it does not work in a Windows command prompt
```bash
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep gitlab-admin | awk '{print $1}')
<<'OUTPUT'
Name:         gitlab-admin-token-sxpsp
Namespace:    kube-system
Labels:       <none>
Annotations:  kubernetes.io/service-account.name: gitlab-admin
              kubernetes.io/service-account.uid: 9190e371-3d5b-4c41-9713-6af39b08ead8

Type:  kubernetes.io/service-account-token

Data
====
namespace:  11 bytes
token:      REDACTED_TOKEN
ca.crt:     1025 bytes

OUTPUT
```

4. Run the following commands to get the CA certificate. Be sure to enter the full details into GitLab including the `-----BEGIN CERTIFICATE-----` and `-----END CERTIFICATE-----` part
```bash
kubectl get secrets
<<'OUTPUT'
NAME                  TYPE                                  DATA   AGE
default-token-hqn4r   kubernetes.io/service-account-token   3      77m

OUTPUT

kubectl get secret <secret name> -o jsonpath="{['data']['ca\.crt']}" | base64 --decode
<<'OUTPUT'
-----BEGIN CERTIFICATE-----
REDACTED CERTIFICATE DETAILS
-----END CERTIFICATE-----

OUTPUT
```

To simplify the above, I created a helper script `utility.sh`. Remember to make the file executable with `chmod +x utility.sh`

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ingress\_security\_group\_id | The security group id of the security group that is allowed all ingress | `string` | n/a | yes |
| subnet\_ids | The list of private subnet ids | `list(string)` | n/a | yes |
| vpc\_id | The id of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| endpoint | The endpoint for your Kubernetes API server |
| security\_group\_id | The id of the default security group associated with the eks cluster |

