```jldoctest AutoDocTests
julia> using CAP, MonoidalCategories, CartesianCategories, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, QuotientCategories, LocalesForCAP, FpCategories, AdditiveClosuresForCAP, FreydCategoriesForCAP, PresheafCategories, FiniteCocompletions

julia> # extracted from examples/SkeletalWellDefined.g

julia> true
true

julia> sFinSets =
          SkeletalFinSetsAsFiniteStrictCoproductCompletionOfTerminalCategory
SkeletalFinSetsAsFiniteStrictCoproductCompletionOfTerminalCategory

julia> Display( sFinSets )
A CAP category with name
SkeletalFinSetsAsFiniteStrictCoproductCompletionOfTerminalCategory:

36 primitive operations were used to derive 175 operations for this category
which algorithmically
* IsCategoryWithDecidableColifts
* IsCategoryWithDecidableLifts
* IsEquippedWithHomomorphismStructure
* IsFiniteCompleteCategory
* IsDistributiveCategory
and not yet algorithmically
* IsElementaryTopos
and furthermore mathematically
* IsSkeletalCategory
* IsStrictCartesianCategory
* IsStrictCocartesianCategory

julia> s = ObjectConstructor( sFinSets, 7 )
|7|

julia> ObjectDatum( s )
7

julia> t = ObjectConstructor( sFinSets, 4 )
|4|

julia> ObjectDatum( t )
4

julia> psi = MorphismConstructor( s, [ 0, 2, 1, 2, 1, 3 ], t )
|7| → |4|

julia> IsWellDefined( psi )
false

julia> psi = MorphismConstructor( s, [ 0, 2, 1, 2, 1, 3, -2 ], t )
|7| → |4|

julia> IsWellDefined( psi )
false

julia> psi = MorphismConstructor( s, [ 1, 2, 1, 4, 2, 1, 3 ], t )
|7| → |4|

julia> IsWellDefined( psi )
false

julia> psi = MorphismConstructor( s, [ 0, 2, 1, 3, 2, 1, 3 ], t )
|7| → |4|

julia> IsWellDefined( psi )
true

julia> Display( psi )
[ 0,..., 6 ] ⱶ[ 0, 2, 1, 3, 2, 1, 3 ]→ [ 0,..., 3 ]

julia> ViewObj( MorphismDatum( psi ) )
[ 0, 2, 1, 3, 2, 1, 3 ]

```
