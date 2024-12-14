#!/bin/bash

# Ensure the script stops on any error
set -e

# Define bucket name and AWS profile
BUCKET_NAME="robertburen.com"
AWS_PROFILE="buren.se"

# Build the Hugo site
echo "Building Hugo site..."
hugo

# Sync the public directory with S3, deleting any files in the bucket that are no longer in the public directory
echo "Deploying to S3 bucket $BUCKET_NAME..."
# aws s3 sync public/ s3://$BUCKET_NAME --delete --profile $AWS_PROFILE
aws s3 sync placeholder/ s3://$BUCKET_NAME --delete --profile $AWS_PROFILE

# Optionally, invalidate CloudFront cache if you're using CloudFront for CDN (uncomment if needed)
echo "Invalidating CloudFront cache..."
aws cloudfront create-invalidation \
    --distribution-id E38M1LAE0T5H91 \
    --paths "/*" \
    --profile $AWS_PROFILE \
    --no-cli-pager

# Output success message
echo "Deployment to S3 bucket $BUCKET_NAME completed successfully."
