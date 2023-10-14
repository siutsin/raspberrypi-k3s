#!/usr/bin/env bash

# For local terragrunt plan
# $ cd infrastructure/cloud/cloudflare/access; source ../../hack/accounts.sh; terragrunt run-all plan

export GITHUB_TOKEN=...
export AWS_ACCESS_KEY_ID=...
export AWS_SECRET_ACCESS_KEY=...
export CLOUDFLARE_API_TOKEN=...
export CLOUDFLARE_ZONE=example.com
export CLOUDFLARE_ZONE_ID=...
export CLOUDFLARE_ZONE_SUBDOMAIN=subdomain
export CLOUDFLARE_ZONE_TUNNEL_IP_LIST='["1.2.3.4/32"]'
