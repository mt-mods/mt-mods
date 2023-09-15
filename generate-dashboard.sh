#!/bin/bash
# requires: jq

json=$(curl https://api.github.com/orgs/mt-mods/repos?per_page=1000)
names=$(echo $json | jq -r 'sort_by(.name) | map(select(.name != "mt-mods")) | .[].name')

if jq -e . >/dev/null 2>&1 <<<"$json"; then
    echo "Got valid JSON"
else
    echo "Failed to parse JSON, or got false/null"
    exit 0 # Github api error ¯\_(ツ)_/¯
fi

> dashboard.md
echo $json > dashboard.json

echo "|Name|Last commit|Open issues|Open PR's|Contributors|" >> dashboard.md
echo "|---|---|---|---|---|" >> dashboard.md
for name in ${names}
do
    link="[${name}](https://github.com/mt-mods/${name})"
    stars="![GitHub Repo stars](https://img.shields.io/github/stars/mt-mods/${name}?style=social)"
    contributors="![GitHub contributors](https://img.shields.io/github/contributors/mt-mods/${name})"
    last_commit="![GitHub last commit](https://img.shields.io/github/last-commit/mt-mods/${name})"
    open_issues="![GitHub issues](https://img.shields.io/github/issues/mt-mods/${name})"
    open_prs="![GitHub pull requests](https://img.shields.io/github/issues-pr/mt-mods/${name})"
    echo "|${link}|${last_commit}|${open_issues}|${open_prs}|${contributors}|" >> dashboard.md
done