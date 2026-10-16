
```jldoctest
julia> using CAP, MonoidalCategories, CartesianCategories, ToolsForCategoricalTowers, Toposes, Locales, FpCategories, FreydCategoriesForCAP, FinSetsForCAP, Singular, MatricesForHomalg, AdditiveClosuresForCAP, SliceCategories

julia> true
true

julia> T = TerminalCategoryWithMultipleObjects( )
TerminalCategoryWithMultipleObjects( )

julia> B = TerminalObject( T )
<An object in TerminalCategoryWithMultipleObjects( )>

julia> S = SliceCategory( B )
A slice category of TerminalCategoryWithMultipleObjects( )

julia> obj = IdentityMorphism( B ) / S
An object in the slice category given by:
<A morphism in TerminalCategoryWithMultipleObjects( )>

julia> mor = ProjectionInFactorOfDirectProduct( [ obj, obj, obj ], 3 )
A morphism in the slice category given by:
<A morphism in TerminalCategoryWithMultipleObjects( )>

julia> IsWellDefinedForMorphisms( mor )
true

```
