install:
	julia -e 'using Pkg; \
		Pkg.develop(path = "ToolsForCategoricalTowers"); \
		Pkg.develop(path = "QuotientCategories"); \
		Pkg.develop(path = "FpCategories"); \
		Pkg.develop(path = "FpLinearCategories"); \
		Pkg.develop(path = "Locales"); \
		Pkg.develop(path = "SubcategoriesForCAP"); \
		Pkg.develop(path = "PresheafCategories"); \
		Pkg.develop(path = "FiniteCocompletions"); \
		Pkg.develop(path = "SliceCategories"); \
		Pkg.develop(path = "LazyCategories"); \
		Pkg.develop(path = "FunctorCategories"); \
	'

uninstall:
	$(MAKE) -C ToolsForCategoricalTowers uninstall
	$(MAKE) -C QuotientCategories uninstall
	$(MAKE) -C FpCategories uninstall
	$(MAKE) -C FpLinearCategories uninstall
	$(MAKE) -C Locales uninstall
	$(MAKE) -C SubcategoriesForCAP uninstall
	$(MAKE) -C PresheafCategories uninstall
	$(MAKE) -C FiniteCocompletions uninstall
	$(MAKE) -C SliceCategories uninstall
	$(MAKE) -C LazyCategories uninstall
	$(MAKE) -C FunctorCategories uninstall

gen-basic:
	$(MAKE) -C ToolsForCategoricalTowers gen-basic
	$(MAKE) -C QuotientCategories gen-basic
	$(MAKE) -C FpCategories gen-basic
	$(MAKE) -C FpLinearCategories gen-basic
	$(MAKE) -C Locales gen-basic
	$(MAKE) -C SubcategoriesForCAP gen-basic
	$(MAKE) -C PresheafCategories gen-basic
	$(MAKE) -C FiniteCocompletions gen-basic
	$(MAKE) -C SliceCategories gen-basic
	$(MAKE) -C LazyCategories gen-basic
	$(MAKE) -C FunctorCategories gen-basic
	$(MAKE) gen-root

gen:
	$(MAKE) -C ToolsForCategoricalTowers gen
	$(MAKE) -C QuotientCategories gen
	$(MAKE) -C FpCategories gen
	$(MAKE) -C FpLinearCategories gen
	$(MAKE) -C Locales gen
	$(MAKE) -C SubcategoriesForCAP gen
	$(MAKE) -C PresheafCategories gen
	$(MAKE) -C FiniteCocompletions gen
	$(MAKE) -C SliceCategories gen
	$(MAKE) -C LazyCategories gen
	$(MAKE) -C FunctorCategories gen
	$(MAKE) gen-root

gen-root:
	ansible-playbook -i $$HOME/.gap/PackageJanitor/gap_to_julia/hosts $$HOME/.gap/PackageJanitor/gap_to_julia/site.yml -l CategoricalTowers_root --diff

test:
	$(MAKE) -C ToolsForCategoricalTowers test
	$(MAKE) -C QuotientCategories test
	$(MAKE) -C FpCategories test
	$(MAKE) -C FpLinearCategories test
	$(MAKE) -C Locales test
	$(MAKE) -C SubcategoriesForCAP test
	$(MAKE) -C PresheafCategories test
	$(MAKE) -C FiniteCocompletions test
	$(MAKE) -C SliceCategories test
	$(MAKE) -C LazyCategories test
	$(MAKE) -C FunctorCategories test

git-commit:
	$(MAKE) -C ToolsForCategoricalTowers git-commit
	$(MAKE) -C QuotientCategories git-commit
	$(MAKE) -C FpCategories git-commit
	$(MAKE) -C FpLinearCategories git-commit
	$(MAKE) -C Locales git-commit
	$(MAKE) -C SubcategoriesForCAP git-commit
	$(MAKE) -C PresheafCategories git-commit
	$(MAKE) -C FiniteCocompletions git-commit
	$(MAKE) -C SliceCategories git-commit
	$(MAKE) -C LazyCategories git-commit
	$(MAKE) -C FunctorCategories git-commit

update-subsplits:
	./dev/manually_update_subsplits.sh
