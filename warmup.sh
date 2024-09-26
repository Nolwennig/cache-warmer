#!/bin/bash

#################
# Configuration #
SITEMAP_PATTERN="sitemap*.xml"
#################

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # reset

# Check sitemap directory is not null
if [ -z "$1" ]; then
    echo -e "${RED}ERROR : No directory entered as argument.${NC}"
    repeat_usage
    exit 1
fi

SITEMAP_DIR="$1"

AUTH=""
if [ ! -z "$2" ]; then
    AUTH="-u $2"
fi

process_url() {
    local url="$1"

    echo -e "${GREEN}Url processing :${NC}" $url
    # curl request and get http_code
    response_code=$(curl -s -o /dev/null ${AUTH} -w "%{http_code}" ${url})

    # check http_code responde
    if [ "$response_code" -eq 200 ]; then
        echo -e "${GREEN}Success: Page cached successfully (HTTP 200)${NC}"
    elif [ "$response_code" -eq 401 ]; then
        if [ -z "$AUTH" ]; then
            echo -e "${RED}Unauthorized: Credentials required (HTTP 401). Please provide user:password.${NC}"
            repeat_usage
        else
            echo -e "${RED}Unauthorized: Invalid credentials (HTTP 401).${NC}"
            repeat_usage
        fi
    else
        echo -e "${RED}Error: HTTP code $response_code${NC}"
    fi
}

repeat_usage() {
    echo "Usage: $0 /path/to/sitemap/ [user:password]"
}

# Get all SITEMAP_PATTERN files in SITEMAP_DIR
for sitemap_file in "$SITEMAP_DIR"${SITEMAP_PATTERN}; do
    if [ -f "$sitemap_file" ]; then
        echo -e "${GREEN}File processing :${NC}" $sitemap_file

        cat "$sitemap_file" | grep -oP '(?<=<loc>).*?(?=</loc>)' | while read -r sitemap_url; do
            process_url "$sitemap_url"
        done
    else
        echo -e "${RED}No file ${NC}"$SITEMAP_PATTERN"${RED} find in directory :${NC}" $SITEMAP_DIR
    fi
done
