
```jldoctest AutoDocTests
julia> using CAP, ToolsForCategoricalTowers, Locales, MatricesForHomalg, AdditiveClosuresForCAP, FreydCategoriesForCAP, SubcategoriesForCAP

julia> # extracted from examples/Freyd_ZZ.g

julia> true
true

julia> true
true

julia> zz = HomalgRingOfIntegers( );

julia> rows = CategoryOfRows( zz )
Rows( Z )

julia> A = FreydCategory( rows )
Freyd( Rows( Z ) )

julia> Proj_A = FullSubcategoryOfProjectiveObjects( A )
FullSubcategoryOfProjectiveObjects( Freyd( Rows( Z ) ) )

julia> M1 = HomalgMatrix( [ [ 1, 0 ], [ 0, 0 ] ], 2, 2, zz ) / rows / A / Proj_A;

julia> M2 = HomalgMatrix( [ [ 2, 0 ], [ 0, 0 ] ], 2, 2, zz ) / rows / A / Proj_A;

julia> IsWellDefinedForObjects( M1 )
true

julia> IsWellDefinedForObjects( M2 )
false

```
