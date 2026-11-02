```jldoctest AutoDocTests
julia> using CAP, MonoidalCategories, CartesianCategories, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, QuotientCategories, LocalesForCAP, FpCategories, AdditiveClosuresForCAP, FreydCategoriesForCAP, PresheafCategories, FiniteCocompletions

julia> # extracted from examples/FiniteStrictCoproductCompletionOfObjectFiniteCategory_Equalizer.g

julia> true
true

julia> T = TerminalCategoryWithSingleObject( )
TerminalCategoryWithSingleObject( )

julia> id_T = SetOfMorphisms( T )[1];

julia> UTm = FiniteStrictCoproductCompletionOfObjectFiniteCategory( T )
FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )

julia> x = PairGAP( BigInt(3), [ BigInt(3) ] ) / UTm
<An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> f_1 = MorphismConstructor(
                       x,
                       [ [ [ BigInt(0), BigInt(0), BigInt(0) ] ],
                         [ [ BigInt(1), BigInt(0), BigInt(2) ] ],
                         [ [ id_T, id_T, id_T ] ] ],
                       x )
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> f_2 = MorphismConstructor(
                       x,
                       [ [ [ BigInt(0), BigInt(0), BigInt(0) ] ],
                         [ [ BigInt(0), BigInt(2), BigInt(1) ] ],
                         [ [ id_T, id_T, id_T ] ] ],
                       x )
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> D = [ f_1, f_2 ];

julia> eq = Equalizer( D )
<An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> IsInitial( eq )
true

julia> i = EmbeddingOfEqualizer( x, D )
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> IsCongruentForMorphisms( i, UniversalMorphismFromInitialObject( x ) )
true

julia> x = PairGAP( BigInt(3), [ BigInt(3) ] ) / UTm
<An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> f_1 = MorphismConstructor(
                       x,
                       [ [ [ BigInt(0), BigInt(0), BigInt(0) ] ],
                         [ [ BigInt(1), BigInt(0), BigInt(2) ] ],
                         [ [ id_T, id_T, id_T ] ] ],
                       x )
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> f_2 = MorphismConstructor(
                       x,
                       [ [ [ BigInt(0), BigInt(0), BigInt(0) ] ],
                         [ [ BigInt(1), BigInt(0), BigInt(1) ] ],
                         [ [ id_T, id_T, id_T ] ] ],
                       x )
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> D = [ f_1, f_2 ];

julia> eq = Equalizer( D )
<An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> i = EmbeddingOfEqualizer( x, D )
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> TripleOfLists( i )[1]
1-element Vector{Vector{BigInt}}:
 [0, 0]

julia> TripleOfLists( i )[2]
1-element Vector{Vector{BigInt}}:
 [0, 1]

julia> t = [ BigInt(1), [ BigInt(1) ] ] / UTm
<An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> tau = MorphismConstructor( t, [ [ [ BigInt(0) ] ], [ [ BigInt(1) ] ], [ [ id_T ] ] ], x )
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> l = UniversalMorphismIntoEqualizer( x, D, t, tau )
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> TripleOfLists( l )[1]
1-element Vector{Vector{BigInt}}:
 [0]

julia> TripleOfLists( l )[2]
1-element Vector{Vector{BigInt}}:
 [1]

julia> PreCompose( l, i ) == tau
true

julia> x = [ BigInt(4), [ BigInt(4) ] ] / UTm
<An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> y = [ BigInt(3), [ BigInt(3) ] ] / UTm
<An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> f_1 = MorphismConstructor(
                       x,
                       [ [ [ BigInt(0), BigInt(0), BigInt(0), BigInt(0) ] ],
                         [ [ BigInt(0), BigInt(0), BigInt(1), BigInt(2) ] ],
                         [ [ id_T, id_T, id_T, id_T ] ] ],
                       y )
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> f_2 = MorphismConstructor(
                       x,
                       [ [ [ BigInt(0), BigInt(0), BigInt(0), BigInt(0) ] ],
                         [ [ BigInt(0), BigInt(0), BigInt(2), BigInt(2) ] ],
                         [ [ id_T, id_T, id_T, id_T ] ] ],
                       y )
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> f_3 = MorphismConstructor(
                       x,
                       [ [ [ BigInt(0), BigInt(0), BigInt(0), BigInt(0) ] ],
                         [ [ BigInt(0), BigInt(0), BigInt(0), BigInt(2) ] ],
                         [ [ id_T, id_T, id_T, id_T ] ] ],
                       y )
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> D = [ f_1, f_2, f_3 ];

julia> eq = Equalizer( D )
<An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> PairOfIntAndList( eq )
2-element Vector{Any}:
 3
  BigInt[3]

julia> i = EmbeddingOfEqualizer( x, D )
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> iD = List( D, m -> PreCompose( i, m ) );

julia> ForAll( iD, m -> IsCongruentForMorphisms( m, First( iD ) ) )
true

julia> t = [ BigInt(2), [ BigInt(2) ] ] / UTm
<An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> tau = MorphismConstructor(
                       t,
                       [ [ [ BigInt(0), BigInt(0) ] ],
                         [ [ BigInt(3), BigInt(1) ] ],
                         [ [ id_T, id_T ] ] ],
                       x )
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> l = UniversalMorphismIntoEqualizer( x, D, t, tau )
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory( TerminalCategoryWithSingleObject( ) )>

julia> TripleOfLists( l )[1]
1-element Vector{Vector{BigInt}}:
 [0, 0]

julia> TripleOfLists( l )[2]
1-element Vector{Vector{BigInt}}:
 [2, 1]

julia> PreCompose( l, i ) == tau
true

```
