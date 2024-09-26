# magento-cache-warmup
Quick project for cache warmup from xml file (ie: `sitemap_*.xml`)

Works with `basic_auth` (htaccess/htpasswd)

(click to expand)

<details>
<summary>Installation 📥</summary>
  
## Installation

Assuming that the magento root folder is: `/var/www/html/`

Assuming that the sitemap files folder is: `/var/www/html/pub/`

Go to Magento `bin` folder
```bash
cd /var/www/html/bin
```

Download `warmup.sh` script
```bash
curl -O https://raw.githubusercontent.com/Nolwennig/magento-cache-warmup/refs/heads/main/warmup.sh
```

Make it executable
```bash
chmod +x warmup.sh
```
</details>

<details>
<summary>Configuration ⚙️ </summary>
  
## Configuration

You can change the sitemap file pattern `sitemap_*.xml` by custome pattern
```bash
sed -i 's/^SITEMAP_PATTERN=".*"/SITEMAP_PATTERN="custom_sitemap*.xml"/' bin/warmup.sh
```
</details>

<details>
<summary>Usage 🚀</summary>
  
## Usage 

Go to Magento root folder
```bash
cd /var/www/html/
```

### For production website

```bash
bin/warmup.sh pub/ 
```

### For basic_auth website (ie: `preprod`)

```bash
bin/warmup.sh pub/ user:password
```
</details>
