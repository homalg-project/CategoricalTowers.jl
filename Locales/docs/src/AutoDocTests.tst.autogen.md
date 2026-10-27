
```jldoctest AutoDocTests
julia> using CAP, MonoidalCategories, CartesianCategories, ToolsForCategoricalTowers, Toposes, FpCategories, Locales

julia> # extracted from examples/DiscreteSkeletalCategory.g

julia> true
true

julia> D = SkeletalDiscreteCategory( "IsPosInt" )
SkeletalDiscreteCategory( "IsPosInt" )

julia> Display( D )
A CAP category with name SkeletalDiscreteCategory( "IsPosInt" ):

8 primitive operations were used to derive 84 operations for this category
which algorithmically
* IsCategoryWithDecidableColifts
* IsCategoryWithDecidableLifts
* IsPosetCategory
* IsEquippedWithHomomorphismStructure
and furthermore mathematically
* IsDiscreteCategory

julia> one = 1 / D
<An object in SkeletalDiscreteCategory( "IsPosInt" )>

julia> Display( one )
1

An object in SkeletalDiscreteCategory( "IsPosInt" ) given by the above data

julia> IsWellDefined( one )
true

julia> two = 2 / D
<An object in SkeletalDiscreteCategory( "IsPosInt" )>

julia> id_one = IdentityMorphism( one )
<A morphism in SkeletalDiscreteCategory( "IsPosInt" )>

julia> MorphismDatum( id_one )
fail

julia> IsOne( PreCompose( id_one, id_one ) )
true

julia> IsOne( UniqueMorphism( one, one ) )
true

julia> IsWellDefined( UniqueMorphism( one, two ) )
false

julia> HomStructure( one, one )
<(⊤)>

julia> HomStructure( one, two )
<(⊥)>

julia> HomStructure( two, one )
<(⊥)>

```

```jldoctest AutoDocTests
julia> using CAP, MonoidalCategories, CartesianCategories, ToolsForCategoricalTowers, Toposes, FpCategories, Locales

julia> # extracted from examples/TotalOrderAsCategory.g

julia> true
true

julia> D = TotalOrderAsCategory( "IsInt", (a,b) -> a <= b )
TotalOrderAsCategory( "IsInt" )

julia> Display( D )
A CAP category with name TotalOrderAsCategory( "IsInt" ):

8 primitive operations were used to derive 86 operations for this category
which algorithmically
* IsCategoryWithDecidableColifts
* IsCategoryWithDecidableLifts
* IsPosetCategory
* IsEquippedWithHomomorphismStructure
and furthermore mathematically
* IsTotalOrderCategory

julia> one = 1 / D
<An object in TotalOrderAsCategory( "IsInt" )>

julia> Display( one )
1

An object in TotalOrderAsCategory( "IsInt" ) given by the above data

julia> IsWellDefined( one )
true

julia> IsWellDefined( -1 / D )
true

julia> two = 2 / D
<An object in TotalOrderAsCategory( "IsInt" )>

julia> id_one = IdentityMorphism( one )
<A morphism in TotalOrderAsCategory( "IsInt" )>

julia> MorphismDatum( id_one )
fail

julia> IsOne( PreCompose( id_one, id_one ) )
true

julia> IsOne( UniqueMorphism( one, one ) )
true

julia> IsWellDefined( UniqueMorphism( one, two ) )
true

julia> HomStructure( one, one )
<(⊤)>

julia> IsHomSetInhabited( one, one )
true

julia> HomStructure( one, two )
<(⊤)>

julia> IsHomSetInhabited( one, two )
true

julia> HomStructure( two, one )
<(⊥)>

julia> IsHomSetInhabited( two, one )
false

julia> DirectProduct( [ one, two ] ) == one
true

julia> Coproduct( [ one, two ] ) == two
true

```

```jldoctest AutoDocTests
julia> using CAP, MonoidalCategories, CartesianCategories, ToolsForCategoricalTowers, Toposes, FpCategories, Locales

julia> # extracted from examples/ProsetOfCategory.g

julia> true
true

julia> q = FinQuiver( "q(a,b)[f:a->b,g:b->a]" )
FinQuiver( "q(a,b)[f:a→b,g:b→a]" )

julia> F = PathCategory( q )
PathCategory( FinQuiver( "q(a,b)[f:a→b,g:b→a]" ) )

julia> C = F / [ [ F.fg, F.id_a ], [ F.gf, F.id_b ] ]
PathCategory( FinQuiver( "q(a,b)[f:a→b,g:b→a]" ) )
/ [ f⋅g == id(a), g⋅f == id(b) ]

julia> P = ProsetOfCategory( C )
ProsetOfCategory( PathCategory( FinQuiver( "q(a,b)[f:a→b,g:b→a]" ) )
/ [ f⋅g == id(a), g⋅f == id(b) ] )

julia> Display( P )
A CAP category with name
ProsetOfCategory( PathCategory( FinQuiver( "q(a,b)[f:a→b,g:b→a]" ) )
/ [ f⋅g == id(a), g⋅f == id(b) ] ):

11 primitive operations were used to derive 85 operations for this category
which algorithmically
* IsThinCategory
* IsCategoryWithDecidableColifts
* IsCategoryWithDecidableLifts
* IsFiniteCategory
* IsEquippedWithHomomorphismStructure

julia> Display( SetOfObjects( P ) )
[ An object in the proset given by: (a), An object in the proset given by: (b) ]

julia> P.a == P.b
false

julia> Length( SetOfMorphisms( P ) )
4

julia> Size( P )
4

julia> Display( SetOfGeneratingMorphisms( P ) )
[ A morphism in the proset given by: [f]:(a) → (b),
  A morphism in the proset given by: [g]:(b) → (a) ]

```
