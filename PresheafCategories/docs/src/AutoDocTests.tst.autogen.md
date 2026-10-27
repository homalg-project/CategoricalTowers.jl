
```jldoctest AutoDocTests
julia> using CAP, MatricesForHomalg, LinearAlgebraForCAP, MonoidalCategories, CartesianCategories, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, PresheafCategories

julia> # extracted from examples/TerminalCategory.g

julia> true
true

julia> true
true

julia> T = PreSheaves( InitialCategory( ) )
PreSheaves( InitialCategory( ), InitialCategory( ) )

julia> IsIdenticalObj( T, RangeCategoryOfHomomorphismStructure( T ) )
true

julia> IsTerminalCategory( T )
true

julia> Display( T )
A CAP category with name PreSheaves( InitialCategory( ), InitialCategory( ) ):

127 primitive operations were used to derive 662 operations for this category which algorithmically
* IsCategoryWithDecidableColifts
* IsCategoryWithDecidableLifts
* IsFiniteCategory
* IsEquippedWithHomomorphismStructure
* IsLinearCategoryOverCommutativeRing
* IsLeftClosedMonoidalCategory
* IsLeftCoclosedMonoidalCategory
* IsBicartesianCoclosedCategory
* IsRigidSymmetricClosedMonoidalCategory
* IsRigidSymmetricCoclosedMonoidalCategory
* IsAbelianCategoryWithEnoughInjectives
* IsAbelianCategoryWithEnoughProjectives
* IsAdditiveMonoidalCategory
* IsElementaryTopos
and not yet algorithmically
* IsFinitelyPresentedCategory
* IsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms
and furthermore mathematically
* IsLocallyOfFiniteInjectiveDimension
* IsLocallyOfFiniteProjectiveDimension
* IsSkeletalCategory
* IsStrictCartesianCategory
* IsStrictCocartesianCategory
* IsStrictMonoidalCategory
* IsSymmetricMonoidalCategoryStructureGivenByCoproduct
* IsSymmetricMonoidalCategoryStructureGivenByDirectProduct
* IsTerminalCategory

julia> i = InitialObject( T )
<An object in PreSheaves( InitialCategory( ), InitialCategory( ) )>

julia> t = TerminalObject( T )
<An object in PreSheaves( InitialCategory( ), InitialCategory( ) )>

julia> z = ZeroObject( T )
<An object in PreSheaves( InitialCategory( ), InitialCategory( ) )>

julia> Display( i )
An object in PreSheaves( InitialCategory( ), InitialCategory( ) ).

julia> Display( t )
An object in PreSheaves( InitialCategory( ), InitialCategory( ) ).

julia> Display( z )
An object in PreSheaves( InitialCategory( ), InitialCategory( ) ).

julia> IsIdenticalObj( i, z )
false

julia> IsIdenticalObj( t, z )
false

julia> IsEqualForObjects( i, z )
true

julia> IsEqualForObjects( t, z )
true

julia> IsWellDefined( z )
true

julia> id_z = IdentityMorphism( z );

julia> fn_z = ZeroObjectFunctorial( T );

julia> IsWellDefined( id_z )
true

julia> IsWellDefined( fn_z )
true

julia> IsEqualForMorphisms( id_z, fn_z )
true

julia> IsCongruentForMorphisms( id_z, fn_z )
true

```

```jldoctest AutoDocTests
julia> using CAP, MatricesForHomalg, LinearAlgebraForCAP, MonoidalCategories, CartesianCategories, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, PresheafCategories

julia> # extracted from examples/PreSheavesOfSkeletalFinSets.g

julia> true
true

julia> true
true

julia> true
true

julia> PSh = PreSheaves( SkeletalFinSets, SkeletalFinSets )
PreSheaves( SkeletalFinSets, SkeletalFinSets )

julia> Display( PSh )
A CAP category with name PreSheaves( SkeletalFinSets, SkeletalFinSets ):

28 primitive operations were used to derive 213 operations for this category
which not yet algorithmically
* IsSymmetricMonoidalCategory
* IsElementaryTopos
and furthermore mathematically
* IsSymmetricMonoidalCategoryStructureGivenByDirectProduct

julia> View( MissingOperationsForConstructivenessOfCategory( PSh, "IsElementaryTopos" ) )
[ "IsEqualForObjects", "IsEqualForMorphisms", "IsCongruentForMorphisms",
  "ExponentialOnObjects", "ExponentialOnMorphisms",
  "CartesianRightEvaluationMorphism", "CartesianRightCoevaluationMorphism",
  "CartesianLeftEvaluationMorphism", "CartesianLeftCoevaluationMorphism",
  "SubobjectClassifier", "ClassifyingMorphismOfSubobject",
  "SubobjectOfClassifyingMorphism" ]

julia> Y = YonedaEmbeddingOfSourceCategory( PSh )
Yoneda embedding functor

julia> omega = SubobjectClassifier( SourceOfFunctor( Y ) )
|2|

julia> M = FinSet( 3 )
|3|

julia> Y( omega )( M )
|8|

julia> phi = MapOfFinSets( omega, [ 2, 0 ], M )
|2| → |3|

julia> omega_phi = Y( omega )( phi )
|8| → |4|

julia> Display( omega_phi )
[ 0,..., 7 ] ⱶ[ 0, 2, 0, 2, 1, 3, 1, 3 ]→ [ 0,..., 3 ]

julia> phi_omega = Y( phi )( omega )
|4| → |9|

julia> Display( phi_omega )
[ 0,..., 3 ] ⱶ[ 8, 6, 2, 0 ]→ [ 0,..., 8 ]

julia> six1 = Y( FinSet( 6 ) )
<An object in PreSheaves( SkeletalFinSets, SkeletalFinSets )>

julia> six2 = DirectProduct( Y( FinSet( 2 ) ), Y( FinSet( 3 ) ) )
<An object in PreSheaves( SkeletalFinSets, SkeletalFinSets )>

julia> View( List( (0):(7), i -> six1( FinSet( i ) ) ) )
[ |1|, |6|, |36|, |216|, |1296|, |7776|, |46656|, |279936| ]

julia> View( List( (0):(7), i -> six2( FinSet( i ) ) ) )
[ |1|, |6|, |36|, |216|, |1296|, |7776|, |46656|, |279936| ]

julia> six1_on_mor = six1( UniversalMorphismIntoTerminalObject( FinSet( 3 ) ) )
|6| → |216|

julia> Display( six1_on_mor )
[ 0,..., 5 ] ⱶ[ 0, 43, 86, 129, 172, 215 ]→ [ 0,..., 215 ]

julia> six2_on_mor = six2( UniversalMorphismIntoTerminalObject( FinSet( 3 ) ) )
|6| → |216|

julia> Display( six2_on_mor )
[ 0,..., 5 ] ⱶ[ 0, 7, 104, 111, 208, 215 ]→ [ 0,..., 215 ]

```
