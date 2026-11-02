```jldoctest AutoDocTests
julia> using CAP, MonoidalCategories, CartesianCategories, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, QuotientCategories, LocalesForCAP, FpCategories, AdditiveClosuresForCAP, FreydCategoriesForCAP, PresheafCategories, FiniteCocompletions

julia> # extracted from examples/SkeletalHomStructure.g

julia> true
true

julia> sFinSets =
          SkeletalFinSetsAsFiniteStrictCoproductCompletionOfTerminalCategory
SkeletalFinSetsAsFiniteStrictCoproductCompletionOfTerminalCategory

julia> A = ObjectConstructor( sFinSets, 3 )
|3|

julia> Display( A )
[ 0, 1, 2 ]

julia> B = ObjectConstructor( sFinSets, 2 )
|2|

julia> A == B
false

julia> Display( B )
[ 0, 1 ]

julia> HomAB = HomStructure( A, B )
|8|

julia> I = HomStructure( sFinSets )
|1|

julia> homAB = List( (0):(ObjectDatum( HomAB ) - 1), i ->
                       MorphismConstructor( I, [ i ], HomAB ) );

julia> all( List( homAB, IsWellDefined ) )
true

julia> List( homAB, m -> HomStructure( HomStructure( A, B, m ) ) ) == homAB
true

julia> alpha = HomStructure( A, B, homAB[6] )
|3| → |2|

julia> Display( alpha )
[ 0, 1, 2 ] ⱶ[ 1, 0, 1 ]→ [ 0, 1 ]

julia> gamma = HomStructure( A, B, homAB[2] )
|3| → |2|

julia> Display( gamma )
[ 0, 1, 2 ] ⱶ[ 1, 0, 0 ]→ [ 0, 1 ]

julia> hom_alpha_gamma = HomStructure( alpha, gamma )
|9| → |8|

julia> Display( hom_alpha_gamma )
[ 0,..., 8 ] ⱶ[ 7, 5, 5, 2, 0, 0, 2, 0, 0 ]→ [ 0,..., 7 ]

julia> IsWellDefined( hom_alpha_gamma )
true

```
