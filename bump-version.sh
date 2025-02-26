#!/bin/bash

# Read current version
VERSION=$(cat VERSION)

# Split version into components
IFS='.' read -ra VERSION_PARTS <<< "$VERSION"
MAJOR=${VERSION_PARTS[0]}
MINOR=${VERSION_PARTS[1]}
PATCH=${VERSION_PARTS[2]}

# Determine which part to increment based on argument
case "$1" in
  major)
    MAJOR=$((MAJOR + 1))
    MINOR=0
    PATCH=0
    ;;
  minor)
    MINOR=$((MINOR + 1))
    PATCH=0
    ;;
  patch|*)
    PATCH=$((PATCH + 1))
    ;;
esac

# Create new version string
NEW_VERSION="${MAJOR}.${MINOR}.${PATCH}"

# Update VERSION file
echo $NEW_VERSION > VERSION

# Create git tag and push
git add VERSION
git commit -m "Bump version to $NEW_VERSION"
git tag "v$NEW_VERSION"

echo "Version bumped to $NEW_VERSION"
echo "Don't forget to push with: git push && git push --tags"