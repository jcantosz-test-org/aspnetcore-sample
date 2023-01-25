#!/bin/bash
export AZURE_CLIENT_ID="<>"
export AZURE_SUBSCRIPTION_ID="<>"
export AZURE_TENANT_ID="<>"


# Create environment and set secrest for it based on env vars with the same name on the local machine
for i in {dev,qa,uat,prod}; do
    gh api -X PUT repos/jcantosz-test-org/aspnetcore-sample/environments/$i
    for secret in {AZURE_CLIENT_ID,AZURE_SUBSCRIPTION_ID,AZURE_TENANT_ID}; do
        gh secret set $secret --repo jcantosz-test-org/aspnetcore-sample --app actions --env $i --body ${!secret}
    done
done
