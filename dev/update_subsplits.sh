#!/bin/bash

set -e

# Check if token exists
if [ -z "$JULIA_SUBSPLIT_TOKEN" ]; then
  echo -e "\033[31mERROR: Missing JULIA_SUBSPLIT_TOKEN\033[0m"
  exit 1
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
git subtree split --prefix=ToolsForCategoricalTowers -b ToolsForCategoricalTowers-split > /dev/null 2>&1
git push https://${JULIA_SUBSPLIT_TOKEN}@github.com/homalg-project/ToolsForCategoricalTowers.jl.git ToolsForCategoricalTowers-split:master
echo "Pushed to ToolsForCategoricalTowers.jl"

# QuotientCategories
git subtree split --prefix=QuotientCategories -b QuotientCategories-split > /dev/null 2>&1
git push https://${JULIA_SUBSPLIT_TOKEN}@github.com/homalg-project/QuotientCategories.jl.git QuotientCategories-split:master
echo "Pushed to QuotientCategories.jl"

# FpCategories
git subtree split --prefix=FpCategories -b FpCategories-split > /dev/null 2>&1
git push https://${JULIA_SUBSPLIT_TOKEN}@github.com/homalg-project/FpCategories.jl.git FpCategories-split:master
echo "Pushed to FpCategories.jl"

# FpLinearCategories
git subtree split --prefix=FpLinearCategories -b FpLinearCategories-split > /dev/null 2>&1
git push https://${JULIA_SUBSPLIT_TOKEN}@github.com/homalg-project/FpLinearCategories.jl.git FpLinearCategories-split:master
echo "Pushed to FpLinearCategories.jl"

# Locales
git subtree split --prefix=Locales -b Locales-split > /dev/null 2>&1
git push https://${JULIA_SUBSPLIT_TOKEN}@github.com/homalg-project/Locales.jl.git Locales-split:master
echo "Pushed to Locales.jl"

# SubcategoriesForCAP
git subtree split --prefix=SubcategoriesForCAP -b SubcategoriesForCAP-split > /dev/null 2>&1
git push https://${JULIA_SUBSPLIT_TOKEN}@github.com/homalg-project/SubcategoriesForCAP.jl.git SubcategoriesForCAP-split:master
echo "Pushed to SubcategoriesForCAP.jl"

# PresheafCategories
git subtree split --prefix=PresheafCategories -b PresheafCategories-split > /dev/null 2>&1
git push https://${JULIA_SUBSPLIT_TOKEN}@github.com/homalg-project/PresheafCategories.jl.git PresheafCategories-split:master
echo "Pushed to PresheafCategories.jl"

# FiniteCocompletions
git subtree split --prefix=FiniteCocompletions -b FiniteCocompletions-split > /dev/null 2>&1
git push https://${JULIA_SUBSPLIT_TOKEN}@github.com/homalg-project/FiniteCocompletions.jl.git FiniteCocompletions-split:master
echo "Pushed to FiniteCocompletions.jl"

# SliceCategories
git subtree split --prefix=SliceCategories -b SliceCategories-split > /dev/null 2>&1
git push https://${JULIA_SUBSPLIT_TOKEN}@github.com/homalg-project/SliceCategories.jl.git SliceCategories-split:master
echo "Pushed to SliceCategories.jl"

# LazyCategories
git subtree split --prefix=LazyCategories -b LazyCategories-split > /dev/null 2>&1
git push https://${JULIA_SUBSPLIT_TOKEN}@github.com/homalg-project/LazyCategories.jl.git LazyCategories-split:master
echo "Pushed to LazyCategories.jl"

# FunctorCategories
git subtree split --prefix=FunctorCategories -b FunctorCategories-split > /dev/null 2>&1
git push https://${JULIA_SUBSPLIT_TOKEN}@github.com/homalg-project/FunctorCategories.jl.git FunctorCategories-split:master
echo "Pushed to FunctorCategories.jl"
