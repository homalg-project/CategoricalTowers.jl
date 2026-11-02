```jldoctest AutoDocTests
julia> using CAP, MonoidalCategories, CartesianCategories, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, QuotientCategories, LocalesForCAP, FpCategories, AdditiveClosuresForCAP, FreydCategoriesForCAP, PresheafCategories, FiniteCocompletions

julia> # extracted from examples/SkeletalDirectProduct.g

julia> true
true

julia> sFinSets =
          SkeletalFinSetsAsFiniteStrictCoproductCompletionOfTerminalCategory
SkeletalFinSetsAsFiniteStrictCoproductCompletionOfTerminalCategory

julia> m = ObjectConstructor( sFinSets, 7 )
|7|

julia> n = ObjectConstructor( sFinSets, 3 )
|3|

julia> p = ObjectConstructor( sFinSets, 4 )
|4|

julia> d = DirectProduct( [ m, n, p ] )
|84|

julia> AsList( d )
0:83

julia> pi1 = ProjectionInFactorOfDirectProduct( [ m, n, p ], 1 )
|84| → |7|

julia> Display( pi1 )
[ 0,..., 83 ] ⱶ[ 0, 1, 2, 3, 4, 5, 6, 0, 1, 2, 3, 4, 5, 6,
                 0, 1, 2, 3, 4, 5, 6, 0, 1, 2, 3, 4, 5, 6,
                 0, 1, 2, 3, 4, 5, 6, 0, 1, 2, 3, 4, 5, 6,
                 0, 1, 2, 3, 4, 5, 6, 0, 1, 2, 3, 4, 5, 6,
                 0, 1, 2, 3, 4, 5, 6, 0, 1, 2, 3, 4, 5, 6,
                 0, 1, 2, 3, 4, 5, 6, 0, 1, 2, 3, 4, 5, 6 ]→ [ 0,..., 6 ]

julia> pi2 = ProjectionInFactorOfDirectProduct( [ m, n, p ], 2 )
|84| → |3|

julia> Display( pi2 )
[ 0,..., 83 ] ⱶ[ 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1,
                 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0,
                 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2,
                 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1,
                 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0,
                 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2 ]→ [ 0, 1, 2 ]

julia> pi3 = ProjectionInFactorOfDirectProduct( [ m, n, p ], 3 )
|84| → |4|

julia> Display( pi3 )
[ 0,..., 83 ] ⱶ[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1,
                 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
                 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3,
                 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3 ]→ [ 0,..., 3 ]

julia> psi = UniversalMorphismIntoDirectProduct( [ m, n, p ], [ pi1, pi2, pi3 ] )
|84| → |84|

julia> psi == IdentityMorphism( d )
true

```
