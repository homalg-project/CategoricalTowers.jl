```jldoctest
julia> using CAP, MonoidalCategories, CartesianCategories, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, QuotientCategories, LocalesForCAP, FpCategories, AdditiveClosuresForCAP, FreydCategoriesForCAP, PresheafCategories, FiniteCocompletions

julia> true
true

julia> T = FiniteStrictCoproductCompletion( InitialCategory( ) )
FiniteStrictCoproductCompletion( InitialCategory( ) )

julia> i = InitialObject( T )
<An object in FiniteStrictCoproductCompletion( InitialCategory( ) )>

julia> t = TerminalObject( T )
<An object in FiniteStrictCoproductCompletion( InitialCategory( ) )>

julia> z = ZeroObject( T )
<An object in FiniteStrictCoproductCompletion( InitialCategory( ) )>

julia> ViewObj( ObjectDatum( i ) )
[ 0, [  ] ]

julia> ViewObj( ObjectDatum( t ) )
[ 0, [  ] ]

julia> ViewObj( ObjectDatum( z ) )
[ 0, [  ] ]

julia> IsEqualForObjects( i, z )
true

julia> IsIdenticalObj( i, z )
false

julia> IsEqualForObjects( t, z )
true

julia> IsIdenticalObj( t, z )
false

julia> IsWellDefined( z )
true

julia> id_z = IdentityMorphism( z );

julia> IsZeroForMorphisms( id_z )
true

julia> fn_z = ZeroObjectFunctorial( T )
<A morphism in FiniteStrictCoproductCompletion( InitialCategory( ) )>

julia> IsWellDefined( fn_z )
true

julia> IsEqualForMorphisms( id_z, fn_z )
true

julia> IsCongruentForMorphisms( id_z, fn_z )
true

```
