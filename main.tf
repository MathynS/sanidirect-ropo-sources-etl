provider "google" {
  project     = "marketing-dashboard-sanidirect"
  region      = "europe-west1"
}

terraform {
  required_version = ">= 0.14"

  required_providers {
    google = ">= 4.13.0"
  }

  backend "gcs" {
    bucket  = "marketing-dashboard-sanidirect-tf-state-prod"
    prefix  = "terraform/sanidirect-ads-etl"
  }
}

module "facebook-ads-etl" {
  source = "./modules/facebook-ads-etl-tf-gcp/terraform"

  facebook_ad_account_id  = "act_407457856458532"
  facebook_app_id         = 549951082746103
  gcp_project             = "marketing-dashboard-sanidirect"
  project_name            = "sanidirect"
  bigquery_table_name     = "marketing-dashboard-sanidirect.ad_spend.facebook_marketing_insights"
  facebook_app_secret     = var.facebook_app_secret
  facebook_token          = var.facebook_token
}

module "pinterest-ads-etl" {
  source = "./modules/pinterest-ads-etl-tf-gcp/terraform"

  pinterest_ad_client_id  = 1476688
  pinterest_ad_account_id = 549758977144
  gcp_project             = "marketing-dashboard-sanidirect"
  project_name            = "sanidirect"
  bigquery_table_name     = "marketing-dashboard-sanidirect.ad_spend.pinterest_analytics_campaign_level"
  pinterest_secret_key    = var.facebook_app_secret
  pinterest_refresh_token = var.facebook_token
}