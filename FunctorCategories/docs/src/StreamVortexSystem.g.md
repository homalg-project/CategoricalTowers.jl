```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, CartesianCategories, QuotientCategories, LinearAlgebraForCAP, LinearClosuresForCAP, AdditiveClosuresForCAP, FreydCategoriesForCAP, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, FpCategories, FpLinearCategories, Locales, FiniteCocompletions, PresheafCategories, SubcategoriesForCAP, FunctorCategories

julia> true
true

julia> q = FinQuiver( "q(o)[x:o->o]" )
FinQuiver( "q(o)[x:o→o]" )

julia> F = PathCategory( q )
PathCategory( FinQuiver( "q(o)[x:o→o]" ) )

julia> C = F / [ [ F.x^(3+4), F.x^3 ] ]
PathCategory( FinQuiver( "q(o)[x:o→o]" ) ) / [ x^7 == x^3 ]

julia> C = CategoryFromDataTables( C )
PathCategory( FinQuiver( "q(o)[x:o→o]" ) ) / [ x^7 == x^3 ]

julia> x = C.x
(o)-[(x)]->(o)

julia> IsMonomorphism( x )
false

julia> IsEpimorphism( x )
false

julia> PSh = PreSheaves( C )
PreSheaves( PathCategory( FinQuiver( "q(o)[x:o→o]" ) ) / [ x^7 == x^3 ], SkeletalFinSets )

julia> Go = FinSet( 8 )
|8|

julia> Display( Go )
[ 0,..., 7 ]

julia> Gx = [ 5, 0, 3, 1, 1, 4, 3, 2 ];

julia> Gx = MapOfFinSets( Go, Gx, Go )
|8| → |8|

julia> G =  CreatePreSheafByValues( PSh, PairGAP( [ Go ], [ Gx ] ) )
<An object in PreSheaves( PathCategory( FinQuiver( "q(o)[x:o→o]" ) ) / [ x^7 == x^3 ], SkeletalFinSets )>

julia> IsWellDefined( G )
true

julia> Display( G )
Image of <(o)>:
|8|

Image of (o)-[(x)]->(o):
|8| → |8|

An object in PreSheaves( PathCategory( FinQuiver( "q(o)[x:o→o]" ) ) / [ x^7 == x^3 ], SkeletalFinSets ) given by the above data

julia> pi = EpimorphismFromSomeProjectiveObject( G )
<A morphism in PreSheaves( PathCategory( FinQuiver( "q(o)[x:o→o]" ) ) / [ x^7 == x^3 ], SkeletalFinSets )>

julia> im = ImageObject( pi )
<An object in PreSheaves( PathCategory( FinQuiver( "q(o)[x:o→o]" ) ) / [ x^7 == x^3 ], SkeletalFinSets )>

julia> Display( im )
Image of <(o)>:
|8|

Image of (o)-[(x)]->(o):
|8| → |8|

An object in PreSheaves( PathCategory( FinQuiver( "q(o)[x:o→o]" ) ) / [ x^7 == x^3 ], SkeletalFinSets ) given by the above data

julia> im == G
true

julia> coim = CoimageObject( pi )
<An object in PreSheaves( PathCategory( FinQuiver( "q(o)[x:o→o]" ) ) / [ x^7 == x^3 ], SkeletalFinSets )>

julia> Display( coim )
Image of <(o)>:
|8|

Image of (o)-[(x)]->(o):
|8| → |8|

An object in PreSheaves( PathCategory( FinQuiver( "q(o)[x:o→o]" ) ) / [ x^7 == x^3 ], SkeletalFinSets ) given by the above data

julia> coim == im
false

julia> iso = MorphismFromCoimageToImage( pi )
<A morphism in PreSheaves( PathCategory( FinQuiver( "q(o)[x:o→o]" ) ) / [ x^7 == x^3 ], SkeletalFinSets )>

julia> IsWellDefined( iso )
true

julia> IsIsomorphism( iso )
true

julia> inv = InverseOfMorphismFromCoimageToImage( pi )
<A morphism in PreSheaves( PathCategory( FinQuiver( "q(o)[x:o→o]" ) ) / [ x^7 == x^3 ], SkeletalFinSets )>

julia> IsEqualToIdentityMorphism( PreCompose( iso, inv ) )
true

julia> IsEqualToIdentityMorphism( PreCompose( inv, iso ) )
true

julia> coYoG = CoYonedaLemmaOnObjects( G )
<An object in FiniteColimitCompletionWithStrictCoproducts( PathCategory( FinQuiver( "q(o)[x:o→o]" ) ) / [ x^7 == x^3 ] )>

julia> sec = SectionFromOptimizedCoYonedaProjectiveObjectIntoCoYonedaProjectiveObject( G )
<A morphism in FiniteStrictCoproductCompletion( PathCategory( FinQuiver( "q(o)[x:o→o]" ) ) / [ x^7 == x^3 ] )>

julia> IsWellDefined( sec )
true

julia> pi = EpimorphismFromSomeProjectiveObject( G )
<A morphism in PreSheaves( PathCategory( FinQuiver( "q(o)[x:o→o]" ) ) / [ x^7 == x^3 ], SkeletalFinSets )>

julia> ast = AstrictionToCoimage( pi )
<A morphism in PreSheaves( PathCategory( FinQuiver( "q(o)[x:o→o]" ) ) / [ x^7 == x^3 ], SkeletalFinSets )>

julia> IsWellDefined( ast )
true

```
