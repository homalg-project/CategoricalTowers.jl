
```jldoctest AutoDocTests
julia> using CAP, MonoidalCategories, CartesianCategories, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, QuotientCategories, LocalesForCAP, FpCategories, AdditiveClosuresForCAP, FreydCategoriesForCAP, PresheafCategories, FiniteCocompletions

julia> # extracted from examples/FiniteStrictCoproductCompletionOfObjectFiniteCategory_poset.g

julia> true
true

julia> q = FinQuiver( "q(M,A,B,J)[a:M->A,b:M->B,i:A->J,j:B->J]" )
FinQuiver( "q(M,A,B,J)[a:M→A,b:M→B,i:A→J,j:B→J]" )

julia> D = PathCategory( q )
PathCategory( FinQuiver( "q(M,A,B,J)[a:M→A,b:M→B,i:A→J,j:B→J]" ) )

julia> L = PosetOfCategory( D )
PosetOfCategory( PathCategory( FinQuiver( "q(M,A,B,J)[a:M→A,b:M→B,i:A→J,j:B→J]" ) ) )

julia> L.ai == L.bj
true

julia> Perform( SetOfObjects( L ), Display )
(M)

An object in the poset given by the above data
(A)

An object in the poset given by the above data
(B)

An object in the poset given by the above data
(J)

An object in the poset given by the above data

julia> Ltilde = FiniteStrictCoproductCompletionOfObjectFiniteCategory( L )
FiniteStrictCoproductCompletionOfObjectFiniteCategory( PosetOfCategory( PathCategory( FinQuiver( "q(M,A,B,J)[a:M→A,b:M→B,i:A→J,j:B→J]" ) ) ) )

julia> Length( SetOfObjects( Ltilde ) )
16

julia> Lhat = PosetOfCategory( Ltilde )
PosetOfCategory( FiniteStrictCoproductCompletionOfObjectFiniteCategory( PosetOfCategory( PathCategory( FinQuiver( "q(M,A,B,J)[a:M→A,b:M→B,i:A→J,j:B→J]" ) ) ) ) )

julia> Length( ListPrimitivelyInstalledOperationsOfCategory( Lhat ) )
10

julia> IsCategoryWithDecidableColifts( Lhat )
true

julia> IsCategoryWithDecidableLifts( Lhat )
true

julia> IsFiniteCategory( Lhat )
true

julia> IsEquippedWithHomomorphismStructure( Lhat )
true

julia> # IsJoinSemiLattice( Lhat ) still fails in Julia

```
