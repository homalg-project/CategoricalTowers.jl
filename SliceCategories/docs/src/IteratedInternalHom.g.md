```jldoctest AutoDocTests
julia> using CAP, MonoidalCategories, CartesianCategories, ToolsForCategoricalTowers, Toposes, Locales, FpCategories, FreydCategoriesForCAP, FinSetsForCAP, Singular, MatricesForHomalg, AdditiveClosuresForCAP, SliceCategories

julia> # extracted from examples/IteratedInternalHom.g

julia> true
true

julia> Q = HomalgFieldOfRationalsInSingular( );

julia> R = Q["x,y"];

julia> x = Indeterminates( R )[1]
x

julia> y = Indeterminates( R )[2]
y

julia> P = CategoryOfRows( R )
Rows( Q[x,y] )

julia> S = SliceCategoryOverTensorUnit( P )
SliceCategoryOverTensorUnit( Rows( Q[x,y] ) )

julia> I = HomalgMatrix( [ [ x^2 ], [ x*y ] ], 2, 1, R ) / P / S
An object in the slice category given by: <A morphism in Rows( Q[x,y] )>

julia> J = HomalgMatrix( [ [ x ] ], 1, 1, R ) / P / S
An object in the slice category given by: <A morphism in Rows( Q[x,y] )>

julia> iota = InternalHom( UniversalMorphismIntoTerminalObject( J ), I )
A morphism in the slice category given by: <A morphism in Rows( Q[x,y] )>

julia> Display( iota )
Source: 
A row module over Q[x,y] of rank 2

Matrix: 
[x, 0
0, x]

Range: 
A row module over Q[x,y] of rank 2

A morphism in Rows( Q[x,y] )

A morphism in the slice category given by the above data

julia> iota = InternalHom( J, iota )
A morphism in the slice category given by: <A morphism in Rows( Q[x,y] )>

julia> Display( iota )
Source: 
A row module over Q[x,y] of rank 2

Matrix: 
[y
x]

Range: 
A row module over Q[x,y] of rank 1

A morphism in Rows( Q[x,y] )

A morphism in the slice category given by the above data

julia> iota = InternalHom( J, iota )
A morphism in the slice category given by: <A morphism in Rows( Q[x,y] )>

julia> Display( iota )
Source: 
A row module over Q[x,y] of rank 1

Matrix: 
[1]

Range: 
A row module over Q[x,y] of rank 1

A morphism in Rows( Q[x,y] )

A morphism in the slice category given by the above data

julia> iota == InternalHom( J, iota )
true

julia> IsIsomorphism( iota )
true

julia> Display( Source( iota ) )
Source: 
A row module over Q[x,y] of rank 1

Matrix: 
[1]

Range: 
A row module over Q[x,y] of rank 1

A morphism in Rows( Q[x,y] )

An object in the slice category given by the above data

julia> Source( iota ) == Target( iota )
true

```
