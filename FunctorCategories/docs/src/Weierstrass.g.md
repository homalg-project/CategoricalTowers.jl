```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, CartesianCategories, QuotientCategories, LinearAlgebraForCAP, LinearClosuresForCAP, AdditiveClosuresForCAP, FreydCategoriesForCAP, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, FpCategories, FpLinearCategories, Locales, FiniteCocompletions, PresheafCategories, SubcategoriesForCAP, FunctorCategories

julia> Q = HomalgFieldOfRationals( )
Rational field

julia> R, x = Q["x"]
(Univariate polynomial ring in x over QQ, x)

julia> p = x^2-x-1
x^2 - x - 1

julia> d = 2
2

julia> cmat1 = HomalgMatrix( [[0, 1], [1, 1]], 1 * d, 1 * d, Q )
[0   1]
[1   1]

julia> p^2
x^4 - 2*x^3 - x^2 + 2*x + 1

julia> cmat2 = HomalgMatrix( [[0, 0, 0, -1], [1, 0, 0, -2], [0, 1, 0,  1], [0, 0, 1,  2]], 2 * d, 2 * d, Q )
[0   0   0   -1]
[1   0   0   -2]
[0   1   0    1]
[0   0   1    2]

julia> p^3
x^6 - 3*x^5 + 5*x^3 - 3*x - 1

julia> cmat3 = HomalgMatrix( [[0, 0, 0, 0, 0, 1], [1, 0, 0, 0, 0, 3], [0, 1, 0, 0, 0, 0], [0, 0, 1, 0, 0, -5], [0, 0, 0, 1, 0, 0], [0, 0, 0, 0, 1, 3]], 3 * d, 3 * d, Q )
[0   0   0   0   0    1]
[1   0   0   0   0    3]
[0   1   0   0   0    0]
[0   0   1   0   0   -5]
[0   0   0   1   0    0]
[0   0   0   0   1    3]

julia> cmat = DiagMat( Q, [ cmat1, cmat1, cmat3 ] )
[0   1   0   0   0   0   0   0   0    0]
[1   1   0   0   0   0   0   0   0    0]
[0   0   0   1   0   0   0   0   0    0]
[0   0   1   1   0   0   0   0   0    0]
[0   0   0   0   0   0   0   0   0    1]
[0   0   0   0   1   0   0   0   0    3]
[0   0   0   0   0   1   0   0   0    0]
[0   0   0   0   0   0   1   0   0   -5]
[0   0   0   0   0   0   0   1   0    0]
[0   0   0   0   0   0   0   0   1    3]

julia> n = NrRows( cmat )
10

julia> mat =
         [ [     0,     0,     3,     0,    -1,     3,    -8,     6,     0,    -3 ],
           [    39,    15,   -25,     2,     0,    -9,    10,   -15,     2,     1 ],
           [    21,     5,    -5,     3,    -1,     2,   -16,     5,     0,    -7 ],
           [    30,    10,    -4,     3,    -5,    10,   -44,    22,    -2,   -18 ],
           [    40,     0,   -66,     9,    27,   -70,   170,  -140,     9,    62 ],
           [  -204,     0,    82,   -57,   -36,    50,    29,   100,     5,    13 ],
           [   -52,   -15,    18,    -6,     2,    -1,    30,    -5,     0,    14 ],
           [   105,     0,   -51,    29,    22,   -36,    14,   -72,    -1,     4 ],
           [     6,     1,   -11,     1,     3,    -9,    19,   -18,     0,     7 ],
           [   152,    45,   -52,    17,    -7,     5,   -93,    19,     0,   -43 ] ];

julia> mat = HomalgMatrix( mat, 10, 10 , Q );

julia> q = FinQuiver( "q(o)[x:o->o]" )
FinQuiver( "q(o)[x:o→o]" )

julia> F = PathCategory( q )
PathCategory( FinQuiver( "q(o)[x:o→o]" ) )

julia> QF = Q[F]
Q-LinearClosure( PathCategory( FinQuiver( "q(o)[x:o→o]" ) ) )

julia> A = QF / [ QF.x^6 - 3 * QF.x^5 + 5 * QF.x^3 - 3 * QF.x - QF.id_o ]
Q-LinearClosure( PathCategory( FinQuiver( "q(o)[x:o→o]" ) ) ) / [ 1*x^6 + (-3)*x^5 + 5*x^3 + (-3)*x + (-1)*id(o) ]

julia> A = AlgebroidFromDataTables( A )
Q-algebroid( [o][x:o→o] ) defined by 1 object and 1 generating morphism

julia> o = A.o
<(o)>

julia> x = A.x
<1*x:(o) → (o)>

julia> IsMonomorphism( A.x )
true

julia> IsEpimorphism( A.x )
true

julia> IsIsomorphism( A.x )
true

julia> Qmat = RangeCategoryOfHomomorphismStructure( A )
Rows( Q )

julia> U = n / Qmat
<A row module over Q of rank 10>

julia> phi = mat / Qmat
<A morphism in Rows( Q )>

julia> PSh = PreSheaves( A )
PreSheaves( Q-algebroid( [o][x:o→o] ) defined by 1 object and 1 generating morphism, Rows( Q ) )

julia> G = CreatePreSheafByValues( PSh, PairGAP( [ U ], [ phi ] ) )
<(o)->10; (x)->10x10>

julia> IsWellDefined( G )
true

julia> p = CoYonedaLemmaCoequalizerPair( G );

julia> cy = ProjectionOntoCoequalizer( p[2] )
<(o)->60x10>

julia> pi = EpimorphismFromSomeProjectiveObject( G )
<(o)->18x10>

julia> pmat = UnderlyingMatrix( CoimageObject( pi ).x )
[      0           1          0           0           0          0   0   0   0   0]
[      0           0          1           0           0          0   0   0   0   0]
[      0           0          0           1           0          0   0   0   0   0]
[      0           0          0           0           1          0   0   0   0   0]
[      0           0          0           0           0          1   0   0   0   0]
[      1           3          0          -5           0          3   0   0   0   0]
[      0           0          0           0           0          0   0   1   0   0]
[-15//92      -2//69     31//92      -4//23     -11//92    11//138   1   1   0   0]
[      0           0          0           0           0          0   0   0   0   1]
[97//204   2003//816   305//136   -605//272   -703//408   803//816   0   0   1   1]

julia> range3 = collect((1):(3 * d))
6-element Vector{Int64}:
 1
 2
 3
 4
 5
 6

julia> pmat3 = CertainColumns( CertainRows( pmat, range3 ), range3 )
[0   1   0    0   0   0]
[0   0   1    0   0   0]
[0   0   0    1   0   0]
[0   0   0    0   1   0]
[0   0   0    0   0   1]
[1   3   0   -5   0   3]

julia> pmat3 == TransposedMatrix( cmat3 )
true

julia> range1 = collect((1):(1 * d))
2-element Vector{Int64}:
 1
 2

julia> pmat1_1 = CertainColumns( CertainRows( pmat, 3 * d + range1 ), 3 * d + range1 )
[0   1]
[1   1]

julia> pmat1_1 == TransposedMatrix( cmat1 )
true

julia> pmat1_2 = CertainColumns( CertainRows( pmat, 4 * d + range1 ), 4 * d + range1 )
[0   1]
[1   1]

julia> pmat1_2 == TransposedMatrix( cmat1 )
true

julia> CoimageObject( cy ) == CoimageObject( pi )
false

julia> ps = EpimorphismFromSomeProjectiveObjectUsingSplits( G )
<(o)->18x10>

julia> nf = CoimageObject( ps )
<(o)->10; (x)->10x10>

julia> nf == CoimageObject( cy )
false

julia> section = SectionFromOptimizedCoYonedaProjectiveObjectIntoCoYonedaProjectiveObject( G )
<A morphism in AdditiveClosure( Q-algebroid( [o][x:o→o] ) defined by 1 object and 1 generating morphism ) defined by a 3 x 10 matrix of underlying morphisms>

julia> IsWellDefined( section )
true

julia> Emb = EmbeddingFunctorOfFiniteStrictCoproductCompletionIntoPreSheaves( PSh )
The embedding functor of the finite coproduct completion into f.p. presheaves

julia> ip = PreCompose( Emb( section ), cy )
<(o)->18x10>

julia> IsEqualAsFactorobjects( pi, ip )
true

julia> pi == ip
false

julia> CoimageObject( ip ) == CoimageObject( pi )
true

julia> retraction = RetractionFromCoYonedaProjectiveObjectOntoOptimizedCoYonedaProjectiveObject( G )
<A morphism in AdditiveClosure( Q-algebroid( [o][x:o→o] ) defined by 1 object and 1 generating morphism ) defined by a 10 x 3 matrix of underlying morphisms>

julia> IsWellDefined( retraction )
true

julia> IsEqualToIdentityMorphism( PreCompose( section, retraction ) )
true

julia> co = ProjectionOntoCoequalizer( OptimizedCoYonedaLemmaCoequalizerPair( G )[2] )
<(o)->18x10>

julia> IsEqualAsFactorobjects( pi, co )
true

julia> pi == co
false

julia> CoimageObject( pi ) == CoimageObject( co )
true

```

