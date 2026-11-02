```jldoctest AutoDocTests
julia> using CAP, MonoidalCategories, CartesianCategories, ToolsForCategoricalTowers, Toposes, FinSetsForCAP, QuotientCategories, LocalesForCAP, FpCategories, AdditiveClosuresForCAP, FreydCategoriesForCAP, PresheafCategories, FiniteCocompletions

julia> # extracted from examples/FiniteStrictCoproductCompletionOfObjectFiniteCategory.g

julia> true
true

julia> q = FinQuiver( "q(a,b,c)[m:a->b,n:b->c]" )
FinQuiver( "q(a,b,c)[m:a→b,n:b→c]" )

julia> P = PathCategory( q; skeletal = true )
PathCategory( FinQuiver( "q(a,b,c)[m:a→b,n:b→c]" ) )

julia> mUP = FiniteStrictCoproductCompletionOfObjectFiniteCategory( P )
FiniteStrictCoproductCompletionOfObjectFiniteCategory(
PathCategory( FinQuiver( "q(a,b,c)[m:a→b,n:b→c]" ) ) )

julia> a = mUP.a
<An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory(
 PathCategory( FinQuiver( "q(a,b,c)[m:a→b,n:b→c]" ) ) )>

julia> b = mUP.b
<An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory(
 PathCategory( FinQuiver( "q(a,b,c)[m:a→b,n:b→c]" ) ) )>

julia> c = mUP.c
<An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory(
 PathCategory( FinQuiver( "q(a,b,c)[m:a→b,n:b→c]" ) ) )>

julia> m = mUP.m
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory(
 PathCategory( FinQuiver( "q(a,b,c)[m:a→b,n:b→c]" ) ) )>

julia> n = mUP.n
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory(
 PathCategory( FinQuiver( "q(a,b,c)[m:a→b,n:b→c]" ) ) )>

julia> PreCompose( m, n )
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory(
 PathCategory( FinQuiver( "q(a,b,c)[m:a→b,n:b→c]" ) ) )>

julia> x = [ BigInt(3), [ BigInt(1), BigInt(2), BigInt(0) ] ] / mUP
<An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory(
 PathCategory( FinQuiver( "q(a,b,c)[m:a→b,n:b→c]" ) ) )>

julia> y = [ BigInt(6), [ BigInt(3), BigInt(2), BigInt(1) ] ] / mUP
<An object in FiniteStrictCoproductCompletionOfObjectFiniteCategory(
 PathCategory( FinQuiver( "q(a,b,c)[m:a→b,n:b→c]" ) ) )>

julia> ix = InjectionOfCofactorOfCoproduct( [ x, y ], 1 )
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory(
 PathCategory( FinQuiver( "q(a,b,c)[m:a→b,n:b→c]" ) ) )>

julia> iy = InjectionOfCofactorOfCoproduct( [ x, y ], 2 )
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory(
 PathCategory( FinQuiver( "q(a,b,c)[m:a→b,n:b→c]" ) ) )>

julia> u = UniversalMorphismFromCoproduct( [ ix, iy ] )
<A morphism in FiniteStrictCoproductCompletionOfObjectFiniteCategory(
 PathCategory( FinQuiver( "q(a,b,c)[m:a→b,n:b→c]" ) ) )>

julia> IsOne( u )
true

julia> IsWellDefined( u )
true

```
