```jldoctest AutoDocTests
julia> using CAP, MonoidalCategories, CartesianCategories, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, QuotientCategories, LocalesForCAP, FpCategories, AdditiveClosuresForCAP, FreydCategoriesForCAP, PresheafCategories, FiniteCocompletions

julia> # extracted from examples/SkeletalCoproductComplement.g

julia> true
true

julia> sFinSets =
          SkeletalFinSetsAsFiniteStrictCoproductCompletionOfTerminalCategory
SkeletalFinSetsAsFiniteStrictCoproductCompletionOfTerminalCategory

julia> m = ObjectConstructor( sFinSets, 3 )
|3|

julia> n = ObjectConstructor( sFinSets, 5 )
|5|

julia> iota = MorphismConstructor( m, [ 1, 4, 2 ], n )
|3| → |5|

julia> Display( iota )
[ 0, 1, 2 ] ⱶ[ 1, 4, 2 ]→ [ 0,..., 4 ]

julia> kappa = InjectionOfCoproductComplement( iota )
|2| → |5|

julia> IsWellDefined( kappa )
true

julia> Display( kappa )
[ 0, 1 ] ⱶ[ 0, 3 ]→ [ 0,..., 4 ]

julia> iso = UniversalMorphismFromCoproduct( [ iota, kappa ] )
|5| → |5|

julia> IsWellDefined( iso )
true

julia> Display( iso )
[ 0,..., 4 ] ⱶ[ 1, 4, 2, 0, 3 ]→ [ 0,..., 4 ]

julia> IsIsomorphism( iso )
true

```
