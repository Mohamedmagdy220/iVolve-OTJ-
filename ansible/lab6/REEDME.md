# Ansible Roles Setup for Docker, kubectl, and Jenkins

This project demonstrates how to use structured Ansible Roles to install Docker, kubectl, and Jenkins on target machines.

## Requirements

- Ubuntu-based operating system on the target machine.
- Sudo privileges on the remote server.
- Ansible installed on the control machine.

## 📁 Project Structure
The project is organized into 3 main roles:

1. **docker role**: Responsible for installing Docker.
2. **kubectl role**: Responsible for downloading and installing the Kubernetes CLI tool (kubectl).
3. **jenkins role**: Responsible for installing Java and Jenkins, and managing the service.

```
ansible-roles/
├── deploy.yml
├── inventory
└── ansible.cfg
├── docker/
│  └── tasks/
│     └── main.yml
├── kubectl/
│  └── tasks/
│     └── main.yml
└── jenkins/
│   └── tasks/
│      └── main.yml
│    └── vars/
│      └── main.yml
```

## Usage Steps

1. Edit the `inventory` file and specify the remote server's IP and SSH user.
2. Run the main playbook `deploy.yml` to execute all roles.

---

## Important Notes

- Ensure that port 8080 is open on the server to access Jenkins.
- All roles are modular and reusable in other projects.
- You can extend each role with handlers, templates, or variables as needed.

---

## Author

This project is designed to provide a professional and scalable Ansible setup for managing environments through well-defined roles.
