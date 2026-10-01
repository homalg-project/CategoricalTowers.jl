```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, CartesianCategories, QuotientCategories, LinearAlgebraForCAP, LinearClosuresForCAP, AdditiveClosuresForCAP, FreydCategoriesForCAP, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, FpCategories, FpLinearCategories, Locales, FiniteCocompletions, PresheafCategories, SubcategoriesForCAP, FunctorCategories

julia> q = FinQuiver( "q(o)[x:o→o]" )
FinQuiver( "q(o)[x:o→o]" )

julia> F = PathCategory( q )
PathCategory( FinQuiver( "q(o)[x:o→o]" ) )

julia> C = F / [ [ F.x^(4+12), F.x^4 ] ]
PathCategory( FinQuiver( "q(o)[x:o→o]" ) ) / [ x^16 == x^4 ]

julia> C = CategoryFromDataTables( C );

julia> x = C.x
(o)-[(x)]->(o)

julia> IsMonomorphism( x )
false

julia> IsEpimorphism( x )
false

julia> PSh = PreSheaves( C )
PreSheaves( PathCategory( FinQuiver( "q(o)[x:o→o]" ) ) / [ x^16 == x^4 ], SkeletalFinSets )

julia> Go = FinSet( 18 )
|18|

julia> Gx = [ 5, 0, 1, 2, 3, 4, 0, 2, 5, 6, 6, 7, 7, 8, 8, 9, 9, 16 ];

julia> Gx = MapOfFinSets( Go, Gx, Go )
|18| → |18|

julia> G =  CreatePreSheafByValues( PSh, PairGAP( [ Go ], [ Gx ] ) )
<An object in PreSheaves( PathCategory( FinQuiver( "q(o)[x:o→o]" ) ) / [ x^16 == x^4 ], SkeletalFinSets )>

julia> IsWellDefined( G )
true

julia> pi = EpimorphismFromSomeProjectiveObject( G )
<A morphism in PreSheaves( PathCategory( FinQuiver( "q(o)[x:o→o]" ) ) / [ x^16 == x^4 ], SkeletalFinSets )>

julia> im = ImageObject( pi )
<An object in PreSheaves( PathCategory( FinQuiver( "q(o)[x:o→o]" ) ) / [ x^16 == x^4 ], SkeletalFinSets )>

julia> im == G
true

julia> coim = CoimageObject( pi )
<An object in PreSheaves( PathCategory( FinQuiver( "q(o)[x:o→o]" ) ) / [ x^16 == x^4 ], SkeletalFinSets )>

julia> coim == im
false

julia> iso = MorphismFromCoimageToImage( pi )
<A morphism in PreSheaves( PathCategory( FinQuiver( "q(o)[x:o→o]" ) ) / [ x^16 == x^4 ], SkeletalFinSets )>

julia> IsWellDefined( iso )
true

julia> IsIsomorphism( iso )
true

julia> inv = InverseOfMorphismFromCoimageToImage( pi )
<A morphism in PreSheaves( PathCategory( FinQuiver( "q(o)[x:o→o]" ) ) / [ x^16 == x^4 ], SkeletalFinSets )>

julia> IsEqualToIdentityMorphism( PreCompose( iso, inv ) )
true

julia> IsEqualToIdentityMorphism( PreCompose( inv, iso ) )
true

julia> coYoG = CoYonedaLemmaOnObjects( G )
<An object in FiniteColimitCompletionWithStrictCoproducts( PathCategory( FinQuiver( "q(o)[x:o→o]" ) ) / [ x^16 == x^4 ] )>

julia> sec = SectionFromOptimizedCoYonedaProjectiveObjectIntoCoYonedaProjectiveObject( G )
<A morphism in FiniteStrictCoproductCompletion( PathCategory( FinQuiver( "q(o)[x:o→o]" ) ) / [ x^16 == x^4 ] )>

julia> IsWellDefined( sec )
true

julia> pi = EpimorphismFromSomeProjectiveObject( G )
<A morphism in PreSheaves( PathCategory( FinQuiver( "q(o)[x:o→o]" ) ) / [ x^16 == x^4 ], SkeletalFinSets )>

julia> ast = AstrictionToCoimage( pi )
<A morphism in PreSheaves( PathCategory( FinQuiver( "q(o)[x:o→o]" ) ) / [ x^16 == x^4 ], SkeletalFinSets )>

julia> IsWellDefined( ast )
true

```
