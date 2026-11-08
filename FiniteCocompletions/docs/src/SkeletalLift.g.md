```jldoctest AutoDocTests
julia> using CAP, MonoidalCategories, CartesianCategories, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, QuotientCategories, LocalesForCAP, FpCategories, AdditiveClosuresForCAP, FreydCategoriesForCAP, PresheafCategories, FiniteCocompletions

julia> # extracted from examples/SkeletalLift.g

julia> true
true

julia> sFinSets =
          SkeletalFinSetsAsFiniteStrictCoproductCompletionOfTerminalCategory
SkeletalFinSetsAsFiniteStrictCoproductCompletionOfTerminalCategory

julia> m = ObjectConstructor( sFinSets, 3 )
|3|

julia> n = ObjectConstructor( sFinSets, 4 )
|4|

julia> f = MorphismConstructor( m, [ 1, 1, 0 ], m )
|3| → |3|

julia> g = MorphismConstructor( n, [ 2, 1, 0, 1 ], m )
|4| → |3|

julia> IsLiftable( f, g )
true

julia> chi = Lift( f, g )
|3| → |4|

julia> Display( chi )
[ 0, 1, 2 ] ⱶ[ 1, 1, 2 ]→ [ 0,..., 3 ]

julia> PreCompose( Lift( f, g ), g ) == f
true

julia> IsLiftable( g, f )
false

julia> k = ObjectConstructor( sFinSets, 100000 )
|100000|

julia> h = ListWithIdenticalEntries( ObjectDatum( k ) - 3, BigInt(2) );

julia> h = @Concatenation( h, [ BigInt(1), BigInt(0), BigInt(1) ] );

julia> h = MorphismConstructor( k, h, m )
|100000| → |3|

julia> IsLiftable( f, h )
true

julia> IsLiftable( h, f )
false

```
