```jldoctest AutoDocTests
julia> using CAP, MonoidalCategories, CartesianCategories, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, QuotientCategories, LocalesForCAP, FpCategories, AdditiveClosuresForCAP, FreydCategoriesForCAP, PresheafCategories, FiniteCocompletions

julia> # extracted from examples/FiniteStrictProductCompletion_poset.g

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

julia> Ltilde = FiniteStrictProductCompletion( L )
FiniteStrictProductCompletion( PosetOfCategory( PathCategory( FinQuiver( "q(M,A,B,J)[a:M→A,b:M→B,i:A→J,j:B→J]" ) ) ) )

julia> Ltilde.ai == Ltilde.bj
true

julia> Length( SetOfObjects( Ltilde ) )
16

julia> Lhat = PosetOfCategory( Ltilde )
PosetOfCategory( FiniteStrictProductCompletion( PosetOfCategory( PathCategory( FinQuiver( "q(M,A,B,J)[a:M→A,b:M→B,i:A→J,j:B→J]" ) ) ) ) )

julia> Lhat_objs = SetOfObjects( Lhat );; Length( Lhat_objs )
6

julia> M = Lhat.M;

julia> A = Lhat.A;

julia> B = Lhat.B;

julia> J = Lhat.J;

julia> P = DirectProduct( Lhat.A, Lhat.B );

julia> T = TerminalObject( Lhat );

julia> P == M
false

julia> T == J
false

julia> Lhat_objs == [ T, M, A, B, J, P ]
true

```
