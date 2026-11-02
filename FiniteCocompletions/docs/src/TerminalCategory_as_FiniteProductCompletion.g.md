```jldoctest AutoDocTests
julia> using CAP, MonoidalCategories, CartesianCategories, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, QuotientCategories, LocalesForCAP, FpCategories, AdditiveClosuresForCAP, FreydCategoriesForCAP, PresheafCategories, FiniteCocompletions

julia> # extracted from examples/TerminalCategory_as_FiniteProductCompletion.g

julia> true
true

julia> T = FiniteStrictProductCompletion( InitialCategory( ) )
FiniteStrictProductCompletion( InitialCategory( ) )

julia> i = InitialObject( T )
<An object in FiniteStrictProductCompletion( InitialCategory( ) )>

julia> t = TerminalObject( T )
<An object in FiniteStrictProductCompletion( InitialCategory( ) )>

julia> z = ZeroObject( T )
<An object in FiniteStrictProductCompletion( InitialCategory( ) )>

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

julia> id_z = IdentityMorphism( z )
<A morphism in FiniteStrictProductCompletion( InitialCategory( ) )>

julia> fn_z = ZeroObjectFunctorial( T )
<A morphism in FiniteStrictProductCompletion( InitialCategory( ) )>

julia> IsWellDefined( fn_z )
true

julia> IsEqualForMorphisms( id_z, fn_z )
true

julia> IsCongruentForMorphisms( id_z, fn_z )
true

```
