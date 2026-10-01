```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, CartesianCategories, QuotientCategories, LinearAlgebraForCAP, LinearClosuresForCAP, AdditiveClosuresForCAP, FreydCategoriesForCAP, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, FpCategories, FpLinearCategories, Locales, FiniteCocompletions, PresheafCategories, SubcategoriesForCAP, FunctorCategories

julia> q = FinQuiver( "q(4)[x:1->1,a:1->2,b:2->4,c:1->3,d:3->4,y:4->4]" )
FinQuiver( "q(1,2,3,4)[x:1→1,a:1→2,b:2→4,c:1→3,d:3→4,y:4→4]" )

julia> F = PathCategory( q )
PathCategory( FinQuiver( "q(1,2,3,4)[x:1→1,a:1→2,b:2→4,c:1→3,d:3→4,y:4→4]" ) )

julia> k = HomalgFieldOfRationals( );

julia> kF = k[F]
Q-LinearClosure( PathCategory( FinQuiver( "q(1,2,3,4)[x:1→1,a:1→2,b:2→4,c:1→3,d:3→4,
y:4→4]" ) ) )

julia> quo_kF = kF / [ kF.x^3, kF.y^2 ]
Q-LinearClosure( PathCategory( FinQuiver( "q(1,2,3,4)[x:1→1,a:1→2,b:2→4,c:1→3,d:3→4,
y:4→4]" ) ) ) / [ 1*x^3, 1*y^2 ]

julia> Dimension( quo_kF )
29

julia> IsAdmissibleAlgebroid( quo_kF )
true

julia> A = AlgebroidFromDataTables( quo_kF )
Q-algebroid( [1,2,3,4][x:1→1,a:1→2,b:2→4,c:1→3,d:3→4,y:4→4] ) defined by 4 objects
and 6 generating morphisms

julia> Dimension( A )
29

julia> IsAdmissibleAlgebroid( A )
true

julia> PSh = PreSheaves( A )
PreSheaves( Q-algebroid( [1,2,3,4][x:1→1,a:1→2,b:2→4,c:1→3,d:3→4,y:4→4] ) defined
by 4 objects and 6 generating morphisms, Rows( Q ) )

julia> P = PSh["4"]
<(1)->12, (2)->2, (3)->2, (4)->2; (x)->12x12, (a)->2x12, (b)->2x2,
(c)->2x12, (d)->2x2, (y)->2x2>

julia> IsProjective( P )
true

julia> Display( P( A["x" ] ) )
Source: 
A row module over Q of rank 12

Matrix: 
[0   0   1   0   0   0   0   0   0   0   0   0]
[0   0   0   1   0   0   0   0   0   0   0   0]
[0   0   0   0   0   0   1   0   0   0   0   0]
[0   0   0   0   0   0   0   1   0   0   0   0]
[0   0   0   0   0   0   0   0   1   0   0   0]
[0   0   0   0   0   0   0   0   0   1   0   0]
[0   0   0   0   0   0   0   0   0   0   0   0]
[0   0   0   0   0   0   0   0   0   0   0   0]
[0   0   0   0   0   0   0   0   0   0   1   0]
[0   0   0   0   0   0   0   0   0   0   0   1]
[0   0   0   0   0   0   0   0   0   0   0   0]
[0   0   0   0   0   0   0   0   0   0   0   0]

Range: 
A row module over Q of rank 12

A morphism in Rows( Q )

julia> Display( P( A["a" ] ) )
Source: 
A row module over Q of rank 2

Matrix: 
[1   0   0   0   0   0   0   0   0   0   0   0]
[0   0   0   0   1   0   0   0   0   0   0   0]

Range: 
A row module over Q of rank 12

A morphism in Rows( Q )

julia> Display( P( A["b" ] ) )
Source: 
A row module over Q of rank 2

Matrix: 
[1   0]
[0   1]

Range: 
A row module over Q of rank 2

A morphism in Rows( Q )

julia> Display( P( A["c" ] ) )
Source: 
A row module over Q of rank 2

Matrix: 
[0   1   0   0   0   0   0   0   0   0   0   0]
[0   0   0   0   0   1   0   0   0   0   0   0]

Range: 
A row module over Q of rank 12

A morphism in Rows( Q )

julia> Display( P( A["d" ] ) )
Source: 
A row module over Q of rank 2

Matrix: 
[1   0]
[0   1]

Range: 
A row module over Q of rank 2

A morphism in Rows( Q )

julia> Display( P( A["y" ] ) )
Source: 
A row module over Q of rank 2

Matrix: 
[0   1]
[0   0]

Range: 
A row module over Q of rank 2

A morphism in Rows( Q )

julia> i_P = MonomorphismIntoSomeInjectiveObject( P )
<(1)->12x12, (2)->2x12, (3)->2x12, (4)->2x48>

julia> IsMonomorphism(i_P)
true

julia> IsWellDefined( i_P )
true

julia> Display( i_P( A["1"] ) )
Source: 
A row module over Q of rank 12

Matrix: 
[0   0   1   0   0   0   0   0   0   0   0   0]
[0   0   0   0   0   1   0   0   0   0   0   0]
[0   1   0   0   0   0   0   0   0   0   0   0]
[0   0   0   0   1   0   0   0   0   0   0   0]
[0   0   0   0   0   0   0   0   1   0   0   0]
[0   0   0   0   0   0   0   0   0   0   0   1]
[1   0   0   0   0   0   0   0   0   0   0   0]
[0   0   0   1   0   0   0   0   0   0   0   0]
[0   0   0   0   0   0   0   1   0   0   0   0]
[0   0   0   0   0   0   0   0   0   0   1   0]
[0   0   0   0   0   0   1   0   0   0   0   0]
[0   0   0   0   0   0   0   0   0   1   0   0]

Range: 
A row module over Q of rank 12

A morphism in Rows( Q )

julia> Display( i_P( A["2"] ) )
Source: 
A row module over Q of rank 2

Matrix: 
[0   0   1   0   0   0   0   0   0   0   0   0]
[0   0   0   0   0   0   0   0   1   0   0   0]

Range: 
A row module over Q of rank 12

A morphism in Rows( Q )

julia> Display( i_P( A["3"] ) )
Source: 
A row module over Q of rank 2

Matrix: 
[0   0   0   0   0   1   0   0   0   0   0   0]
[0   0   0   0   0   0   0   0   0   0   0   1]

Range: 
A row module over Q of rank 12

A morphism in Rows( Q )

julia> Display( i_P( A["4"] ) )
Source: 
A row module over Q of rank 2

Matrix: 
[0   0   0   0   0   0   1   0   0   0   0   0   0   0   0   0   0   0   0   1   0   0   0   0   0   0   0   0   0   0   0   0   0   0   1   0   0   0   0   0   0   0   0   0   0   0   0   1]
[0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   1   0   0   0   0   0   0   0   0   0   0   0   0   1   0   0   0   0]

Range: 
A row module over Q of rank 48

A morphism in Rows( Q )

julia> # @drop_example_in_Julia (was moved there manually due to display issues for matrices)

```
