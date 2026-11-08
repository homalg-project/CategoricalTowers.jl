```jldoctest AutoDocTests
julia> using CAP, MonoidalCategories, CartesianCategories, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, QuotientCategories, LocalesForCAP, FpCategories, AdditiveClosuresForCAP, FreydCategoriesForCAP, PresheafCategories, FiniteCocompletions

julia> # extracted from examples/CocartesianCodiagonal.g

julia> true
true

julia> true
true

julia> true
true

julia> Q = FinQuiver( "Q(a)[]" )
FinQuiver( "Q(a)[]" )

julia> C = PathCategory( Q )
PathCategory( FinQuiver( "Q(a)[]" ) )

julia> SetName( C.a, "C.a" )

julia> UC = FiniteStrictCoproductCompletion( C )
FiniteStrictCoproductCompletion( PathCategory( FinQuiver( "Q(a)[]" ) ) )

julia> a = UC.a
<An object in
 FiniteStrictCoproductCompletion( PathCategory( FinQuiver( "Q(a)[]" ) ) )>

julia> aa = Coproduct( a, a )
<An object in
 FiniteStrictCoproductCompletion( PathCategory( FinQuiver( "Q(a)[]" ) ) )>

julia> PrintObj( ObjectDatum( aa ) )
[ 2, [ C.a, C.a ] ]

julia> a == aa
false

julia> HomStructure( a, aa )
|2|

julia> hom_a_aa = MorphismsOfExternalHom( a, aa );

julia> Perform( hom_a_aa, ViewObj )
<A morphism in FiniteStrictCoproductCompletion( PathCategory( FinQuiver( "Q(a)[]" ) ) )>
<A morphism in FiniteStrictCoproductCompletion( PathCategory( FinQuiver( "Q(a)[]" ) ) )>

julia> hom_a_aa[1] == InjectionOfCofactorOfCoproduct( [ a, a ], 1 )
true

julia> hom_a_aa[2] == InjectionOfCofactorOfCoproduct( [ a, a ], 2 )
true

julia> HomStructure( aa, a )
|1|

julia> hom_aa_a = MorphismsOfExternalHom( aa, a );

julia> delta = hom_aa_a[1]
<A morphism in FiniteStrictCoproductCompletion( PathCategory( FinQuiver( "Q(a)[]" ) ) )>

julia> Source( delta ) == aa
true

julia> Target( delta ) == a
true

julia> IsOne( ComponentOfMorphismFromCoproduct( delta, [ a, a ], 1 ) )
true

julia> IsOne( ComponentOfMorphismFromCoproduct( delta, [ a, a ], 2 ) )
true

julia> IsWellDefined( delta )
true

julia> id_a = IdentityMorphism( C.a )
id(a):(a) → (a)

julia> delta == CocartesianCodiagonal( a, 2 )
true

```
