# aidfa-terraform

IaaC written in terraform for Cloud Computing project. For the project, GCP is used as a cloud provider. Terraform part of the project is responsible for:

- Enable all necessary APIs for the project
- Create Artifact Registry for storing docker images (frontend and backend images are pushed to Arifact Registry with CI/CD pipeline in separate repositories for modularity)
- Configure Cloud Run services for frontend and backend with cloud run invokers: public access for frontend and private access for backend
