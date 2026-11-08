```jldoctest AutoDocTests
julia> using CAP, MonoidalCategories, CartesianCategories, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, QuotientCategories, LocalesForCAP, FpCategories, AdditiveClosuresForCAP, FreydCategoriesForCAP, PresheafCategories, FiniteCocompletions

julia> # extracted from examples/SkeletalInitialTerminal.g

julia> true
true

julia> sFinSets =
          SkeletalFinSetsAsFiniteStrictCoproductCompletionOfTerminalCategory
SkeletalFinSetsAsFiniteStrictCoproductCompletionOfTerminalCategory

julia> m = ObjectConstructor( sFinSets, 8 )
|8|

julia> IsInitial( m )
false

julia> IsTerminal( m )
false

julia> i = InitialObject( sFinSets )
|0|

julia> IsEmpty( AsList( i ) )
true

julia> Display( i )
∅

julia> IsInitial( i )
true

julia> IsTerminal( i )
false

julia> iota = UniversalMorphismFromInitialObject( m )
|0| → |8|

julia> ii = InitialObjectFunctorial( sFinSets )
|0| → |0|

julia> IsIsomorphism( ii )
true

julia> ii
|0| ⭇ |0|

julia> t = TerminalObject( sFinSets )
|1|

julia> AsList( t )
0:0

julia> Display( t )
[ 0 ]

julia> IsInitial( t )
false

julia> IsTerminal( t )
true

julia> pi = UniversalMorphismIntoTerminalObject( m )
|8| → |1|

julia> IsIdenticalObj( Target( pi ), t )
true

julia> pi_t = UniversalMorphismIntoTerminalObjectWithGivenTerminalObject( m, t )
|8| → |1|

julia> Display( pi_t )
[ 0,..., 7 ] ⱶ[ 0, 0, 0, 0, 0, 0, 0, 0 ]→ [ 0 ]

julia> pi == pi_t
true

```
