<!-- BEGIN HEADER -->
# FiniteCocompletions

### Finite (co)product/(co)limit (co)completions

| Documentation |
| ------------- |
| [![HTML stable documentation][html-img]][html-url] [![PDF stable documentation][pdf-img]][pdf-url] |

<!-- END HEADER -->

This is the Julia version of the [CAP-based][CAP_based] package [FiniteCocompletions][FiniteCocompletions].

## Release status

| Package | Release status |
| --- | --- |
| FiniteCocompletions | ![FiniteCocompletions release status](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fhomalg-project%2FReleaseStatusForJuliaPackages%2Fmain%2FCategoricalTowers.jl%2FFiniteCocompletions%2Frelease.json) |

### Required dependencies

Each badge confirms that Julia's General registry has an available release satisfying this package's declared compatibility bound.

| Dependency | Release status |
| --- | --- |
| [AdditiveClosuresForCAP](https://github.com/JuliaRegistries/General/tree/master/A/AdditiveClosuresForCAP) | ![AdditiveClosuresForCAP release status](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fhomalg-project%2FReleaseStatusForJuliaPackages%2Fmain%2FCategoricalTowers.jl%2FFiniteCocompletions%2Fdependencies%2FAdditiveClosuresForCAP.json) |
| [CAP](https://github.com/JuliaRegistries/General/tree/master/C/CAP) | ![CAP release status](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fhomalg-project%2FReleaseStatusForJuliaPackages%2Fmain%2FCategoricalTowers.jl%2FFiniteCocompletions%2Fdependencies%2FCAP.json) |
| [CartesianCategories](https://github.com/JuliaRegistries/General/tree/master/C/CartesianCategories) | ![CartesianCategories release status](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fhomalg-project%2FReleaseStatusForJuliaPackages%2Fmain%2FCategoricalTowers.jl%2FFiniteCocompletions%2Fdependencies%2FCartesianCategories.json) |
| [FinSetsForCAP](https://github.com/JuliaRegistries/General/tree/master/F/FinSetsForCAP) | ![FinSetsForCAP release status](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fhomalg-project%2FReleaseStatusForJuliaPackages%2Fmain%2FCategoricalTowers.jl%2FFiniteCocompletions%2Fdependencies%2FFinSetsForCAP.json) |
| [FpCategories](https://github.com/JuliaRegistries/General/tree/master/F/FpCategories) | ![FpCategories release status](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fhomalg-project%2FReleaseStatusForJuliaPackages%2Fmain%2FCategoricalTowers.jl%2FFiniteCocompletions%2Fdependencies%2FFpCategories.json) |
| [FpLinearCategories](https://github.com/JuliaRegistries/General/tree/master/F/FpLinearCategories) | ![FpLinearCategories release status](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fhomalg-project%2FReleaseStatusForJuliaPackages%2Fmain%2FCategoricalTowers.jl%2FFiniteCocompletions%2Fdependencies%2FFpLinearCategories.json) |
| [FreydCategoriesForCAP](https://github.com/JuliaRegistries/General/tree/master/F/FreydCategoriesForCAP) | ![FreydCategoriesForCAP release status](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fhomalg-project%2FReleaseStatusForJuliaPackages%2Fmain%2FCategoricalTowers.jl%2FFiniteCocompletions%2Fdependencies%2FFreydCategoriesForCAP.json) |
| [LinearClosuresForCAP](https://github.com/JuliaRegistries/General/tree/master/L/LinearClosuresForCAP) | ![LinearClosuresForCAP release status](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fhomalg-project%2FReleaseStatusForJuliaPackages%2Fmain%2FCategoricalTowers.jl%2FFiniteCocompletions%2Fdependencies%2FLinearClosuresForCAP.json) |
| [Locales](https://github.com/JuliaRegistries/General/tree/master/L/Locales) | ![Locales release status](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fhomalg-project%2FReleaseStatusForJuliaPackages%2Fmain%2FCategoricalTowers.jl%2FFiniteCocompletions%2Fdependencies%2FLocales.json) |
| [MatricesForHomalg](https://github.com/JuliaRegistries/General/tree/master/M/MatricesForHomalg) | ![MatricesForHomalg release status](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fhomalg-project%2FReleaseStatusForJuliaPackages%2Fmain%2FCategoricalTowers.jl%2FFiniteCocompletions%2Fdependencies%2FMatricesForHomalg.json) |
| [MonoidalCategories](https://github.com/JuliaRegistries/General/tree/master/M/MonoidalCategories) | ![MonoidalCategories release status](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fhomalg-project%2FReleaseStatusForJuliaPackages%2Fmain%2FCategoricalTowers.jl%2FFiniteCocompletions%2Fdependencies%2FMonoidalCategories.json) |
| [PresheafCategories](https://github.com/JuliaRegistries/General/tree/master/P/PresheafCategories) | ![PresheafCategories release status](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fhomalg-project%2FReleaseStatusForJuliaPackages%2Fmain%2FCategoricalTowers.jl%2FFiniteCocompletions%2Fdependencies%2FPresheafCategories.json) |
| [QuotientCategories](https://github.com/JuliaRegistries/General/tree/master/Q/QuotientCategories) | ![QuotientCategories release status](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fhomalg-project%2FReleaseStatusForJuliaPackages%2Fmain%2FCategoricalTowers.jl%2FFiniteCocompletions%2Fdependencies%2FQuotientCategories.json) |
| [ToolsForCategoricalTowers](https://github.com/JuliaRegistries/General/tree/master/T/ToolsForCategoricalTowers) | ![ToolsForCategoricalTowers release status](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fhomalg-project%2FReleaseStatusForJuliaPackages%2Fmain%2FCategoricalTowers.jl%2FFiniteCocompletions%2Fdependencies%2FToolsForCategoricalTowers.json) |
| [Toposes](https://github.com/JuliaRegistries/General/tree/master/T/Toposes) | ![Toposes release status](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fhomalg-project%2FReleaseStatusForJuliaPackages%2Fmain%2FCategoricalTowers.jl%2FFiniteCocompletions%2Fdependencies%2FToposes.json) |

The badge data is refreshed every hour by the [central release-status workflow][ReleaseStatusWorkflow].

[CAP_based]: https://homalg-project.github.io/docs/CAP_project-based/
[FiniteCocompletions]: https://homalg-project.github.io/pkg/FiniteCocompletions
[ReleaseStatusWorkflow]: https://github.com/homalg-project/ReleaseStatusForJuliaPackages/actions/workflows/update-release-status.yml

<!-- BEGIN FOOTER -->
[html-img]: https://img.shields.io/badge/🔗%20HTML-stable-blue.svg
[html-url]: https://homalg-project.github.io/CategoricalTowers/FiniteCocompletions/doc/chap0_mj.html

[pdf-img]: https://img.shields.io/badge/🔗%20PDF-stable-blue.svg
[pdf-url]: https://homalg-project.github.io/CategoricalTowers/FiniteCocompletions/download_pdf.html
<!-- END FOOTER -->
