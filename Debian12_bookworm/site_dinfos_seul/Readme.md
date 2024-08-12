### Project Description: Deploying a Website with Nginx on Debian 12 (Bookworm)

#### Objective
This project aims to install and configure Nginx on a Debian 12 (Bookworm) server to host a simple website. The goal is to provide an automated and reliable method to set up a functional web server accessible via a public IP address.

#### Project Steps

1. **System Update**:
   - Update existing packages to ensure the entire system is up to date.

2. **Nginx Installation**:
   - Install the Nginx web server, a lightweight and high-performance web server.

3. **Nginx Configuration**:
   - Configure the main Nginx file (`nginx.conf`) and the default site file to use the `/var/www/html` directory as the web root.
   - Replace the default server with a customized server using a specified public IP address.

4. **Creating the Directory and HTML File**:
   - Create the `/var/www/html` directory if it does not exist.
   - Add a simple `index.html` file containing a welcome message.

5. **Permission Configuration**:
   - Ensure that the web directory and its files have the correct permissions to be accessible by the web server.

6. **Firewall Configuration**:
   - Configure the firewall to allow SSH and HTTP connections, ensuring the server is secure while being accessible from the outside.

7. **Nginx Verification and Restart**:
   - Verify the Nginx configuration to ensure there are no errors.
   - Restart Nginx to apply all configurations.

8. **Final Verification**:
   - Ensure Nginx is listening on port 80, and verify that the website is accessible via the public IP address.

#### Automated Script
A shell script (`setup_nginx.sh`) is provided to automate all the steps mentioned above. The script cleans any previous Nginx installation, installs Nginx, configures the necessary files, adjusts permissions, configures the firewall, and restarts services to finalize the deployment.

#### Usage
The script is intended for use by system administrators or developers who want to quickly set up a functional web server with Nginx on Debian 12. It simplifies the deployment process by automating repetitive tasks and ensuring that best practices in configuration and security are followed.