```jldoctest AutoDocTests
julia> using CAP, MonoidalCategories, CartesianCategories, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, QuotientCategories, LocalesForCAP, FpCategories, AdditiveClosuresForCAP, FreydCategoriesForCAP, PresheafCategories, FiniteCocompletions

julia> # extracted from examples/SkeletalPreCompose.g

julia> true
true

julia> sFinSets =
          SkeletalFinSetsAsFiniteStrictCoproductCompletionOfTerminalCategory
SkeletalFinSetsAsFiniteStrictCoproductCompletionOfTerminalCategory

julia> m = ObjectConstructor( sFinSets, 3 )
|3|

julia> n = ObjectConstructor( sFinSets, 5 )
|5|

julia> p = ObjectConstructor( sFinSets, 7 )
|7|

julia> psi = MorphismConstructor( m, [ 1, 4, 2 ], n )
|3| → |5|

julia> phi = MorphismConstructor( n, [ 0, 3, 5, 5, 2 ], p )
|5| → |7|

julia> alpha = PreCompose( psi, phi )
|3| → |7|

julia> Display( alpha )
[ 0, 1, 2 ] ⱶ[ 3, 2, 5 ]→ [ 0,..., 6 ]

```
