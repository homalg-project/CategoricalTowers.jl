```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, CartesianCategories, QuotientCategories, LinearAlgebraForCAP, LinearClosuresForCAP, AdditiveClosuresForCAP, FreydCategoriesForCAP, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, FpCategories, FpLinearCategories, Locales, FiniteCocompletions, PresheafCategories, SubcategoriesForCAP, FunctorCategories

julia> true
true

julia> I = InitialCategory( )
InitialCategory( )

julia> T = FiniteCompletion( I )
FiniteCompletion( InitialCategory( ) )

julia> H = RangeCategoryOfHomomorphismStructure( T )
PreSheaves( InitialCategory( ), InitialCategory( ) )

julia> IsTerminalCategory( T )
true

julia> IsTerminalCategory( H )
true

julia> Display( T )
A CAP category with name FiniteCompletion( InitialCategory( ) ):

133 primitive operations were used to derive 671 operations for this category which algorithmically
* IsCategoryWithDecidableColifts
* IsCategoryWithDecidableLifts
* IsFiniteCategory
* IsEquippedWithHomomorphismStructure
* IsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms
* IsLeftClosedMonoidalCategory
* IsLeftCoclosedMonoidalCategory
* IsBicartesianClosedCategory
* IsBicartesianCoclosedCategory
* IsClosedMonoidalProset
* IsCoclosedMonoidalProset
* IsDistributiveLattice
* IsClosedMonoidalPoset
* IsCoclosedMonoidalPoset
* IsSymmetricClosedMonoidalProset
* IsSymmetricCoclosedMonoidalProset
* IsSymmetricClosedMonoidalPoset
* IsSymmetricCoclosedMonoidalPoset
* IsCoHeytingAlgebra
* IsHeytingAlgebra
* IsRigidSymmetricClosedMonoidalCategory
* IsRigidSymmetricCoclosedMonoidalCategory
* IsAbelianCategoryWithEnoughInjectives
* IsAbelianCategoryWithEnoughProjectives
* IsAdditiveMonoidalCategory
* IsClosedMonoidalLattice
* IsCoclosedMonoidalLattice
* IsBiHeytingAlgebra
* IsSymmetricClosedMonoidalLattice
* IsSymmetricCoclosedMonoidalLattice
* IsBooleanAlgebra
and furthermore mathematically
* IsFinitelyPresentedLinearCategory
* IsLinearClosureOfACategory
* IsLocallyOfFiniteInjectiveDimension
* IsLocallyOfFiniteProjectiveDimension
* IsStrictCartesianCategory
* IsStrictCocartesianCategory
* IsSymmetricMonoidalCategoryStructureGivenByCoproduct
* IsSymmetricMonoidalCategoryStructureGivenByDirectProduct
* IsTerminalCategory
* IsTotalOrderCategory

julia> i = InitialObject( T )
<An object in FiniteCompletion( InitialCategory( ) )>

julia> t = TerminalObject( T )
<An object in FiniteCompletion( InitialCategory( ) )>

julia> z = ZeroObject( T )
<An object in FiniteCompletion( InitialCategory( ) )>

julia> Display( i )
An object in CoPreSheaves( InitialCategory( ), InitialCategory( ) ) given by the above data

An object in FiniteCompletion( InitialCategory( ) ) given by the above data

julia> Display( t )
An object in CoPreSheaves( InitialCategory( ), InitialCategory( ) ) given by the above data

An object in FiniteCompletion( InitialCategory( ) ) given by the above data

julia> Display( z )
An object in CoPreSheaves( InitialCategory( ), InitialCategory( ) ) given by the above data

An object in FiniteCompletion( InitialCategory( ) ) given by the above data

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

julia> id_z = IdentityMorphism( z )
<A morphism in FiniteCompletion( InitialCategory( ) )>

julia> fn_z = ZeroObjectFunctorial( T )
<A morphism in FiniteCompletion( InitialCategory( ) )>

julia> IsWellDefined( fn_z )
true

julia> IsEqualForMorphisms( id_z, fn_z )
true

julia> IsCongruentForMorphisms( id_z, fn_z )
true

```
