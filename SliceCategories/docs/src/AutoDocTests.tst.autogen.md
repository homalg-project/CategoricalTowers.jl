
```jldoctest AutoDocTests
julia> using CAP, MonoidalCategories, CartesianCategories, ToolsForCategoricalTowers, Toposes, Locales, FpCategories, FreydCategoriesForCAP, FinSetsForCAP, Singular, MatricesForHomalg, AdditiveClosuresForCAP, SliceCategories

julia> # extracted from examples/SliceCategory.g

julia> true
true

julia> true
true

julia> true
true

julia> B = SubobjectClassifier( SkeletalFinSets )
|2|

julia> S = SliceCategory( B )
A slice category of SkeletalFinSets

julia> Display( S )
A CAP category with name A slice category of SkeletalFinSets:

50 primitive operations were used to derive 355 operations for this category which algorithmically
* IsCategoryWithDecidableColifts
* IsCategoryWithDecidableLifts
* IsEquippedWithHomomorphismStructure
* IsSymmetricMonoidalCategory
* IsDistributiveCategory
* IsFiniteBicompleteCategory
and not yet algorithmically
* IsElementaryTopos
and furthermore mathematically
* IsSymmetricMonoidalCategoryStructureGivenByDirectProduct

julia> o0 = MapOfFinSets( B, [ 1, 1 ], B ) / S
An object in the slice category given by: |2| → |2|

julia> o1 = MapOfFinSets( FinSet( 3 ), [ 0, 1, 0 ], B ) / S
An object in the slice category given by: |3| → |2|

julia> o2 = MapOfFinSets( FinSet( 4 ), [ 1, 0, 1, 0 ], B ) / S
An object in the slice category given by: |4| → |2|

julia> IsWellDefined( o0 )
true

julia> IsWellDefined( o1 )
true

julia> IsWellDefined( o2 )
true

julia> IsHomSetInhabited( o1, o0 )
false

julia> IsHomSetInhabited( o0, o1 )
true

julia> IsHomSetInhabited( o1, o2 )
true

julia> IsHomSetInhabited( o2, o1 )
true

julia> iota = UniversalMorphismFromInitialObject( o1 )
A morphism in the slice category given by: |0| → |3|

julia> Display( iota )
∅ ⱶ[  ]→ [ 0, 1, 2 ]

A morphism in the slice category given by the above data

julia> IsInitial( Source( iota ) )
true

julia> tau = UniversalMorphismIntoTerminalObject( o2 )
A morphism in the slice category given by: |4| → |2|

julia> Display( tau )
[ 0,..., 3 ] ⱶ[ 1, 0, 1, 0 ]→ [ 0, 1 ]

A morphism in the slice category given by the above data

julia> IsTerminal( Target( tau ) )
true

julia> n = MapOfFinSets( FinSet( 3 ), [ 2, 0, 3 ], FinSet( 4 ) )
|3| → |4|

julia> IsWellDefined( n )
true

julia> n = AsSliceCategoryCell( o1, n, o2 )
A morphism in the slice category given by: |3| → |4|

julia> IsWellDefined( n )
false

julia> m1 = MapOfFinSets( FinSet( 3 ), [ 1, 0, 3 ], FinSet( 4 ) )
|3| → |4|

julia> m1 = AsSliceCategoryCell( o1, m1, o2 )
A morphism in the slice category given by: |3| → |4|

julia> IsWellDefined( m1 )
true

julia> IsSplitEpimorphism( m1 )
false

julia> m2 = MapOfFinSets( FinSet( 4 ), [ 1, 2, 1, 0 ], FinSet( 3 ) )
|4| → |3|

julia> m2 = AsSliceCategoryCell( o2, m2, o1 )
A morphism in the slice category given by: |4| → |3|

julia> IsWellDefined( m2 )
true

julia> IsSplitEpimorphism( m2 )
true

julia> m3 = PreCompose( m1, m2 )
A morphism in the slice category given by: |3| → |3|

julia> IsWellDefined( m3 )
true

julia> IsEqualToIdentityMorphism( m3 )
false

julia> m4 = Inverse( m3 )
A morphism in the slice category given by: |3| → |3|

julia> IsWellDefined( m4 )
true

julia> m5 = PreCompose( m2, m1 )
A morphism in the slice category given by: |4| → |4|

julia> IsWellDefined( m5 )
true

julia> IsEqualToIdentityMorphism( m5 )
false

julia> t = DistinguishedObjectOfHomomorphismStructure( S )
|1|

julia> H = MorphismsOfExternalHom( o1, o2 );

julia> Length( H )
8

julia> h = HomStructure( o1, o2 )
|8|

julia> HomStructure( m1, m2 )
|16| → |4|

julia> th = MorphismsOfExternalHom( t, h );

julia> th == List( H, InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure )
true

julia> H == List( th, m ->
                InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( o1, o2, m ) )
true

julia> Display( o1 )
[ 0, 1, 2 ] ⱶ[ 0, 1, 0 ]→ [ 0, 1 ]

An object in the slice category given by the above data

julia> Po1 = PowerObject( o1 )
An object in the slice category given by: |6| → |2|

julia> Display( Po1 )
[ 0,..., 5 ] ⱶ[ 0, 0, 0, 0, 1, 1 ]→ [ 0, 1 ]

An object in the slice category given by the above data

julia> e_o1 = PowerObjectLeftEvaluationMorphism( o1 )
A morphism in the slice category given by: |10| → |4|

julia> IsWellDefined( e_o1 )
true

julia> Display( e_o1 )
[ 0,..., 9 ] ⱶ[ 0, 1, 0, 1, 2, 3, 0, 0, 1, 1 ]→ [ 0,..., 3 ]

A morphism in the slice category given by the above data

julia> sing_o1 =  SingletonMorphism( o1 )
A morphism in the slice category given by: |3| → |6|

julia> Display( sing_o1 )
[ 0, 1, 2 ] ⱶ[ 1, 5, 2 ]→ [ 0,..., 5 ]

A morphism in the slice category given by the above data

julia> IsWellDefined( sing_o1 )
true

julia> Display( o2 )
[ 0,..., 3 ] ⱶ[ 1, 0, 1, 0 ]→ [ 0, 1 ]

An object in the slice category given by the above data

julia> Po2 = PowerObject( o2 )
An object in the slice category given by: |8| → |2|

julia> Display( Po2 )
[ 0,..., 7 ] ⱶ[ 0, 0, 0, 0, 1, 1, 1, 1 ]→ [ 0, 1 ]

An object in the slice category given by the above data

julia> e_o2 = PowerObjectLeftEvaluationMorphism( o2 )
A morphism in the slice category given by: |16| → |4|

julia> IsWellDefined( e_o2 )
true

julia> Display( e_o2 )
[ 0,..., 15 ] ⱶ[ 2, 3, 2, 3, 0, 1, 0, 1, 2, 2, 3, 3, 0, 0, 1, 1 ]→ [ 0,..., 3 ]

A morphism in the slice category given by the above data

julia> sing_o2 =  SingletonMorphism( o2 )
A morphism in the slice category given by: |4| → |8|

julia> Display( sing_o2 )
[ 0,..., 3 ] ⱶ[ 5, 1, 6, 2 ]→ [ 0,..., 7 ]

A morphism in the slice category given by the above data

julia> IsWellDefined( sing_o2 )
true

julia> Display( m1 )
[ 0, 1, 2 ] ⱶ[ 1, 0, 3 ]→ [ 0,..., 3 ]

A morphism in the slice category given by the above data

julia> Pm1 = PowerObjectFunctorial( m1 )
A morphism in the slice category given by: |8| → |6|

julia> Display( Pm1 )
[ 0,..., 7 ] ⱶ[ 0, 1, 2, 3, 4, 5, 4, 5 ]→ [ 0,..., 5 ]

A morphism in the slice category given by the above data

julia> IsWellDefined( Pm1 )
true

julia> Display( m2 )
[ 0,..., 3 ] ⱶ[ 1, 2, 1, 0 ]→ [ 0, 1, 2 ]

A morphism in the slice category given by the above data

julia> Pm2 = PowerObjectFunctorial( m2 )
A morphism in the slice category given by: |6| → |8|

julia> Display( Pm2 )
[ 0,..., 5 ] ⱶ[ 0, 2, 1, 3, 4, 7 ]→ [ 0,..., 7 ]

A morphism in the slice category given by the above data

julia> IsWellDefined( Pm2 )
true

julia> omega = SubobjectClassifier( S )
An object in the slice category given by: |4| → |2|

julia> Display( omega )
[ 0,..., 3 ] ⱶ[ 0, 0, 1, 1 ]→ [ 0, 1 ]

An object in the slice category given by the above data

julia> o12 = DirectProduct( o1, o2 )
An object in the slice category given by: |6| → |2|

julia> Display( o12 )
[ 0,..., 5 ] ⱶ[ 1, 0, 0, 1, 0, 0 ]→ [ 0, 1 ]

An object in the slice category given by the above data

julia> ff = MapOfFinSets( SourceOfUnderlyingMorphism( o12 ),
                     [ 3, 1, 1, 2, 1, 0 ],
                     SourceOfUnderlyingMorphism( omega ) );

julia> f = MorphismConstructor( o12, ff, omega )
A morphism in the slice category given by: |6| → |4|

julia> IsWellDefined( f )
true

julia> g = PLeftTransposeMorphism( o1, o2, f )
A morphism in the slice category given by: |3| → |8|

julia> expo1o1 = Exponential( o1, o1 )
An object in the slice category given by: |5| → |2|

julia> Display( expo1o1 )
[ 0,..., 4 ] ⱶ[ 0, 0, 0, 0, 1 ]→ [ 0, 1 ]

An object in the slice category given by the above data

julia> evo1o1 = CartesianLeftEvaluationMorphism( o1, o1 )
A morphism in the slice category given by: |9| → |3|

julia> Display( evo1o1 )
[ 0,..., 8 ] ⱶ[ 0, 2, 0, 2, 1, 0, 0, 2, 2 ]→ [ 0, 1, 2 ]

A morphism in the slice category given by the above data

```

```jldoctest AutoDocTests
julia> using CAP, MonoidalCategories, CartesianCategories, ToolsForCategoricalTowers, Toposes, Locales, FpCategories, FreydCategoriesForCAP, FinSetsForCAP, Singular, MatricesForHomalg, AdditiveClosuresForCAP, SliceCategories

julia> # extracted from examples/SliceCategoryOverTensorUnit.g

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
An object in the slice category given by:
<A morphism in Rows( Q[x,y] )>

julia> J = HomalgMatrix( [ [ x ] ], 1, 1, R ) / P / S
An object in the slice category given by:
<A morphism in Rows( Q[x,y] )>

julia> phi = HomalgMatrix( [ [ x ], [ y ] ], 2, 1, R ) / P
<A morphism in Rows( Q[x,y] )>

julia> phi = MorphismConstructor( S, I, phi, J )
A morphism in the slice category given by:
<A morphism in Rows( Q[x,y] )>

julia> IsWellDefined( phi )
true

julia> Ip = HomalgMatrix( [ [ x*y ], [ x*y^2 ] ], 2, 1, R ) / P / S
An object in the slice category given by:
<A morphism in Rows( Q[x,y] )>

julia> Jp = HomalgMatrix( [ [ x ] ], 1, 1, R ) / P / S
An object in the slice category given by:
<A morphism in Rows( Q[x,y] )>

julia> psi = HomalgMatrix( [ [ y ], [ y^2 ] ], 2, 1, R ) / P
<A morphism in Rows( Q[x,y] )>

julia> psi = MorphismConstructor( S, Ip, psi, Jp )
A morphism in the slice category given by:
<A morphism in Rows( Q[x,y] )>

julia> IsWellDefined( psi )
true

julia> TensorProductOnObjects( I, J )
An object in the slice category given by:
<A morphism in Rows( Q[x,y] )>

julia> TensorProductOnMorphisms( phi, psi )
A morphism in the slice category given by:
<A morphism in Rows( Q[x,y] )>

julia> LeftUnitor( I )
A morphism in the slice category given by:
<A morphism in Rows( Q[x,y] )>

julia> RightUnitor( I )
A morphism in the slice category given by:
<A morphism in Rows( Q[x,y] )>

julia> AssociatorLeftToRight( I, J, Ip )
A morphism in the slice category given by:
<A morphism in Rows( Q[x,y] )>

julia> AssociatorRightToLeft( I, J, Ip )
A morphism in the slice category given by:
<A morphism in Rows( Q[x,y] )>

julia> Braiding( I, J )
A morphism in the slice category given by:
<A morphism in Rows( Q[x,y] )>

```

```jldoctest AutoDocTests
julia> using CAP, MonoidalCategories, CartesianCategories, ToolsForCategoricalTowers, Toposes, Locales, FpCategories, FreydCategoriesForCAP, FinSetsForCAP, Singular, MatricesForHomalg, AdditiveClosuresForCAP, SliceCategories

julia> # extracted from examples/DPO.g

julia> true
true

julia> omega = SubobjectClassifier( SkeletalFinSets )
|2|

julia> S = SliceCategory( omega )
A slice category of SkeletalFinSets

julia> k = omega
|2|

julia> K = MapOfFinSets( k, [ 1, 0 ], omega ) / S
An object in the slice category given by: |2| → |2|

julia> l = FinSet( 6 )
|6|

julia> L = MapOfFinSets( l, [ 1, 0, 1, 0, 0, 1 ], omega ) / S
An object in the slice category given by: |6| → |2|

julia> r = FinSet( 7 )
|7|

julia> R = MapOfFinSets( r, [ 1, 0, 0, 1, 1, 0, 0 ], omega ) / S
An object in the slice category given by: |7| → |2|

julia> lambda = AsSliceCategoryCell( K, MapOfFinSets( k, [ 0, 1 ], l ), L )
A morphism in the slice category given by: |2| → |6|

julia> rho = AsSliceCategoryCell( K, MapOfFinSets( k, [ 0, 1 ], r ), R )
A morphism in the slice category given by: |2| → |7|

julia> g = FinSet( 8 )
|8|

julia> G = MapOfFinSets( g, [ 1, 0, 1, 0, 0, 1, 1, 1 ], omega ) / S
An object in the slice category given by: |8| → |2|

julia> mu = AsSliceCategoryCell( L, MapOfFinSets( l, [ 0, 1, 2, 3, 4, 5 ], g ), G )
A morphism in the slice category given by: |6| → |8|

julia> poc = PushoutComplement( lambda, mu )
A morphism in the slice category given by: |4| → |8|

julia> Display( poc )
[ 0,..., 3 ] ⱶ[ 0, 1, 6, 7 ]→ [ 0,..., 7 ]

A morphism in the slice category given by the above data

julia> Display( Source( poc ) )
[ 0,..., 3 ] ⱶ[ 1, 0, 1, 1 ]→ [ 0, 1 ]

An object in the slice category given by the above data

julia> dpo = DPO( mu, lambda, rho );

julia> Display( dpo[1] )
[ 0,..., 3 ] ⱶ[ 0, 1, 2, 3 ]→ [ 0,..., 8 ]

A morphism in the slice category given by the above data

julia> Display( dpo[2] )
[ 0,..., 6 ] ⱶ[ 0, 1, 4, 5, 6, 7, 8 ]→ [ 0,..., 8 ]

A morphism in the slice category given by the above data

julia> Display( Target( dpo[1] ) )
[ 0,..., 8 ] ⱶ[ 1, 0, 1, 1, 0, 1, 1, 0, 0 ]→ [ 0, 1 ]

An object in the slice category given by the above data

julia> Display( dpo[3] )
[ 0,..., 3 ] ⱶ[ 0, 1, 6, 7 ]→ [ 0,..., 7 ]

A morphism in the slice category given by the above data

julia> Display( dpo[4] )
[ 0, 1 ] ⱶ[ 0, 1 ]→ [ 0,..., 3 ]

A morphism in the slice category given by the above data

```

```jldoctest AutoDocTests
julia> using CAP, MonoidalCategories, CartesianCategories, ToolsForCategoricalTowers, Toposes, Locales, FpCategories, FreydCategoriesForCAP, FinSetsForCAP, Singular, MatricesForHomalg, AdditiveClosuresForCAP, SliceCategories

julia> # extracted from examples/LazySliceCategory.g

julia> true
true

julia> true
true

julia> B = FinSet( 2 )
|2|

julia> o0 = AsSliceCategoryCell( [ MapOfFinSets( B, [ 1, 1 ], B  ) ] )
An object in the lazy slice category given by: |2| → |2|

julia> o1 = AsSliceCategoryCell( [ MapOfFinSets( FinSet( 3 ), [ 0, 1, 0 ], B ) ] )
An object in the lazy slice category given by: |3| → |2|

julia> o2 = AsSliceCategoryCell( [ MapOfFinSets( FinSet( 4 ), [ 1, 0, 1, 0 ], B ) ] )
An object in the lazy slice category given by: |4| → |2|

julia> IsWellDefined( o0 )
true

julia> IsWellDefined( o1 )
true

julia> IsWellDefined( o2 )
true

julia> IsHomSetInhabited( o1, o0 )
false

julia> IsHomSetInhabited( o0, o1 )
true

julia> IsHomSetInhabited( o1, o2 )
true

julia> IsHomSetInhabited( o2, o1 )
true

julia> iota = UniversalMorphismFromInitialObject( o1 )
A morphism in the lazy slice category given by: |0| → |3|

julia> Display( iota )
∅ ⱶ[  ]→ [ 0, 1, 2 ]

A morphism in the lazy slice category given by the above data

julia> IsInitial( Source( iota ) )
true

julia> tau = UniversalMorphismIntoTerminalObject( o2 )
A morphism in the lazy slice category given by: |4| → |2|

julia> Display( tau )
[ 0,..., 3 ] ⱶ[ 1, 0, 1, 0 ]→ [ 0, 1 ]

A morphism in the lazy slice category given by the above data

julia> IsTerminal( Target( tau ) )
true

julia> n = MapOfFinSets( FinSet( 3 ), [ 2, 0, 3 ], FinSet( 4 ) )
|3| → |4|

julia> IsWellDefined( n )
true

julia> n = AsSliceCategoryCell( o1, n, o2 )
A morphism in the lazy slice category given by: |3| → |4|

julia> IsWellDefined( n )
false

julia> m1 = MapOfFinSets( FinSet( 3 ), [ 1, 0, 3 ], FinSet( 4 ) )
|3| → |4|

julia> m1 = AsSliceCategoryCell( o1, m1, o2 )
A morphism in the lazy slice category given by: |3| → |4|

julia> IsWellDefined( m1 )
true

julia> IsSplitEpimorphism( m1 )
false

julia> m2 = MapOfFinSets( FinSet( 4 ), [ 1, 2, 1, 0 ], FinSet( 3 ) )
|4| → |3|

julia> m2 = AsSliceCategoryCell( o2, m2, o1 )
A morphism in the lazy slice category given by: |4| → |3|

julia> IsWellDefined( m2 )
true

julia> IsSplitEpimorphism( m2 )
true

julia> m3 = PreCompose( m1, m2 )
A morphism in the lazy slice category given by: |3| → |3|

julia> IsWellDefined( m3 )
true

julia> IsEqualToIdentityMorphism( m3 )
false

julia> m4 = Inverse( m3 )
A morphism in the lazy slice category given by: |3| → |3|

julia> IsWellDefined( m4 )
true

julia> m5 = PreCompose( m2, m1 )
A morphism in the lazy slice category given by: |4| → |4|

julia> IsWellDefined( m5 )
true

julia> IsEqualToIdentityMorphism( m5 )
false

```
