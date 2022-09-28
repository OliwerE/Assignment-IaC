# Assignment: Infrastructure

You must add a PDF document named `assignment-report.pdf` to this repository root, that answers the following questions:

## Part 1. - Platforms for automatic server configuration

### 1.1. Explain, in your own words (maximum two pages):

- The concept of Infrastructure as Code (IaC).
- The problems that IaC aims to solve and/or benefits that IaC brings to a software project.
- Two types of languages to write IaC.

### 1.2. Describe Terraform (max. 1 page):

- Describe the tool and the problems that it is constructed to solve.
- Provide a list of Pros and Cons of Terraform according to your own experience using it.

### 1.3. Describe Ansible (max. 1 page):

- Describe the tool and the problems that it is constructed to solve.
- Provide a list of the Pros and Cons of Ansible according to your own experience using it.

### 1.4. Practical part

Push to this repository on gitlab.lnu.se the necessary code for Terraform, Ansible, and a shell script called deploy.sh that will allow the Examiner to create a functional webserver on cscloud that can be accessed through a Public IP on port 8081 and that returns the webpage whose HTML code is provided together with this **text by executing only the deploy.sh script**. Some notes:

- See on the file variables.tf the minimum set of variables that you must use; otherwise, the Examiner will not be able to execute your code. Of course, you can use more variables to make the Terraform code more readable.
- Rule to follow: Do not hardcode any of your private information in those files. The Examiner has his own credentials for the provider “Openstack.”.
- The execution of deploy.sh should also output the public IP address to connect. It is OK if you simply use the Terraform “output” value.
- After executing the deploy.sh, a simple “terraform destroy” command should tear down the whole infrastructure.
- The purpose of asking for the deploy.sh script is to give you the freedom to handle the ansible-playbook command inside Terraform execution or as a second command after the “terraform apply -auto- approve” has provisioned the infrastructure.

## Part 2. Continuous Delivery 

### 2.1. Explain, in your own words (max. two pages):

- The problems that Continuous Delivery aims to solve.
- The benefits of applying Continuous Delivery to a software project.
- Four of the basic principles necessary to adopt in a software project to do “Continuous delivery” successfully.
- The difference between Continuous Integration, Continuous Delivery, and Continuous Deployment.

## Hand in via Merge Request

You hand in the assignment by making a Merge Request of your project against the lnu/submit-branch.

Pay extra attention to including a link to your Assignment Report and to assign the MR to the correct Milestone.
