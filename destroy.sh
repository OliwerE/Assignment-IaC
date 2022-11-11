echo "Enter Openstack username:"
read username
export TF_VAR_user_name=$username

echo "Enter Openstack tenant name:"
read tenant
export TF_VAR_tenant_name=$tenant

echo "Enter Openstack password:"
read password
export TF_VAR_password=$password

echo "Init Terraform..."
terraform init

echo "Applying Terraform..."
terraform destroy -auto-approve

echo "Execution has been successful."