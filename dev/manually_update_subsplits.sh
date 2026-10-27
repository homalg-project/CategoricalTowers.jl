#!/bin/bash

set -e

# Define GitHub username
if [ -z "$1" ]; then
  GITHUB_USER="homalg-project"
else
  GITHUB_USER="$1"
fi

# update git index
git status > /dev/null

if ! git diff-index --quiet HEAD; then
	echo -e "\033[33mWARNING: Dirty working tree.\033[0m"
fi

if [[ "$(git rev-parse --abbrev-ref HEAD)" != "master" ]]; then
	echo -e "\033[31mERROR: Not on branch master\033[0m"
	exit 1
fi

# ToolsForCategoricalTowers
git subtree split --prefix=ToolsForCategoricalTowers -b ToolsForCategoricalTowers-split
git push git@github.com:${GITHUB_USER}/ToolsForCategoricalTowers.jl.git ToolsForCategoricalTowers-split:master
echo "Pushed to ToolsForCategoricalTowers.jl"

# QuotientCategories
git subtree split --prefix=QuotientCategories -b QuotientCategories-split
git push git@github.com:${GITHUB_USER}/QuotientCategories.jl.git QuotientCategories-split:master
echo "Pushed to QuotientCategories.jl"

# FpCategories
git subtree split --prefix=FpCategories -b FpCategories-split
git push git@github.com:${GITHUB_USER}/FpCategories.jl.git FpCategories-split:master
echo "Pushed to FpCategories.jl"

# FpLinearCategories
git subtree split --prefix=FpLinearCategories -b FpLinearCategories-split
git push git@github.com:${GITHUB_USER}/FpLinearCategories.jl.git FpLinearCategories-split:master
echo "Pushed to FpLinearCategories.jl"

# Locales
git subtree split --prefix=Locales -b Locales-split
git push git@github.com:${GITHUB_USER}/Locales.jl.git Locales-split:master
echo "Pushed to Locales.jl"

# SubcategoriesForCAP
git subtree split --prefix=SubcategoriesForCAP -b SubcategoriesForCAP-split
git push git@github.com:${GITHUB_USER}/SubcategoriesForCAP.jl.git SubcategoriesForCAP-split:master
echo "Pushed to SubcategoriesForCAP.jl"

# PresheafCategories
git subtree split --prefix=PresheafCategories -b PresheafCategories-split
git push git@github.com:${GITHUB_USER}/PresheafCategories.jl.git PresheafCategories-split:master
echo "Pushed to PresheafCategories.jl"

# FiniteCocompletions
git subtree split --prefix=FiniteCocompletions -b FiniteCocompletions-split
git push git@github.com:${GITHUB_USER}/FiniteCocompletions.jl.git FiniteCocompletions-split:master
echo "Pushed to FiniteCocompletions.jl"

# SliceCategories
git subtree split --prefix=SliceCategories -b SliceCategories-split
git push git@github.com:${GITHUB_USER}/SliceCategories.jl.git SliceCategories-split:master
echo "Pushed to SliceCategories.jl"

# LazyCategories
git subtree split --prefix=LazyCategories -b LazyCategories-split
git push git@github.com:${GITHUB_USER}/LazyCategories.jl.git LazyCategories-split:master
echo "Pushed to LazyCategories.jl"

# FunctorCategories
git subtree split --prefix=FunctorCategories -b FunctorCategories-split
git push git@github.com:${GITHUB_USER}/FunctorCategories.jl.git FunctorCategories-split:master
echo "Pushed to FunctorCategories.jl"
