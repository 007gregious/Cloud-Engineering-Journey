# Problem

Organizations need a **scalable, durable, and cost-effective storage solution** for:

- Static websites  

- Application assets (images, videos, files)

- Backups and logs  

However, misconfigurations (especially public access) can lead to:

- Data leaks  

- Sensitive information exposure  

- Security breaches  

## Solution

- Use **Amazon S3** for object storage

- Configure buckets securely (private by default)

- Only allow public access when absolutely necessary

- Re-enable security controls after testing  

## Architecture

![AWS Static Site](/diagrams/s3-static-site/aws-static-site.drawio.png)

- S3 acts as a **web server for static files**

- No EC2 required for static hosting

- Highly scalable and cost-efficient

## Implementation Steps

### Created S3 Bucket

- Bucket name: `sylva-cloud-journey`

- Region: Same as EC2

### Uploaded File

- Uploaded `index.html`

### Make Bucket Public (Temporary ⚠️)

- Disabled **Block Public Access**

- Added bucket policy to allow public read

### Access via URL

- Opened object URL in browser

- Verified file is publicly accessible

### Re-secure Bucket

- Removed public access policy

- Re-enabled **Block Public Access**

## Key Learning

- S3 is **object storage**, not block storage

- Default security posture = **private**

- Public buckets can expose sensitive data

- S3 can host **static websites without servers**

## Challenge Faced

- Understanding **bucket policies vs block public access**

- Making the files accessible publicly

- Confusion around why access failed initially  

## Solution to the Challenge

- Disabled **Block Public Access (temporarily)**

- Applied correct **bucket policy** for public read

- Verified object permissions

- Re-secured bucket after testing  

## Security Considerations

- Avoid public buckets unless absolutely necessary

- Enable **Block Public Access** by default

- Apply **least privilege principle**

- Monitor access using logs (CloudTrail/S3 access logs)

- Regularly audit bucket permissions  

> ⚠️ Misconfigured S3 buckets are one of the most common causes of real-world data breaches.

## Future Improvements

- Host a **full static website** using S3

- Add **CloudFront (CDN)** for performance

- Use **custom domain + HTTPS**

- Implement **fine-grained bucket policies**

- Enable **versioning for backups**

## Commands Used

```bash id="v2k3rh"
# List S3 buckets
aws s3 ls

# Upload file
aws s3 cp index.html s3://sylva-cloud-journey/

# List bucket contents
aws s3 ls s3://sylva-cloud-journey/

# Remove file
aws s3 rm s3://sylva-cloud-journey/index.html
```

## Static Website Hosting

Steps:

- Uploaded: `index.html`

- Enabled: Static website hosting

- Accessed via: S3 website endpoint

🎉 I successfully hosted a static site without a server!

## Screenshots

![AWS Bucket Policy](/images/day4-imgs/s3-bucket-policy.JPG)

![AWS Bucket](/images/day4-imgs/s3-bucket.JPG)

![AWS S3 Bucket Config](/images/day4-imgs/s3-bucket-coonfig-showing-static-webhost.JPG)

![Live Website](/images/day4-imgs/live-webbsite.JPG)

![Live Website](/images/day4-imgs/live-website2.JPG)
