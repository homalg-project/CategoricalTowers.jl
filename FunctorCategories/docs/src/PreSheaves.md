```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, CartesianCategories, LinearAlgebraForCAP, FreydCategoriesForCAP, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, FpCategories, FpLinearCategories, Locales, PresheafCategories, QuotientCategories, SubcategoriesForCAP, FunctorCategories

julia> q_O = FinQuiver( "q_O(A,B,C)[x:A->B,y:A->B,z:B->C,w:B->C]" )
FinQuiver( "q_O(A,B,C)[x:A→B,y:A→B,z:B→C,w:B→C]" )

julia> P_O = PathCategory( q_O )
PathCategory( FinQuiver( "q_O(A,B,C)[x:A→B,y:A→B,z:B→C,w:B→C]" ) )

julia> rho_O = [ [ P_O.xz, P_O.yw ] ];

julia> quotient_P_O = QuotientCategory( P_O, rho_O )
PathCategory( FinQuiver( "q_O(A,B,C)[x:A→B,y:A→B,z:B→C,w:B→C]" ) ) / [ x⋅z == y⋅w ]

julia> QQ = HomalgFieldOfRationals( )
Rational field

julia> k = QQ
Rational field

julia> k_quotient_P_O = k[quotient_P_O]
Q-LinearClosure( PathCategory( FinQuiver( "q_O(A,B,C)[x:A→B,y:A→B,z:B→C,w:B→C]" ) ) / [ x⋅z == y⋅w ] )

julia> IsAdmissibleAlgebroid( k_quotient_P_O )
true

julia> A_O = AlgebroidFromDataTables( k_quotient_P_O )
Q-algebroid( [A,B,C][x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms

julia> HasIsAdmissibleAlgebroid( A_O ) && IsAdmissibleAlgebroid( A_O )
true

julia> phi = 2 * A_O.x + 3 * A_O.y
<2*x + 3*y:(A) → (B)>

julia> PSh = PreSheavesOfFpEnrichedCategory( A_O )
PreSheaves( Q-algebroid( [A,B,C][x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms, Rows( Q ) )

julia> Display( PSh )
A CAP category with name PreSheaves( Q-algebroid( [A,B,C][x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms, Rows( Q ) ):

59 primitive operations were used to derive 363 operations for this category which algorithmically
* IsCategoryWithDecidableColifts
* IsCategoryWithDecidableLifts
* IsEquippedWithHomomorphismStructure
* IsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms
* IsAbelianCategoryWithEnoughInjectives
* IsAbelianCategoryWithEnoughProjectives

julia> indec_projs = IndecomposableProjectiveObjects( PSh );

julia> ViewObj( indec_projs )
[ <(A)->1, (B)->0, (C)->0; (x)->0x1, (y)->0x1, (z)->0x0, (w)->0x0>, <(A)->2, (B)->1, (C)->0; (x)->1x2, (y)->1x2, (z)->0x1, (w)->0x1>, <(A)->3, (B)->2, (C)->1; (x)->2x3, (y)->2x3, (z)->1x2, (w)->1x2> ]


julia> indec_injs = IndecomposableInjectiveObjects( PSh );

julia> ViewObj( indec_injs )
[ <(A)->1, (B)->2, (C)->3; (x)->2x1, (y)->2x1, (z)->3x2, (w)->3x2>, <(A)->0, (B)->1, (C)->2; (x)->1x0, (y)->1x0, (z)->2x1, (w)->2x1>, <(A)->0, (B)->0, (C)->1; (x)->0x0, (y)->0x0, (z)->1x0, (w)->1x0> ]

```
