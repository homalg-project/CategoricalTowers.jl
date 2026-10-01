```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, CartesianCategories, QuotientCategories, LinearAlgebraForCAP, LinearClosuresForCAP, AdditiveClosuresForCAP, FreydCategoriesForCAP, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, FpCategories, FpLinearCategories, Locales, FiniteCocompletions, PresheafCategories, SubcategoriesForCAP, FunctorCategories

julia> q = FinQuiver( "q(1)[a:1->1]" )
FinQuiver( "q(1)[a:1→1]" )

julia> Fq = PathCategory( q )
PathCategory( FinQuiver( "q(1)[a:1→1]" ) )

julia> M0 = Fq / [ [ Fq.a^3, Fq.id_1 ] ]
PathCategory( FinQuiver( "q(1)[a:1→1]" ) ) / [ a^3 == id(1) ]

julia> M0 = CategoryFromDataTables( M0 )
PathCategory( FinQuiver( "q(1)[a:1→1]" ) ) / [ a^3 == id(1) ]

julia> PShM0 = PreSheaves( M0 )
PreSheaves( PathCategory( FinQuiver( "q(1)[a:1→1]" ) ) / [ a^3 == id(1) ], SkeletalFinSets )

julia> Omega0 = SubobjectClassifier( PShM0 )
<An object in PreSheaves( PathCategory( FinQuiver( "q(1)[a:1→1]" ) ) / [ a^3 == id(1) ], SkeletalFinSets )>

julia> IsProjective( Omega0 )
false

julia> IsReflexive( Omega0 )
false

julia> e = Exponential( Omega0, Omega0 )
<An object in PreSheaves( PathCategory( FinQuiver( "q(1)[a:1→1]" ) ) / [ a^3 == id(1) ], SkeletalFinSets )>

julia> ev0 = CartesianLeftEvaluationMorphism( Omega0, Omega0 )
<A morphism in PreSheaves( PathCategory( FinQuiver( "q(1)[a:1→1]" ) ) / [ a^3 == id(1) ], SkeletalFinSets )>

julia> M1 = Fq / [ [ Fq.a^3, Fq.a ] ]
PathCategory( FinQuiver( "q(1)[a:1→1]" ) ) / [ a^3 == a ]

julia> M1 = CategoryFromDataTables( M1 )
PathCategory( FinQuiver( "q(1)[a:1→1]" ) ) / [ a^3 == a ]

julia> PShM1 = PreSheaves( M1 )
PreSheaves( PathCategory( FinQuiver( "q(1)[a:1→1]" ) ) / [ a^3 == a ], SkeletalFinSets )

julia> Omega1 = SubobjectClassifier( PShM1 )
<An object in PreSheaves( PathCategory( FinQuiver( "q(1)[a:1→1]" ) ) / [ a^3 == a ], SkeletalFinSets )>

julia> IsProjective( Omega1 )
false

julia> IsReflexive( Omega1 )
false

julia> M2 = Fq / [ [ Fq.a^3, Fq.a^2 ] ]
PathCategory( FinQuiver( "q(1)[a:1→1]" ) ) / [ a^3 == a^2 ]

julia> M2 = CategoryFromDataTables( M2 )
PathCategory( FinQuiver( "q(1)[a:1→1]" ) ) / [ a^3 == a^2 ]

julia> PShM2 = PreSheaves( M2 )
PreSheaves( PathCategory( FinQuiver( "q(1)[a:1→1]" ) ) / [ a^3 == a^2 ], SkeletalFinSets )

julia> Omega2 = SubobjectClassifier( PShM2 )
<An object in PreSheaves( PathCategory( FinQuiver( "q(1)[a:1→1]" ) ) / [ a^3 == a^2 ], SkeletalFinSets )>

julia> IsProjective( Omega2 )
true

julia> IsReflexive( Omega2 )
false

julia> true2 = TruthMorphismOfTrue( PShM2 )
<A morphism in PreSheaves( PathCategory( FinQuiver( "q(1)[a:1→1]" ) ) / [ a^3 == a^2 ], SkeletalFinSets )>

julia> false2 = TruthMorphismOfFalse( PShM2 )
<A morphism in PreSheaves( PathCategory( FinQuiver( "q(1)[a:1→1]" ) ) / [ a^3 == a^2 ], SkeletalFinSets )>

julia> iota_M2 = EmbeddingOfSieveFunctor( M2 )
Natural transformation from Functor from Opposite( PathCategory( FinQuiver( "q(1)[a:1→1]" ) ) / [ a^3 == a^2 ] ) -> SkeletalFinSets -> Functor from Opposite( PathCategory( FinQuiver( "q(1)[a:1→1]" ) ) / [ a^3 == a^2 ] ) -> SkeletalFinSets

julia> iota = CreatePreSheafMorphism( iota_M2 )
<A morphism in PreSheaves( PathCategory( FinQuiver( "q(1)[a:1→1]" ) ) / [ a^3 == a^2 ], SkeletalFinSets )>

julia> Target( iota )
<An object in PreSheaves( PathCategory( FinQuiver( "q(1)[a:1→1]" ) ) / [ a^3 == a^2 ], SkeletalFinSets )>

julia> t2 = SubobjectOfClassifyingMorphism( true2 )
<A morphism in PreSheaves( PathCategory( FinQuiver( "q(1)[a:1→1]" ) ) / [ a^3 == a^2 ], SkeletalFinSets )>

julia> f2 = SubobjectOfClassifyingMorphism( false2 )
<A morphism in PreSheaves( PathCategory( FinQuiver( "q(1)[a:1→1]" ) ) / [ a^3 == a^2 ], SkeletalFinSets )>

julia> H = HomStructure( Omega2, Omega2 )
|8|

julia> T2 = DistinguishedObjectOfHomomorphismStructure( PShM2 )
|1|

julia> L = List( H, i -> InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( Omega2, Omega2, MapOfFinSets( T2, [ i ], H ) ) );

julia> ForAll( L, IsWellDefined )
true

julia> Length( L )
8

```
