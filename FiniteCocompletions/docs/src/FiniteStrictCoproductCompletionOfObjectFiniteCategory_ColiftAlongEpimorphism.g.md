```jldoctest AutoDocTests
julia> using CAP, MonoidalCategories, CartesianCategories, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, QuotientCategories, LocalesForCAP, FpCategories, AdditiveClosuresForCAP, FreydCategoriesForCAP, PresheafCategories, FiniteCocompletions

julia> # extracted from examples/FiniteStrictCoproductCompletionOfObjectFiniteCategory_ColiftAlongEpimorphism.g

julia> true
true

julia> T = TerminalCategoryWithSingleObject( )
TerminalCategoryWithSingleObject( )

julia> id_T = SetOfMorphisms( T )[1];

julia> UTm = FiniteStrictCoproductCompletionOfObjectFiniteCategory( T )
FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )

julia> x = PairGAP( BigInt(5), [ BigInt(5) ] ) / UTm
<An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> y = PairGAP( BigInt(3), [ BigInt(3) ] ) / UTm
<An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> t = PairGAP( BigInt(2), [ BigInt(2) ] ) / UTm
<An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> pi = MorphismConstructor(
                      x,
                      [ [ [ BigInt(0), BigInt(0), BigInt(0), BigInt(0), BigInt(0) ] ],
                        [ [ BigInt(0), BigInt(0), BigInt(2), BigInt(1), BigInt(1) ] ],
                        [ [ id_T, id_T, id_T, id_T, id_T ] ] ],
                      y )
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> phi = MorphismConstructor(
                       x,
                       [ [ [ BigInt(0), BigInt(0), BigInt(0), BigInt(0), BigInt(0) ] ],
                         [ [ BigInt(1), BigInt(1), BigInt(1), BigInt(0), BigInt(0) ] ],
                         [ [ id_T, id_T, id_T, id_T, id_T ] ] ],
                       t )
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> IsColiftableAlongEpimorphism( pi, phi )
true

julia> psi = ColiftAlongEpimorphism( pi, phi )
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> PreCompose( pi, psi ) == phi
true

julia> x = PairGAP( BigInt(4), [ BigInt(4) ] ) / UTm
<An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> y = PairGAP( BigInt(3), [ BigInt(3) ] ) / UTm
<An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> pi = MorphismConstructor(
                      x,
                      [ [ [ BigInt(0), BigInt(0), BigInt(0), BigInt(0) ] ],
                        [ [ BigInt(1), BigInt(0), BigInt(1), BigInt(2) ] ],
                        [ [ id_T, id_T, id_T, id_T ] ] ],
                      y )
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> IsColiftableAlongEpimorphism( pi, pi )
true

julia> psi = ColiftAlongEpimorphism( pi, pi )
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> psi == IdentityMorphism( y )
true

julia> x = PairGAP( BigInt(4), [ BigInt(4) ] ) / UTm
<An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> f = MorphismConstructor(
                     x,
                     [ [ [ BigInt(0), BigInt(0), BigInt(0), BigInt(0) ] ],
                       [ [ BigInt(1), BigInt(3), BigInt(0), BigInt(2) ] ],
                       [ [ id_T, id_T, id_T, id_T ] ] ],
                     x )
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> id_x = IdentityMorphism( x )
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> IsColiftableAlongEpimorphism( f, id_x )
true

julia> f_inv = ColiftAlongEpimorphism( f, id_x )
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> PreCompose( f, f_inv ) == IdentityMorphism( x )
true

julia> x_1 = PairGAP( BigInt(4), [ BigInt(4) ] ) / UTm
<An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> y_1 = PairGAP( BigInt(3), [ BigInt(3) ] ) / UTm
<An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> t_1 = PairGAP( BigInt(2), [ BigInt(2) ] ) / UTm
<An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> pi_1 = MorphismConstructor(
                        x_1,
                        [ [ [ BigInt(0), BigInt(0), BigInt(0), BigInt(0) ] ],
                          [ [ BigInt(0), BigInt(0), BigInt(1), BigInt(2) ] ],
                          [ [ id_T, id_T, id_T, id_T ] ] ],
                        y_1 )
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> phi_1 = MorphismConstructor(
                         x_1,
                         [ [ [ BigInt(0), BigInt(0), BigInt(0), BigInt(0) ] ],
                           [ [ BigInt(1), BigInt(1), BigInt(0), BigInt(0) ] ],
                           [ [ id_T, id_T, id_T, id_T ] ] ],
                         t_1 )
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> psi_1 = ColiftAlongEpimorphism( pi_1, phi_1 )
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> x_2 = PairGAP( BigInt(2), [ BigInt(2) ] ) / UTm
<An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> pi_2 = MorphismConstructor(
                        x_2,
                        [ [ [ BigInt(0), BigInt(0) ] ], [ [ BigInt(1), BigInt(0) ] ], [ [ id_T, id_T ] ] ],
                        x_2 )
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> phi_2 = IdentityMorphism( x_2 )
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> psi_2 = ColiftAlongEpimorphism( pi_2, phi_2 )
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> pi = CoproductFunctorial( [ x_1, x_2 ], [ pi_1, pi_2 ], [ y_1, x_2 ] )
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> phi = CoproductFunctorial( [ x_1, x_2 ], [ phi_1, phi_2 ], [ t_1, x_2 ] )
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> psi_to_be =
          CoproductFunctorial( [ y_1, x_2 ], [ psi_1, psi_2 ], [ t_1, x_2 ] )
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> psi_to_be == ColiftAlongEpimorphism( pi, phi )
true

```
