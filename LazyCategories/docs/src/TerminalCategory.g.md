
```jldoctest AutoDocTests
julia> using CAP, CartesianCategories, MonoidalCategories, AdditiveClosuresForCAP, ToolsForCategoricalTowers, Toposes, LazyCategories

julia> # extracted from examples/TerminalCategory.g

julia> T = TerminalCategoryWithMultipleObjects( )
TerminalCategoryWithMultipleObjects( )

julia> true
true

julia> L = LazyCategory( T; primitive_operations = true, optimize = 0 )
LazyCategory( TerminalCategoryWithMultipleObjects( ) )

julia> a = "a" / T / L
<An evaluated object in LazyCategory( TerminalCategoryWithMultipleObjects( ) )>

julia> Display( a )
a

An evaluated object given by the above data
julia> IsWellDefined( a )
true

julia> IsWellDefined( DirectSum( a, a ) )
true

julia> IsWellDefined( IdentityMorphism( DirectSum( a, a ) ) )
true

julia> aa = ObjectConstructor( T, "a" ) / L
<An evaluated object in LazyCategory( TerminalCategoryWithMultipleObjects( ) )>

julia> Display( aa )
a

An evaluated object given by the above data

julia> a == aa
true

julia> b = "b" / T / L
<An evaluated object in LazyCategory( TerminalCategoryWithMultipleObjects( ) )>

julia> Display( b )
b

An evaluated object given by the above data

julia> a == b
false

julia> t = TensorProduct( a, b )
<An object in LazyCategory( TerminalCategoryWithMultipleObjects( ) )>

julia> Display( t )
TensorProductOnObjects( <An evaluated object in LazyCategory( TerminalCategoryWithMultipleObjects( ) )>, <An evaluated object in LazyCategory( TerminalCategoryWithMultipleObjects( ) )> )

julia> a == t
false

julia> TensorProduct( a, a ) == t
false

julia> m = MorphismConstructor( EvaluatedCell( a ), "m", EvaluatedCell( b ) ) / L
<An evaluated morphism in LazyCategory( TerminalCategoryWithMultipleObjects( ) )>

julia> Display( m )
a
|
| m
v
b

An evaluated morphism given by the above data

julia> IsWellDefined( m )
true

julia> n = MorphismConstructor( EvaluatedCell( a ), "n", EvaluatedCell( b ) ) / L
<An evaluated morphism in LazyCategory( TerminalCategoryWithMultipleObjects( ) )>

julia> Display( n )
a
|
| n
v
b

An evaluated morphism given by the above data

julia> IsEqualForMorphisms( m, n )
false

julia> IsCongruentForMorphisms( m, n )
true

julia> m == n
true

julia> id = IdentityMorphism( a )
<A morphism in LazyCategory( TerminalCategoryWithMultipleObjects( ) )>

julia> Display( id )
IdentityMorphism( <An evaluated object in LazyCategory( TerminalCategoryWithMultipleObjects( ) )> )

julia> m == id
false

julia> id == MorphismConstructor( EvaluatedCell( a ), "xy", EvaluatedCell( a ) ) / L
true

julia> z = ZeroMorphism( a, a )
<A morphism in LazyCategory( TerminalCategoryWithMultipleObjects( ) )>

julia> Display( z )
ZeroMorphism( <An evaluated object in LazyCategory( TerminalCategoryWithMultipleObjects( ) )>, <An evaluated object in LazyCategory( TerminalCategoryWithMultipleObjects( ) )> )

julia> id == z
true

```
