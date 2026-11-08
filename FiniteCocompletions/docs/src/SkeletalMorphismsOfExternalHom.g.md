```jldoctest AutoDocTests
julia> using CAP, MonoidalCategories, CartesianCategories, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, QuotientCategories, LocalesForCAP, FpCategories, AdditiveClosuresForCAP, FreydCategoriesForCAP, PresheafCategories, FiniteCocompletions

julia> # extracted from examples/SkeletalMorphismsOfExternalHom.g

julia> true
true

julia> sFinSets =
          SkeletalFinSetsAsFiniteStrictCoproductCompletionOfTerminalCategory
SkeletalFinSetsAsFiniteStrictCoproductCompletionOfTerminalCategory

julia> L = ObjectConstructor( sFinSets, 0 )
|0|

julia> M = ObjectConstructor( sFinSets, 2 )
|2|

julia> N = ObjectConstructor( sFinSets, 3 )
|3|

julia> Display( MorphismsOfExternalHom( L, L ) )
[ ∅ ⱶ[ ]→ ∅ ]

julia> Display( MorphismsOfExternalHom( M, L ) )
[  ]

julia> Display( MorphismsOfExternalHom( L, M ) )
[ ∅ ⱶ[ ]→ [ 0, 1 ] ]

julia> Display( MorphismsOfExternalHom( M, N ) )
[ [ 0, 1 ] ⱶ[ 0, 0 ]→ [ 0, 1, 2 ], [ 0, 1 ] ⱶ[ 1, 0 ]→ [ 0, 1, 2 ], [ 0, 1 ] ⱶ[ 2, 0 ]→ [ 0, 1, 2 ], [ 0, 1 ] ⱶ[ 0, 1 ]→ [ 0, 1, 2 ], [ 0, 1 ] ⱶ[ 1, 1 ]→ [ 0, 1, 2 ], [ 0, 1 ] ⱶ[ 2, 1 ]→ [ 0, 1, 2 ], [ 0, 1 ] ⱶ[ 0, 2 ]→ [ 0, 1, 2 ], [ 0, 1 ] ⱶ[ 1, 2 ]→ [ 0, 1, 2 ], [ 0, 1 ] ⱶ[ 2, 2 ]→ [ 0, 1, 2 ] ]

```
