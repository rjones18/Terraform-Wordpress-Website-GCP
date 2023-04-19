# Terraform-Wordpress-Website-GCP

In this project, I employed a diverse range of technologies to develop a WordPress blog website hosted on Google Cloud Platform (GCP). To optimize the deployment process, I established a Continuous Deployment (CD) strategy by seamlessly integrating the GitHub repository with Google Cloud Source Repositories and Snyk for vulnerability monitoring. To automate infrastructure setup, I leveraged Cloud Build to orchestrate the deployment of Terraform code for each infrastructure component. Furthermore, I used Packer to generate a custom Amazon Machine Image (AMI) with pre-installed packages, utilizing Ansible playbooks.

For storing user posts, I provisioned a MySQL database instance on GCP's MySQL Database service. I also integrated Google Domains to assign a custom domain name to the website. All these components were orchestrated and deployed using Cloud Build, a renowned continuous integration and delivery platform. By harnessing this technology stack, I successfully automated and streamlined the entire deployment process, culminating in a scalable and secure WordPress website hosted on GCP.

## Application Breakdown

The application is broken down into the architecture below:

![wordpress](https://github.com/rjones18/Images/blob/main/Cloud%20architecture%20with%20costs%20example%20-%20Current.png)



Links to the AMI-Build Repo for this Project:

- [Packer AMI Build](https://github.com/rjones18/GCP-Wordpress-AMI-Build)
