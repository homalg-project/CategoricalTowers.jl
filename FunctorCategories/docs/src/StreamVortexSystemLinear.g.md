```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, CartesianCategories, QuotientCategories, LinearAlgebraForCAP, LinearClosuresForCAP, AdditiveClosuresForCAP, FreydCategoriesForCAP, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, FpCategories, FpLinearCategories, Locales, FiniteCocompletions, PresheafCategories, SubcategoriesForCAP, FunctorCategories

julia> q = FinQuiver( "q(o)[x:o->o]" )
FinQuiver( "q(o)[x:o→o]" )

julia> F = PathCategory( q )
PathCategory( FinQuiver( "q(o)[x:o→o]" ) )

julia> C = F / [ [ F.x^(3+4), F.x^3 ] ]
PathCategory( FinQuiver( "q(o)[x:o→o]" ) ) / [ x^7 == x^3 ]

julia> Q = HomalgFieldOfRationals( )
Rational field

julia> QC = Q[C]
Q-LinearClosure( PathCategory( FinQuiver( "q(o)[x:o→o]" ) ) / [ x^7 == x^3 ] )

julia> QC = AlgebroidFromDataTables( QC )
Q-algebroid( [o][x:o→o] ) defined by 1 object and 1 generating morphism

julia> x = QC.x
<1*x:(o) → (o)>

julia> IsMonomorphism( x )
false

julia> IsEpimorphism( x )
false

julia> PSh = PreSheaves( QC )
PreSheaves( Q-algebroid( [o][x:o→o] ) defined by 1 object and 1 generating morphism, Rows( Q ) )

julia> H = Target( PSh )
Rows( Q )

julia> Go = 8 / H
<A row module over Q of rank 8>

julia> Gx = [ 5, 0, 3, 1, 1, 4, 3, 2 ]
8-element Vector{Int64}:
 5
 0
 3
 1
 1
 4
 3
 2

julia> Gx = IdentityMat( 8 )[1 + Gx]
8-element Vector{Any}:
 [0, 0, 0, 0, 0, 1, 0, 0]
 [1, 0, 0, 0, 0, 0, 0, 0]
 [0, 0, 0, 1, 0, 0, 0, 0]
 [0, 1, 0, 0, 0, 0, 0, 0]
 [0, 1, 0, 0, 0, 0, 0, 0]
 [0, 0, 0, 0, 1, 0, 0, 0]
 [0, 0, 0, 1, 0, 0, 0, 0]
 [0, 0, 1, 0, 0, 0, 0, 0]

julia> Gx = HomalgMatrix( Gx, 8, 8, Q )
[0   0   0   0   0   1   0   0]
[1   0   0   0   0   0   0   0]
[0   0   0   1   0   0   0   0]
[0   1   0   0   0   0   0   0]
[0   1   0   0   0   0   0   0]
[0   0   0   0   1   0   0   0]
[0   0   0   1   0   0   0   0]
[0   0   1   0   0   0   0   0]

julia> Gx = MorphismConstructor( Go, Gx, Go )
<A morphism in Rows( Q )>

julia> G = CreatePreSheafByValues( PSh, PairGAP( [ Go ], [ Gx ] ) )
<(o)->8; (x)->8x8>

julia> IsWellDefined( G )
true

julia> p = CoYonedaLemmaCoequalizerPair( G );

julia> p[1]
<(o)->56; (x)->56x56>

julia> ViewObj( p[2] )
[ <(o)->56x56>, <(o)->56x56> ]

julia> cy = ProjectionOntoCoequalizer( p[2] )
<(o)->56x8>

julia> pi = EpimorphismFromSomeProjectiveObject( G )
<(o)->14x8>

julia> CoimageObject( cy ) == CoimageObject( pi )
false

julia> ps = EpimorphismFromSomeProjectiveObjectUsingSplits( G )
<(o)->14x8>

julia> nf = CoimageObject( ps )
<(o)->8; (x)->8x8>

julia> nf == CoimageObject( cy )
false

julia> section = SectionFromOptimizedCoYonedaProjectiveObjectIntoCoYonedaProjectiveObject( G )
<A morphism in AdditiveClosure( Q-algebroid( [o][x:o→o] ) defined by 1 object and 1 generating morphism ) defined by a 2 x 8 matrix of underlying morphisms>

julia> IsWellDefined( section )
true

julia> Emb = EmbeddingFunctorOfFiniteStrictCoproductCompletionIntoPreSheaves( PSh )
The embedding functor of the finite coproduct completion into f.p. presheaves

julia> ip = PreCompose( Emb( section ), cy )
<(o)->14x8>

julia> IsEqualAsFactorobjects( pi, ip )
true

julia> pi == ip
false

julia> CoimageObject( ip ) == CoimageObject( pi )
true

julia> retraction = RetractionFromCoYonedaProjectiveObjectOntoOptimizedCoYonedaProjectiveObject( G )
<A morphism in AdditiveClosure( Q-algebroid( [o][x:o→o] ) defined by 1 object and 1 generating morphism ) defined by a 8 x 2 matrix of underlying morphisms>

julia> IsWellDefined( retraction )
true

julia> IsEqualToIdentityMorphism( PreCompose( section, retraction ) )
true

julia> co = ProjectionOntoCoequalizer( OptimizedCoYonedaLemmaCoequalizerPair( G )[2] )
<(o)->14x8>

julia> IsEqualAsFactorobjects( pi, co )
true

julia> pi == co
false

julia> CoimageObject( pi ) == CoimageObject( co )
true
```
