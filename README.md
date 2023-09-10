# Terraform-Wordpress-Website-GCP

In this project, I developed a WordPress blog website on Google Cloud Platform (GCP), harnessing a robust Continuous Deployment (CD) strategy. I integrated the GitHub repository with Google Cloud Source Repositories and incorporated Snyk for Infrastructure as Code (IaC) vulnerability scanning. Using Cloud Build, I orchestrated automated deployments of Terraform code, and with Packer, generated a custom Amazon Machine Image (AMI) configured through Ansible playbooks. This AMI included Cloud Monitoring, Logging Agents, and the OS Configuration Agent for comprehensive VM management.

I provisioned a MySQL instance on GCP's Cloud SQL for data storage and assigned a custom domain via Google Domains. The entire deployment process was streamlined and automated using Google's Cloud Build, resulting in a secure and scalable WordPress website on GCP.

## Application Breakdown

The application is broken down into the architecture below:

![wordpress](https://github.com/rjones18/Images/blob/main/GCP%20Wordpress%20-%20Current.png)



Link to the 3 repos with Cloudbuild:

- [Infrastructure Pipeline](https://github.com/rjones18/GCP-Application-Infrastructure)
- [VPC Pipeline](https://github.com/rjones18/GCP-VPC-Terraform)
- [Database Pipeline](https://github.com/rjones18/GCP-MySQL-DB)

Links to the AMI-Build Repo for this Project:

- [Packer AMI Build](https://github.com/rjones18/GCP-Wordpress-Image-Build) (Being Updated to use Secrets and to setup Pipeline In Cloudbuild)
