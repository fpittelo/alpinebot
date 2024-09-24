Azure App Service Module 🚀🌟
Welcome to the App Service Adventure module! Launch your application into the Azure cosmos with the finesse of an astronaut sipping coffee in zero gravity. ☕🪐

This Terraform module sets up an Azure App Service and App Service Plan, so your app can boldly go where no app has gone before.

Features 🛰️
App Service Plan Creation: Set up an App Service Plan with your choice of SKU and OS.
Web App Deployment: Deploy your web application with custom settings.
Application Insights Integration: Monitor your app's performance (third-eye not included).
Custom Tags: Organize your resources with customizable tags.
Usage 🛠️
hcl
Copy code
module "app_service" {
  source = "../modules/app_service"

  resource_group_name    = var.resource_group_name
  app_service_plan_name  = var.app_service_plan_name
  web_app_name           = var.web_app_name
  location               = var.location
  app_service_plan_sku   = var.app_service_plan_sku
  app_service_plan_os    = var.app_service_plan_os
  app_settings           = var.app_settings
  tags                   = var.tags
}
Input Variables 📥
Variable	Description	Type	Default	Required
resource_group_name	Name of the Resource Group	string	n/a	yes
app_service_plan_name	Name of the App Service Plan	string	n/a	yes
web_app_name	Name of the Web App	string	n/a	yes
location	Azure region for deployment	string	n/a	yes
app_service_plan_sku	SKU for the App Service Plan (e.g., S1)	string	n/a	yes
app_service_plan_os	OS type (Linux or Windows)	string	"Linux"	no
app_settings	Application settings for the Web App	map(string)	{}	no
tags	Map of tags to apply to resources	map(string)	{}	no
Output Variables 📤
Output	Description
app_service_plan_id	The ID of the App Service Plan
web_app_id	The ID of the Web App
web_app_default_hostname	The default hostname of the Web App
Example 🚀
Navigate to the examples directory to see how to get your app ready for liftoff!

Notes 📝
Houston, We Have No Problems: This module aims to make your deployment as smooth as a zero-gravity dance.
Customization: Configure your app settings to make your application shine brighter than a supernova.
Contributing 🤝
Have an idea that's out of this world? Open an issue or a pull request, and let's make this module stellar together!

License 📄
This project is licensed under the MIT License - see the LICENSE file for details.