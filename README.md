# poc-static-web-app

[Develop production-scale modern web apps quickly with Azure Static Web Apps](https://azure.microsoft.com/en-us/blog/develop-production-scale-modern-web-apps-quickly-with-azure-static-web-apps/)

## Local Development
To provide a similar experience as to what you get in Azure, where Azure Static Web Apps handles the integration of services for you in the cloud, the Azure Static Web Apps CLI provides the following services:
* A local static site server
* A proxy to the front-end framework development server
* A proxy to your API endpoints - available through Azure Functions Core Tools
* A mock authentication and authorization server
* Local routes and configuration settings enforcement
[Set up local development for Azure Static Web Apps]([https://docs.microsoft.com/en-us/azure/static-web-apps/local-development)

## Configuration

### Domain Name
Azure will auto-generate a domain name (e.g. black-stone-0c0b19f10.1.azurestaticapps.net), but you can configure a custom domain name registered with your DNS provider with a CNAME or TXT record (with code) to confirm domain ownership.

### Private Endpoint
Configuring Static Web Apps with a private endpoint allows you to use a private IP address from your VNet. Once this link is created, your static web app is integrated into your VNet. As a result, your static web app is no longer available to the public internet, and is only accessible from machines within your Azure VNet.
The private endpoint will expose 2 IP Addresses within your VNet, one for the production environment and one for any staging environments.
[Configure private endpoint in Azure Static Web Apps](https://docs.microsoft.com/en-us/azure/static-web-apps/private-endpoint)

### Deployment Types
[Preview environments in Azure Static Web Apps](https://docs.microsoft.com/en-us/azure/static-web-apps/preview-environments)

Preview environments are automatically created when you open a pull request or when you configure your workflow to deploy changes from branches. Once the pull request (PR) is closed, the temporary environment disappears.

#### Production
Changes to production branches are deployed into the production environment. Your custom domain points to this environment, and content served from this location is indexed by search engines.

#### Pull Requests
Pull requests against your production branch deploy to a temporary environment that disappears after the pull request is closed. The URL for this environment includes the PR number as a suffix. For example, if you make your first PR, the preview location looks something like `<DEFAULT_HOST_NAME>-1.<LOCATION>.azurestaticapps.net`.

#### Branch
You can optionally configure your site to deploy every change made to branches that aren't a production branch. This preview deployment is published at a stable URL that includes the branch name. For example, if the branch is named dev, then the environment is available at a location like `<DEFAULT_HOST_NAME>-dev.<LOCATION>.azurestaticapps.net`.

#### Named Environment
You can configure your pipeline to deploy all changes to a named environment. This preview deployment is published at a stable URL that includes the environment name. For example, if the deployment environment is named release, then the environment is available at a location like `<DEFAULT_HOST_NAME>-release.<LOCATION>.azurestaticapps.net`.

### Deployment Token
When you create a new Azure Static Web Apps site, Azure generates a token used to identify the application during deployment. During provisioning, this token is stored as a secret in the GitHub repository in the `AZURE_STATIC_WEB_APPS_API_TOKEN` repository secret.
[Build configuration for Azure Static Web Apps](https://docs.microsoft.com/en-us/azure/static-web-apps/build-configuration?tabs=github-actions)
[Reset deployment tokens in Azure Static Web Apps](https://docs.microsoft.com/en-us/azure/static-web-apps/deployment-token-management)

### Enterprise-Grade Edge
Use Azure Static Web Apps enterprise-grade edge (Preview) to enable faster page loads, enhance security, and optimize reliability for your global applications. Enterprise edge combines the capabilities of Azure Static Web Apps, Azure Front Door, and Azure Content Delivery Network (CDN) into a single secure cloud CDN platform.
[Enterprise-grade edge (Preview)](https://docs.microsoft.com/en-us/azure/static-web-apps/enterprise-edge?tabs=azure-portal)

## Limitations

### Private Endpoint
Placing your application behind a private endpoint means your app is only available in the region where your VNet is located. As a result, your application is no longer available across multiple points of presence.

### Regional Availability
Azure Static Web Apps is a global service. Your app's static assets are globally distributed. When you create your app, you select a region where the managed Azure Functions app is deployed. If you need your Functions app in a region that doesn't support managed functions, you can use the Bring your own Functions app feature with a Functions app you deploy separately.

Static Web Apps are currently only available in the `westus2`, `centralus`, `eastus2`, `westeurope`, and `eastasia` regions. This may be due to where the where the (serverless) backend APIs can be hosted via Azure Function Apps (unverified).
