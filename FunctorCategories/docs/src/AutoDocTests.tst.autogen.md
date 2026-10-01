
```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, CartesianCategories, QuotientCategories, LinearAlgebraForCAP, LinearClosuresForCAP, AdditiveClosuresForCAP, FreydCategoriesForCAP, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, FpCategories, FpLinearCategories, Locales, FiniteCocompletions, PresheafCategories, SubcategoriesForCAP, FunctorCategories

julia> C = SimplicialCategoryTruncatedInDegree( 2 )
PathCategory( FinQuiver( "Delta(C0,C1,C2)[id:C1→C0,
s:C0→C1,t:C0→C1,is:C2→C1,it:C2→C1,ps:C1→C2,pt:C1→C2,
mu:C1→C2]" ) ) / [ s⋅id == id(C0), t⋅id == id(C0),
ps⋅is == id(C1), ... ]

julia> Delta2 = CategoryFromNerveData( C )
PathCategory( FinQuiver(
  "Delta(C0,C1,C2)[id:C1→C0,s:C0→C1,t:C0→C1,
                   is:C2→C1,it:C2→C1,
                   ps:C1→C2,pt:C1→C2,mu:C1→C2]" ) )
/ [ s⋅id == id(C0), t⋅id == id(C0), ps⋅is == id(C1), ... ]

julia> N = NerveTruncatedInDegree2( Delta2 )
<An object in PreSheaves( PathCategory( FinQuiver(
  "Delta(C0,C1,C2)[id:C1→C0,s:C0→C1,t:C0→C1,
                   is:C2→C1,it:C2→C1,
                   ps:C1→C2,pt:C1→C2,mu:C1→C2]" ) )
/ [ s⋅id == id(C0), t⋅id == id(C0), ps⋅is == id(C1), ... ],
 SkeletalFinSets )>

julia> IsWellDefined( N )
true

julia> N.C0
|3|

julia> Display( N.C0 )
[ 0, 1, 2 ]

julia> N.C1
|31|

julia> Display( N.C1 )
[ 0,..., 30 ]

julia> N.C2
|393|

julia> Display( N.C2 )
[ 0,..., 392 ]

julia> N.id
|3| → |31|

julia> Display( N.id )
[ 0, 1, 2 ] ⱶ[ 0, 5, 21 ]→ [ 0,..., 30 ]

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, CartesianCategories, QuotientCategories, LinearAlgebraForCAP, LinearClosuresForCAP, AdditiveClosuresForCAP, FreydCategoriesForCAP, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, FpCategories, FpLinearCategories, Locales, FiniteCocompletions, PresheafCategories, SubcategoriesForCAP, FunctorCategories

julia> true
true

julia> q = FinQuiver( "q(a,l,r,i,c,b)[ac:a->c,lc:l->c,ri:r->i,ic:i->c,cb:c->b]" )
FinQuiver( "q(a,l,r,i,c,b)[ac:a→c,lc:l→c,ri:r→i,ic:i→c,cb:c→b]" )

julia> F = PathCategory( q )
PathCategory(
FinQuiver( "q(a,l,r,i,c,b)[ac:a→c,lc:l→c,ri:r→i,ic:i→c,cb:c→b]" ) )

julia> Size( F )
16

julia> P = PosetOfCategory( F )
PosetOfCategory( PathCategory(
FinQuiver( "q(a,l,r,i,c,b)[ac:a→c,lc:l→c,ri:r→i,ic:i→c,cb:c→b]" ) ) )

julia> Size( P )
16

julia> PSh = PreSheaves( P )
PreSheaves( PosetOfCategory( PathCategory(
FinQuiver( "q(a,l,r,i,c,b)[ac:a→c,lc:l→c,ri:r→i,ic:i→c,cb:c→b]" ) ) ),
IntervalCategory )

julia> c = PSh.c
<An object in PreSheaves( PosetOfCategory( PathCategory(
 FinQuiver( "q(a,l,r,i,c,b)[ac:a→c,lc:l→c,ri:r→i,ic:i→c,cb:c→b]" ) ) ),
 IntervalCategory )>

julia> section =
          SectionFromOptimizedCoYonedaProjectiveObjectIntoCoYonedaProjectiveObject( c )
<A morphism in FiniteStrictCoproductCompletion(
 PosetOfCategory( PathCategory(
 FinQuiver( "q(a,l,r,i,c,b)[ac:a→c,lc:l→c,ri:r→i,ic:i→c,cb:c→b]" ) ) ) )>

julia> IsWellDefined( section )
true

julia> IsIsomorphism( section )
true

julia> Display( Source( section ) )
[ 1, [ An object in the poset given by: (c) ] ]

An object in FiniteStrictCoproductCompletion( PosetOfCategory( PathCategory(
FinQuiver( "q(a,l,r,i,c,b)[ac:a→c,lc:l→c,ri:r→i,ic:i→c,cb:c→b]" ) ) ) )
given by the above data

julia> Display( Target( section ) )
[ 5, [ An object in the poset given by: (a),
       An object in the poset given by: (l),
       An object in the poset given by: (r),
       An object in the poset given by: (i),
       An object in the poset given by: (c) ] ]

An object in FiniteStrictCoproductCompletion( PosetOfCategory( PathCategory(
FinQuiver( "q(a,l,r,i,c,b)[ac:a→c,lc:l→c,ri:r→i,ic:i→c,cb:c→b]" ) ) ) )
given by the above data

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, CartesianCategories, QuotientCategories, LinearAlgebraForCAP, LinearClosuresForCAP, AdditiveClosuresForCAP, FreydCategoriesForCAP, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, FpCategories, FpLinearCategories, Locales, FiniteCocompletions, PresheafCategories, SubcategoriesForCAP, FunctorCategories

julia> FinBouquets
FinBouquets

julia> C = UnderlyingCategory( FinBouquets )
PathCategory( FinQuiver( "q(P,L)[b:P→L]" ) )

julia> P = FinBouquets.P
<An object in FinBouquets>

julia> Display( P )
( [ 0 ], [ ] )

julia> L = FinBouquets.L
<An object in FinBouquets>

julia> Display( L )
( [ 0 ], [ 0 ↦ 0 ] )

julia> b = FinBouquets.b
<A morphism in FinBouquets>

julia> Display( b )
Image of <(P)>:
[ 0 ] ⱶ[ 0 ]→ [ 0 ]

Image of <(L)>:
∅ ⱶ[  ]→ [ 0 ]

A morphism in FinBouquets
given by the above data

julia> T = TerminalObject( FinBouquets )
<An object in FinBouquets>

julia> Display( T )
( [ 0 ], [ 0 ↦ 0 ] )

julia> T == L
true

julia> M = CreateBouquet( 3, [ 1, 1, 1, 2 ] )
<An object in FinBouquets>

julia> Display( M )
( [ 0, 1, 2 ], [ 0 ↦ 1, 1 ↦ 1, 2 ↦ 1, 3 ↦ 2 ] )

julia> N = Colimit( [ P, P, P, L, L, L, L ],
                     [ [ 1, b, 3 ],
                       [ 1, b, 4 ],
                       [ 1, b, 5 ],
                       [ 2, b, 6 ] ] )
<An object in FinBouquets>

julia> N == M
true

julia> LL = Coproduct( L, L )
<An object in FinBouquets>

julia> L2 = CreateBouquet( 1, [ 0, 0 ] )
<An object in FinBouquets>

julia> epsilon = CreateBouquetMorphism( LL, [ 0, 0 ], [ 0, 1 ], L2 )
<A morphism in FinBouquets>

julia> IsWellDefined( epsilon )
true

julia> IsEpimorphism( epsilon )
true

julia> IsSplitEpimorphism( epsilon )
false

julia> omega = SubobjectClassifier( FinBouquets )
<An object in FinBouquets>

julia> Display( omega )
( [ 0, 1 ], [ 0 ↦ 0, 1 ↦ 1, 2 ↦ 1 ] )

julia> PM = PowerObject( M )
<An object in FinBouquets>

julia> Display( PM )
( [ 0,..., 7 ],
  [ 0 ↦ 0, 1 ↦ 1, 2 ↦ 2, 3 ↦ 3, 4 ↦ 2, 5 ↦ 3,
    6 ↦ 2, 7 ↦ 3, 8 ↦ 2, 9 ↦ 3, 10 ↦ 2, 11 ↦ 3,
    12 ↦ 2, 13 ↦ 3, 14 ↦ 2, 15 ↦ 3, 16 ↦ 2, 17 ↦ 3,
    18 ↦ 4, 19 ↦ 5, 20 ↦ 6, 21 ↦ 7, 22 ↦ 6, 23 ↦ 7,
    24 ↦ 6, 25 ↦ 7, 26 ↦ 6, 27 ↦ 7, 28 ↦ 6, 29 ↦ 7,
    30 ↦ 6, 31 ↦ 7, 32 ↦ 6, 33 ↦ 7, 34 ↦ 6, 35 ↦ 7,
    36 ↦ 4, 37 ↦ 5, 38 ↦ 6, 39 ↦ 7, 40 ↦ 6, 41 ↦ 7,
    42 ↦ 6, 43 ↦ 7, 44 ↦ 6, 45 ↦ 7, 46 ↦ 6, 47 ↦ 7,
    48 ↦ 6, 49 ↦ 7, 50 ↦ 6, 51 ↦ 7, 52 ↦ 6, 53 ↦ 7 ] )

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, CartesianCategories, QuotientCategories, LinearAlgebraForCAP, LinearClosuresForCAP, AdditiveClosuresForCAP, FreydCategoriesForCAP, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, FpCategories, FpLinearCategories, Locales, FiniteCocompletions, PresheafCategories, SubcategoriesForCAP, FunctorCategories

julia> FinQuivers
FinQuivers

julia> V = FinQuivers.V
<An object in FinQuivers>

julia> Display( V )
( [ 0 ], [ ] )

julia> A = FinQuivers.A
<An object in FinQuivers>

julia> Display( A )
( [ 0, 1 ], [ 0 = [ 0, 1 ] ] )

julia> T = TerminalObject( FinQuivers )
<An object in FinQuivers>

julia> Display( T )
( [ 0 ], [ 0 = [ 0, 0 ] ] )

julia> T == V
false

julia> G = CreateQuiver( 3, [ 0,1, 0,1, 1,2, 2,1, 2,2 ] )
<An object in FinQuivers>

julia> Display( G )
( [ 0, 1, 2 ],
  [ 0 = [ 0, 1 ], 1 = [ 0, 1 ], 2 = [ 1, 2 ],
    3 = [ 2, 1 ], 4 = [ 2, 2 ] ] )

julia> global_G = HomStructure( T, G )
|1|

julia> Display( global_G )
[ 0 ]

julia> discrete = DirectProduct( G, V )
<An object in FinQuivers>

julia> Display( discrete )
( [ 0, 1, 2 ], [ ] )

julia> global_discrete = HomStructure( T, discrete )
|0|

julia> Display( global_discrete )
∅

julia> complete = Exponential( V, G )
<An object in FinQuivers>

julia> Display( complete )
( [ 0, 1, 2 ],
  [ 0 = [ 0, 0 ], 1 = [ 1, 0 ], 2 = [ 2, 0 ], 3 = [ 0, 1 ], 4 = [ 1, 1 ],
    5 = [ 2, 1 ], 6 = [ 0, 2 ], 7 = [ 1, 2 ], 8 = [ 2, 2 ] ] )

julia> global_complete = HomStructure( T, complete )
|3|

julia> Display( global_complete )
[ 0, 1, 2 ]

julia> GA = DirectProduct( G, A )
<An object in FinQuivers>

julia> Display( GA )
( [ 0,..., 5 ],
  [ 0 = [ 0, 4 ], 1 = [ 0, 4 ], 2 = [ 1, 5 ],
    3 = [ 2, 4 ], 4 = [ 2, 5 ] ] )

julia> homAG = HomStructure( A, G )
|5|

julia> Display( homAG )
[ 0,..., 4 ]

julia> arrows = Exponential( A, G )
<An object in FinQuivers>

julia> Display( arrows )
( [ 0,..., 8 ],
  [ 0 = [ 0, 3 ], 1 = [ 0, 4 ], 2 = [ 0, 5 ], 3 = [ 3, 3 ], 4 = [ 3, 4 ],
    5 = [ 3, 5 ], 6 = [ 6, 3 ], 7 = [ 6, 4 ], 8 = [ 6, 5 ], 9 = [ 0, 3 ],
    10 = [ 0, 4 ], 11 = [ 0, 5 ], 12 = [ 3, 3 ], 13 = [ 3, 4 ],
    14 = [ 3, 5 ], 15 = [ 6, 3 ], 16 = [ 6, 4 ], 17 = [ 6, 5 ],
    18 = [ 1, 6 ], 19 = [ 1, 7 ], 20 = [ 1, 8 ], 21 = [ 4, 6 ],
    22 = [ 4, 7 ], 23 = [ 4, 8 ], 24 = [ 7, 6 ], 25 = [ 7, 7 ],
    26 = [ 7, 8 ], 27 = [ 2, 3 ], 28 = [ 2, 4 ], 29 = [ 2, 5 ],
    30 = [ 5, 3 ], 31 = [ 5, 4 ], 32 = [ 5, 5 ], 33 = [ 8, 3 ],
    34 = [ 8, 4 ], 35 = [ 8, 5 ], 36 = [ 2, 6 ], 37 = [ 2, 7 ],
    38 = [ 2, 8 ], 39 = [ 5, 6 ], 40 = [ 5, 7 ], 41 = [ 5, 8 ],
    42 = [ 8, 6 ], 43 = [ 8, 7 ], 44 = [ 8, 8 ] ] )

julia> global_arrows = HomStructure( T, arrows )
|5|

julia> Display( global_arrows )
[ 0,..., 4 ]

julia> prjG = ProjectionInFactorOfDirectProduct( [ G, V ], 1 )
<A morphism in FinQuivers>

julia> Display( prjG )
Image of <(V)>:
[ 0, 1, 2 ] ⱶ[ 0, 1, 2 ]→ [ 0, 1, 2 ]

Image of <(A)>:
∅ ⱶ[  ]→ [ 0,..., 4 ]

A morphism in FinQuivers
given by the above data

julia> IsEpimorphism( prjG )
false

julia> prj_discrete = ProjectionInFactorOfDirectProduct( [ discrete, V ], 1 )
<A morphism in FinQuivers>

julia> Display( prj_discrete )
Image of <(V)>:
[ 0, 1, 2 ] ⱶ[ 0, 1, 2 ]→ [ 0, 1, 2 ]

Image of <(A)>:
∅ ⱶ[  ]→ ∅

A morphism in FinQuivers
given by the above data

julia> IsEpimorphism( prj_discrete )
true

julia> Display( Exponential( T, G ) )
( [ 0, 1, 2 ],
  [ 0 = [ 0, 1 ], 1 = [ 0, 1 ], 2 = [ 1, 2 ],
    3 = [ 2, 1 ], 4 = [ 2, 2 ] ] )

julia> t = UniversalMorphismIntoTerminalObject( V )
<A morphism in FinQuivers>

julia> Display( t )
Image of <(V)>:
[ 0 ] ⱶ[ 0 ]→ [ 0 ]

Image of <(A)>:
∅ ⱶ[  ]→ [ 0 ]

A morphism in FinQuivers
given by the above data

julia> embG = Exponential( t, G )
<A morphism in FinQuivers>

julia> Display( embG )
Image of <(V)>:
[ 0, 1, 2 ] ⱶ[ 0, 1, 2 ]→ [ 0, 1, 2 ]

Image of <(A)>:
[ 0,..., 4 ] ⱶ[ 3, 3, 7, 5, 8 ]→ [ 0,..., 8 ]

A morphism in FinQuivers
given by the above data

julia> IsEpimorphism( embG )
false

julia> emb_complete = Exponential( t, complete )
<A morphism in FinQuivers>

julia> Display( emb_complete )
Image of <(V)>:
[ 0, 1, 2 ] ⱶ[ 0, 1, 2 ]→ [ 0, 1, 2 ]

Image of <(A)>:
[ 0,..., 8 ] ⱶ[ 0, 1, 2, 3, 4, 5, 6, 7, 8 ]→ [ 0,..., 8 ]

A morphism in FinQuivers
given by the above data

julia> IsEpimorphism( emb_complete )
true

julia> s = FinQuivers.s
<A morphism in FinQuivers>

julia> Display( s )
Image of <(V)>:
[ 0 ] ⱶ[ 0 ]→ [ 0, 1 ]

Image of <(A)>:
∅ ⱶ[  ]→ [ 0 ]

A morphism in FinQuivers
given by the above data

julia> t = FinQuivers.t
<A morphism in FinQuivers>

julia> Display( t )
Image of <(V)>:
[ 0 ] ⱶ[ 1 ]→ [ 0, 1 ]

Image of <(A)>:
∅ ⱶ[  ]→ [ 0 ]

A morphism in FinQuivers
given by the above data

julia> omega = SubobjectClassifier( FinQuivers )
<An object in FinQuivers>

julia> Display( omega )
( [ 0, 1 ],
  [ 0 = [ 0, 0 ], 1 = [ 1, 0 ], 2 = [ 0, 1 ],
    3 = [ 1, 1 ], 4 = [ 1, 1 ] ] )

julia> HomStructure( A, omega )
|5|

julia> subsA = ListOfSubobjects( A );

julia> Length( subsA )
5

julia> Perform( subsA, Display )
Image of <(V)>:
∅ ⱶ[  ]→ [ 0, 1 ]

Image of <(A)>:
∅ ⱶ[  ]→ [ 0 ]

A morphism in FinQuivers
given by the above data
Image of <(V)>:
[ 0 ] ⱶ[ 0 ]→ [ 0, 1 ]

Image of <(A)>:
∅ ⱶ[  ]→ [ 0 ]

A morphism in FinQuivers
given by the above data
Image of <(V)>:
[ 0 ] ⱶ[ 1 ]→ [ 0, 1 ]

Image of <(A)>:
∅ ⱶ[  ]→ [ 0 ]

A morphism in FinQuivers
given by the above data
Image of <(V)>:
[ 0, 1 ] ⱶ[ 0, 1 ]→ [ 0, 1 ]

Image of <(A)>:
∅ ⱶ[  ]→ [ 0 ]

A morphism in FinQuivers
given by the above data
Image of <(V)>:
[ 0, 1 ] ⱶ[ 0, 1 ]→ [ 0, 1 ]

Image of <(A)>:
[ 0 ] ⱶ[ 0 ]→ [ 0 ]

A morphism in FinQuivers
given by the above data

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, CartesianCategories, QuotientCategories, LinearAlgebraForCAP, LinearClosuresForCAP, AdditiveClosuresForCAP, FreydCategoriesForCAP, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, FpCategories, FpLinearCategories, Locales, FiniteCocompletions, PresheafCategories, SubcategoriesForCAP, FunctorCategories

julia> L = CreateQuiver( 3, [ 1,0,  2,0,  2,2 ] )
<An object in FinQuivers>

julia> R = CreateQuiver( 4, [ 0,1,  2,0,  0,3 ] )
<An object in FinQuivers>

julia> l = Subobject( L, [ 0, 1 ], [ ] )
<A morphism in FinQuivers>

julia> r = Subobject( R, [ 0, 1 ], [ ] )
<A morphism in FinQuivers>

julia> G = CreateQuiver( 4, [ 1,0,  3,0,  3,3,  2,0,  2,1 ] )
<An object in FinQuivers>

julia> m = Subobject( G, [ 3, 1, 2 ] )
<A morphism in FinQuivers>

julia> Source( m ) == L
true

julia> p = DPO( m, l, r );

julia> p[2]
<A morphism in FinQuivers>

julia> Display( p[2] )
Image of <(V)>:
[ 0,..., 3 ] ⱶ[ 0, 2, 3, 4 ]→ [ 0,..., 4 ]

Image of <(A)>:
[ 0, 1, 2 ] ⱶ[ 2, 3, 4 ]→ [ 0,..., 4 ]

A morphism in FinQuivers
given by the above data

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, CartesianCategories, QuotientCategories, LinearAlgebraForCAP, LinearClosuresForCAP, AdditiveClosuresForCAP, FreydCategoriesForCAP, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, FpCategories, FpLinearCategories, Locales, FiniteCocompletions, PresheafCategories, SubcategoriesForCAP, FunctorCategories

julia> true
true

julia> FinReflexiveQuivers
FinReflexiveQuivers

julia> V = FinReflexiveQuivers.V
<An object in FinReflexiveQuivers>

julia> Display( V )
( [ 0 ], [ 0 = [ 0 ] ] )

julia> A = FinReflexiveQuivers.A
<An object in FinReflexiveQuivers>

julia> Display( A )
( [ 0, 1 ], [ 0 = [ 0, 1 ], 1 = [ 0 ], 2 = [ 1 ] ] )

julia> T = TerminalObject( FinReflexiveQuivers )
<An object in FinReflexiveQuivers>

julia> Display( T )
( [ 0 ], [ 0 = [ 0 ] ] )

julia> T == V
true

julia> G = CreateReflexiveQuiver( 2,
                     [ 1, 4 ],
                     [ 0,1, 0,0, 0,0, 1,0, 1,1 ] )
<An object in FinReflexiveQuivers>

julia> IsWellDefined( G )
true

julia> Display( G )
( [ 0, 1 ],
  [ 0 = [ 0, 1 ], 1 = [ 0 ], 2 = [ 0, 0 ], 3 = [ 1, 0 ], 4 = [ 1 ] ] )

julia> global_G = HomStructure( T, G )
|2|

julia> Display( global_G )
[ 0, 1 ]

julia> DirectProduct( G, V ) == G
true

julia> iso = CartesianLeftEvaluationMorphism( T, G )
<A morphism in FinReflexiveQuivers>

julia> IsIsomorphism( iso )
true

julia> Display( iso )
Image of <(C0)>:
[ 0, 1 ] ⱶ[ 0, 1 ]→ [ 0, 1 ]

Image of <(C1)>:
[ 0,..., 4 ] ⱶ[ 1, 2, 3, 0, 4 ]→ [ 0,..., 4 ]

A morphism in FinReflexiveQuivers
given by the above data

julia> s = FinReflexiveQuivers.s;

julia> IsSplitMonomorphism( s )
true

julia> Display( s )
Image of <(C0)>:
[ 0 ] ⱶ[ 0 ]→ [ 0, 1 ]

Image of <(C1)>:
[ 0 ] ⱶ[ 1 ]→ [ 0, 1, 2 ]

A morphism in FinReflexiveQuivers
given by the above data

julia> t = FinReflexiveQuivers.t;

julia> IsSplitMonomorphism( t )
true

julia> Display( t )
Image of <(C0)>:
[ 0 ] ⱶ[ 1 ]→ [ 0, 1 ]

Image of <(C1)>:
[ 0 ] ⱶ[ 2 ]→ [ 0, 1, 2 ]

A morphism in FinReflexiveQuivers
given by the above data

julia> l = FinReflexiveQuivers.l;

julia> IsSplitEpimorphism( l )
true

julia> Display( l )
Image of <(C0)>:
[ 0, 1 ] ⱶ[ 0, 0 ]→ [ 0 ]

Image of <(C1)>:
[ 0, 1, 2 ] ⱶ[ 0, 0, 0 ]→ [ 0 ]

A morphism in FinReflexiveQuivers
given by the above data

julia> omega = SubobjectClassifier( FinReflexiveQuivers )
<An object in FinReflexiveQuivers>

julia> Display( omega )
( [ 0, 1 ],
  [ 0 = [ 0 ], 1 = [ 1, 0 ], 2 = [ 0, 1 ],
    3 = [ 1, 1 ], 4 = [ 1 ] ] )

julia> HomStructure( A, omega )
|5|

julia> subsA = ListOfSubobjects( A );

julia> Length( subsA )
5

julia> Perform( subsA, Display )
Image of <(C0)>:
∅ ⱶ[  ]→ [ 0, 1 ]

Image of <(C1)>:
∅ ⱶ[  ]→ [ 0, 1, 2 ]

A morphism in FinReflexiveQuivers
given by the above data
Image of <(C0)>:
[ 0 ] ⱶ[ 0 ]→ [ 0, 1 ]

Image of <(C1)>:
[ 0 ] ⱶ[ 1 ]→ [ 0, 1, 2 ]

A morphism in FinReflexiveQuivers
given by the above data
Image of <(C0)>:
[ 0 ] ⱶ[ 1 ]→ [ 0, 1 ]

Image of <(C1)>:
[ 0 ] ⱶ[ 2 ]→ [ 0, 1, 2 ]

A morphism in FinReflexiveQuivers
given by the above data
Image of <(C0)>:
[ 0, 1 ] ⱶ[ 0, 1 ]→ [ 0, 1 ]

Image of <(C1)>:
[ 0, 1 ] ⱶ[ 1, 2 ]→ [ 0, 1, 2 ]

A morphism in FinReflexiveQuivers
given by the above data
Image of <(C0)>:
[ 0, 1 ] ⱶ[ 0, 1 ]→ [ 0, 1 ]

Image of <(C1)>:
[ 0, 1, 2 ] ⱶ[ 0, 1, 2 ]→ [ 0, 1, 2 ]

A morphism in FinReflexiveQuivers
given by the above data

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, CartesianCategories, QuotientCategories, LinearAlgebraForCAP, LinearClosuresForCAP, AdditiveClosuresForCAP, FreydCategoriesForCAP, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, FpCategories, FpLinearCategories, Locales, FiniteCocompletions, PresheafCategories, SubcategoriesForCAP, FunctorCategories

julia> true
true

julia> q = FinQuiver( "q(0,1,2,3)[a:0->1,b:1->3,c:0->2,d:2->3,e:3->3]" )
FinQuiver( "q(0,1,2,3)[a:0→1,b:1→3,c:0→2,d:2→3,e:3→3]" )

julia> k = HomalgFieldOfRationals();

julia> C = PathCategory( q )
PathCategory( FinQuiver( "q(0,1,2,3)[a:0→1,b:1→3,c:0→2,d:2→3,e:3→3]" ) )

julia> kC = k[C]
Q-LinearClosure( PathCategory( FinQuiver( "q(0,1,2,3)[a:0→1,b:1→3,c:0→2,
d:2→3,e:3→3]" ) ) )

julia> quo_kC = kC / [ kC.e^3 ]
Q-LinearClosure( PathCategory( FinQuiver( "q(0,1,2,3)[a:0→1,b:1→3,c:0→2,
d:2→3,e:3→3]" ) ) ) / [ 1*e^3 ]

julia> A = AlgebroidFromDataTables( quo_kC )
Q-algebroid( [0,1,2,3][a:0→1,b:1→3,c:0→2,d:2→3,e:3→3] ) defined by
4 objects and 5 generating morphisms

julia> e = AssociatedMorphismIntoAlgebroidAsObjectInPreSheavesCategory( A.e )
<(0⊗0)->0x1, (0⊗1)->0x0, (0⊗2)->0x0, (0⊗3)->0x0, (1⊗0)->0x1, (1⊗1)->0x1,
(1⊗2)->0x0, (1⊗3)->0x0, (2⊗0)->0x1, (2⊗1)->0x0, (2⊗2)->0x1, (2⊗3)->0x0,
(3⊗0)->18x6, (3⊗1)->9x3, (3⊗2)->9x3, (3⊗3)->9x3>

julia> IsWellDefined( e )
true

julia> qA = QuotientCategory( A, [ A.ab - A.cd, 2*A.be ] )
QuotientCategory( Q-algebroid( [0,1,2,3][a:0→1,b:1→3,c:0→2,d:2→3,e:3→3] )
defined by 4 objects and 5 generating morphisms, 2-sided ideal generated
by 2 morphisms )

julia> qA["0"]
<(0)>

julia> RangeCategoryOfHomomorphismStructure( qA )
Rows( Q )

julia> IsZeroForMorphisms( qA.cde )
true

julia> f = RandomMorphism( qA, 20 );

julia> 2 * HomStructure( Source( f ), Target( f ), 3 * HomStructure( f ) ) == 6 * f
true

julia> qA = QuotientCategory( A, [ A.id_0, A.id_1, A.id_2 ] )
QuotientCategory( Q-algebroid( [0,1,2,3][a:0→1,b:1→3,c:0→2,d:2→3,e:3→3] )
defined by 4 objects and 5 generating morphisms, 2-sided ideal generated
by 3 morphisms )

julia> ForAll( [ qA["0"], qA["1"], qA["2"] ], IsZeroForObjects )
true

julia> IsZeroForObjects( qA["3"] )
false

julia> D = AlgebroidFromDataTables( qA )
Q-algebroid( [3][e:3→3] ) defined by 1 object and 1 generating morphism

julia> Perform( BasisOfExternalHom( D["3"], D["3"] ), Display )
<1*id(3):(3) → (3)>
<1*e:(3) → (3)>
<1*e^2:(3) → (3)>

julia> data_tables = DataTablesOfLinearCategory( quo_kC );

julia> data_tables_Z = ShallowCopy( data_tables );

julia> data_tables_Z[1] = HomalgRingOfIntegers();

julia> B = AlgebroidFromDataTables( data_tables_Z )
Z-algebroid( [0,1,2,3][a:0→1,b:1→3,c:0→2,d:2→3,e:3→3] ) defined by
4 objects and 5 generating morphisms

julia> RangeCategoryOfHomomorphismStructure( B )
Rows( Z )

julia> qB = QuotientCategory( B, [ B.ab - B.cd, 2*B.be ] )
QuotientCategory( Z-algebroid( [0,1,2,3][a:0→1,b:1→3,c:0→2,d:2→3,e:3→3] )
defined by 4 objects and 5 generating morphisms, 2-sided ideal generated by
2 morphisms )

julia> RangeCategoryOfHomomorphismStructure( qB )
Freyd( Rows( Z ) )

julia> IsZeroForMorphisms( qB.cde )
false

julia> IsZeroForMorphisms( 2 * qB.cde )
true

julia> add_qB = AdditiveClosure( qB )
AdditiveClosure( QuotientCategory( Z-algebroid( [0,1,2,3][a:0→1,b:1→3,
c:0→2,d:2→3,e:3→3] ) defined by 4 objects and 5 generating morphisms,
2-sided ideal generated by 2 morphisms ) )

julia> T = RandomObject( add_qB, [[10],[1]] );

julia> u = RandomMorphism( T, T, 5 );

julia> v = RandomMorphism( T, T, 5 );

julia> w = RandomMorphism( T, T, 5 );

julia> HomStructure( PreCompose( [ u, v, w ] ) ) == PreCompose( HomStructure( v ), HomStructure( u, w ) )
true

julia> HomStructure( T, T, 2 * HomStructure( 3 * u ) ) == 6 * u
true

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, CartesianCategories, QuotientCategories, LinearAlgebraForCAP, LinearClosuresForCAP, AdditiveClosuresForCAP, FreydCategoriesForCAP, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, FpCategories, FpLinearCategories, Locales, FiniteCocompletions, PresheafCategories, SubcategoriesForCAP, FunctorCategories

julia> true
true

julia> q = FinQuiver( "q(0,1,2)[x:0->1,y:1->2,z:0->2]" )
FinQuiver( "q(0,1,2)[x:0→1,y:1→2,z:0→2]" )

julia> C = PathCategory( q )
PathCategory( FinQuiver( "q(0,1,2)[x:0→1,y:1→2,z:0→2]" ) )

julia> k = HomalgFieldOfRationals( );

julia> kC = k[C]
Q-LinearClosure( PathCategory( FinQuiver( "q(0,1,2)[x:0→1,
y:1→2,z:0→2]" ) ) )

julia> A = kC / [ kC.xy - kC.z ]
Q-LinearClosure( PathCategory( FinQuiver( "q(0,1,2)[x:0→1,
y:1→2,z:0→2]" ) ) ) / [ 1*x⋅y + (-1)*z ]

julia> B = AlgebroidFromDataTables( A )
Q-algebroid( [0,1,2][x:0→1,y:1→2,z:0→2] ) defined by 3 objects
and 3 generating morphisms

julia> IsAdmissibleAlgebroid( B )
false

julia> q = FinQuiver( "q(o)[x:o->o,y:o->o]" )
FinQuiver( "q(o)[x:o→o,y:o→o]" )

julia> C = PathCategory( q )
PathCategory( FinQuiver( "q(o)[x:o→o,y:o→o]" ) )

julia> kC = k[C]
Q-LinearClosure( PathCategory( FinQuiver( "q(o)[x:o→o,y:o→o]" ) ) )

julia> A = kC / [ kC.xy - kC.yx, kC.x^3, kC.y^3 ]
Q-LinearClosure( PathCategory( FinQuiver( "q(o)[x:o→o,y:o→o]" ) ) )
/ [ (-1)*y⋅x + 1*x⋅y, 1*x^3, 1*y^3 ]

julia> B = AlgebroidFromDataTables( A )
Q-algebroid( [o][x:o→o,y:o→o] ) defined by 1 object and 2 generating morphisms

julia> IsAdmissibleAlgebroid( B )
true

julia> A = kC / [ kC.xy - kC.yx, kC.x^3 - kC.x, kC.y^3 ]
Q-LinearClosure( PathCategory( FinQuiver( "q(o)[x:o→o,y:o→o]" ) ) )
/ [ (-1)*y⋅x + 1*x⋅y, 1*x^3 + (-1)*x, 1*y^3 ]

julia> B = AlgebroidFromDataTables( A )
Q-algebroid( [o][x:o→o,y:o→o] ) defined by 1 object and 2 generating morphisms

julia> IsAdmissibleAlgebroid( B )
false

```
