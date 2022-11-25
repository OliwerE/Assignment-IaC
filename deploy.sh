if [ -z $OS_USERNAME ] || [ -z $OS_PROJECT_NAME ] || [ -z $OS_PASSWORD ] || [ -z $OS_AUTH_URL ]; then
  echo "Log into openstack using your rc file before running this script!"
  echo "Example: '. my-openrc.sh'"
else
  if [ -z $TF_VAR_key_name ]; then
    echo "Export variable 'TF_VAR_key_name' before running this script!"
    echo "Example: 'export TF_VAR_key_name=my-key'"
  elif [ -z $TF_VAR_identity_file ]; then
    echo "Export variable 'TF_VAR_identity_file' before running this script!"
    echo "Example: 'export TF_VAR_identity_file=~/.ssh/my-key'"
  else
    # Set Terraform variables
    export TF_VAR_os_username=$OS_USERNAME
    export TF_VAR_os_tenant_name=$OS_PROJECT_NAME
    export TF_VAR_os_password=$OS_PASSWORD
    export TF_VAR_os_auth_url=$OS_AUTH_URL

    echo "Init Terraform..."
    terraform init

    echo "Applying Terraform and Ansible..."
    terraform apply -auto-approve
  fi
fi