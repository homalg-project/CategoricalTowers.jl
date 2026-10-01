```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, CartesianCategories, QuotientCategories, LinearAlgebraForCAP, LinearClosuresForCAP, AdditiveClosuresForCAP, FreydCategoriesForCAP, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, FpCategories, FpLinearCategories, Locales, FiniteCocompletions, PresheafCategories, SubcategoriesForCAP, FunctorCategories

julia> Delta2 = SimplicialCategoryTruncatedInDegree( 2 )
PathCategory( FinQuiver( "Delta(C0,C1,C2)[id:C1→C0,s:C0→C1,t:C0→C1,is:C2→C1,it:C2→C1,ps:C1→C2,pt:C1→C2,mu:C1→C2]" ) ) / [ s⋅id == id(C0), t⋅id == id(C0), ps⋅is == id(C1), ... ]

julia> ViewObj( DefiningRelations( Delta2 ) )
[ [ s⋅id:(C0) → (C0), id(C0):(C0) → (C0) ], [ t⋅id:(C0) → (C0), id(C0):(C0) → (C0) ], [ ps⋅is:(C1) → (C1), id(C1):(C1) → (C1) ], [ pt⋅it:(C1) → (C1), id(C1):(C1) → (C1) ], [ is⋅id:(C2) → (C0), it⋅id:(C2) → (C0) ], [ pt⋅is:(C1) → (C1), id⋅t:(C1) → (C1) ], [ ps⋅it:(C1) → (C1), id⋅s:(C1) → (C1) ], [ s⋅pt:(C0) → (C2), t⋅ps:(C0) → (C2) ], [ s⋅mu:(C0) → (C2), s⋅ps:(C0) → (C2) ], [ t⋅mu:(C0) → (C2), t⋅pt:(C0) → (C2) ], [ mu⋅is:(C1) → (C1), id(C1):(C1) → (C1) ], [ mu⋅it:(C1) → (C1), id(C1):(C1) → (C1) ] ]

julia> Size( Delta2 )
31

julia> Ypt = YonedaProjection( Delta2 )
<A morphism in FunctorCategory( PathCategory( FinQuiver( "Delta(C0,C1,C2)[id:C1→C0,s:C0→C1,t:C0→C1,is:C2→C1,it:C2→C1,ps:C1→C2,pt:C1→C2,mu:C1→C2]" ) ) / [ s⋅id == id(C0), t⋅id == id(C0), ps⋅is == id(C1), ... ], SkeletalFinSets )>

julia> IsWellDefined( Ypt )
true

julia> Ymu = YonedaComposition( Delta2 )
<A morphism in FunctorCategory( PathCategory( FinQuiver( "Delta(C0,C1,C2)[id:C1→C0,s:C0→C1,t:C0→C1,is:C2→C1,it:C2→C1,ps:C1→C2,pt:C1→C2,mu:C1→C2]" ) ) / [ s⋅id == id(C0), t⋅id == id(C0), ps⋅is == id(C1), ... ], SkeletalFinSets )>

julia> IsWellDefined( Ymu )
true

julia> Ys = YonedaFibration( Delta2 )
<A morphism in FunctorCategory( PathCategory( FinQuiver( "Delta(C0,C1,C2)[id:C1→C0,s:C0→C1,t:C0→C1,is:C2→C1,it:C2→C1,ps:C1→C2,pt:C1→C2,mu:C1→C2]" ) ) / [ s⋅id == id(C0), t⋅id == id(C0), ps⋅is == id(C1), ... ], SkeletalFinSets )>

julia> IsWellDefined( Ys )
true

```
