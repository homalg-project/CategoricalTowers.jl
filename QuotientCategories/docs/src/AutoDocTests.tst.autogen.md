
```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, ToolsForCategoricalTowers, LinearAlgebraForCAP, ModulePresentationsForCAP, QuotientCategories

julia> true
true

julia> true
true

julia> zz = HomalgRingOfIntegers( );

julia> zz_pres = LeftPresentations( zz )
Category of left presentations of Z

julia> congruence_func = phi -> IsLiftable( phi, EpimorphismFromSomeProjectiveObject( Target( phi ) ) );

julia> name = "QuotientCategory( Category of left presentations of Z ) by projectives";

julia> quotient_cat = QuotientCategory(
                          @rec( underlying_category = zz_pres,
                            name = name,
                            congruence_func = congruence_func,
                            nr_arguments_of_congruence_func = 1 ) )
QuotientCategory( Category of left presentations of Z ) by projectives

julia> Display( quotient_cat )
A CAP category with name QuotientCategory( Category of left presentations of Z ) by projectives:

23 primitive operations were used to derive 135 operations for this category
which algorithmically
* IsLinearCategoryOverCommutativeRing
* IsAdditiveCategory

julia> m = HomalgMatrix( [ [ -2, 0, 0, -1 ], [ 8, 0, 0, 4 ], [ -43, 2, 1, -17 ], [ 6, 0, 0, 3 ] ], 4, 4, zz );

julia> M = AsLeftPresentation( zz_pres, m )
<An object in Category of left presentations of Z>

julia> IsProjective( M )
true

julia> quotient_M = M / quotient_cat;

julia> IsZeroForObjects( quotient_M )
true

```
