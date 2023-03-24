#!/bin/bash

set -x

# Subtree split on tag this script gets called using find:
# find src -maxdepth 2 -name composer.json -exec bash subtree.sh {} refs/tags/3.1.5 \;
# find src -maxdepth 2 -name composer.json -exec bash subtree.sh {} refs/heads/3.1 \;
# See the subtree workflow
package=$(jq -r .name $1)
directory=$(dirname $1)
repository="https://soyuka:${SUBTREE_TOKEN}@github.com/$package"
git remote rm $package
git remote add $package $repository
sha=$(splitsh-lite --prefix=$directory)
git push $package $sha:$2