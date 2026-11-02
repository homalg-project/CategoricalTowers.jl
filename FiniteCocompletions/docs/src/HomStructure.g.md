```jldoctest AutoDocTests
julia> using CAP, MonoidalCategories, CartesianCategories, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, QuotientCategories, LocalesForCAP, FpCategories, AdditiveClosuresForCAP, FreydCategoriesForCAP, PresheafCategories, FiniteCocompletions

julia> # extracted from examples/HomStructure.g

julia> true
true

julia> T = TerminalCategoryWithMultipleObjects( )
TerminalCategoryWithMultipleObjects( )

julia> sFinSets = FiniteStrictCoproductCompletion( T )
FiniteStrictCoproductCompletion( TerminalCategoryWithMultipleObjects( ) )

julia> Display( sFinSets )
A CAP category with name
FiniteStrictCoproductCompletion( TerminalCategoryWithMultipleObjects( ) ):

36 primitive operations were used to derive 173 operations for this category
which algorithmically
* IsCategoryWithDecidableColifts
* IsCategoryWithDecidableLifts
* IsEquippedWithHomomorphismStructure
* IsFiniteCompleteCategory
* IsDistributiveCategory
and furthermore mathematically
* IsStrictCocartesianCategory

julia> t = TerminalObject( sFinSets )
<An object in
 FiniteStrictCoproductCompletion( TerminalCategoryWithMultipleObjects( ) )>

julia> IsTerminal( t )
true

julia> IsInitial( t )
false

julia> i = InitialObject( sFinSets )
<An object in
 FiniteStrictCoproductCompletion( TerminalCategoryWithMultipleObjects( ) )>

julia> IsTerminal( i )
false

julia> IsInitial( i )
true

julia> UniversalMorphismFromInitialObject(t) == UniversalMorphismIntoTerminalObject(i)
true

julia> A = [ BigInt(3), [ "A0" / T, "A1" / T, "A2" / T ] ] / sFinSets
<An object in
 FiniteStrictCoproductCompletion( TerminalCategoryWithMultipleObjects( ) )>

julia> B = [ BigInt(2), [ "B0" / T, "B1" / T ] ] / sFinSets
<An object in
 FiniteStrictCoproductCompletion( TerminalCategoryWithMultipleObjects( ) )>

julia> piA = ProjectionInFactorOfDirectProduct( [ A, B ], 1 )
<A morphism in
 FiniteStrictCoproductCompletion( TerminalCategoryWithMultipleObjects( ) )>

julia> piB = ProjectionInFactorOfDirectProduct( [ A, B ], 2 )
<A morphism in
 FiniteStrictCoproductCompletion( TerminalCategoryWithMultipleObjects( ) )>

julia> IsOne( UniversalMorphismIntoDirectProduct( [ piA, piB ] ) )
true

julia> I = HomStructure( sFinSets )
<An object in
 FiniteStrictCoproductCompletion( TerminalCategoryWithSingleObject( ) )>

julia> U = ObjectDatum( I )[2][1]
<An object in TerminalCategoryWithSingleObject( )>

julia> HomAB = HomStructure( A, B )
<An object in
 FiniteStrictCoproductCompletion( TerminalCategoryWithSingleObject( ) )>

julia> L = ObjectDatum( HomAB );

julia> homAB = List( MorphismsOfExternalHom( A, B ), HomStructure );

julia> ViewObj( homAB )
[ <A morphism in
   FiniteStrictCoproductCompletion( TerminalCategoryWithSingleObject( ) )>,
  <A morphism in
   FiniteStrictCoproductCompletion( TerminalCategoryWithSingleObject( ) )>,
  <A morphism in
   FiniteStrictCoproductCompletion( TerminalCategoryWithSingleObject( ) )>,
  <A morphism in
   FiniteStrictCoproductCompletion( TerminalCategoryWithSingleObject( ) )>,
  <A morphism in
   FiniteStrictCoproductCompletion( TerminalCategoryWithSingleObject( ) )>,
  <A morphism in
   FiniteStrictCoproductCompletion( TerminalCategoryWithSingleObject( ) )>,
  <A morphism in
   FiniteStrictCoproductCompletion( TerminalCategoryWithSingleObject( ) )>,
  <A morphism in
   FiniteStrictCoproductCompletion( TerminalCategoryWithSingleObject( ) )> ]

julia> all( List( homAB, IsWellDefined ) )
true

julia> List( homAB, m -> HomStructure( HomStructure( A, B, m ) ) ) == homAB
true

julia> alpha = HomStructure( A, B, homAB[6] )
<A morphism in
 FiniteStrictCoproductCompletion( TerminalCategoryWithMultipleObjects( ) )>

julia> gamma = HomStructure( A, B, homAB[2] )
<A morphism in
 FiniteStrictCoproductCompletion( TerminalCategoryWithMultipleObjects( ) )>

julia> hom_alpha_gamma = HomStructure( alpha, gamma )
<A morphism in
 FiniteStrictCoproductCompletion( TerminalCategoryWithSingleObject( ) )>

julia> IsWellDefined( hom_alpha_gamma )
true

```
