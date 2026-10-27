

```jldoctest
julia> using CAP, CartesianCategories, MonoidalCategories, AdditiveClosuresForCAP, ToolsForCategoricalTowers, Toposes, LazyCategories


julia> true
true

julia> true
true

julia> T = TerminalCategoryWithMultipleObjects();

julia> L = LazyCategory( T; primitive_operations = true, optimize = 0 );

julia> opposite = Opposite( L, "Opposite with all operations" );

julia> opposite_primitive = Opposite( L, "Opposite with primitive operations"; only_primitive_operations = true );


julia> aT = "a" / T;

julia> bT = "b" / T;

julia> cT = "c" / T;

julia> dT = "d" / T;


julia> a = aT / L;

julia> b = bT / L;

julia> c = cT / L;

julia> d = dT / L;


julia> alpha = MorphismConstructor( aT, "f_ab", bT ) / L;

julia> beta = MorphismConstructor( cT, "f_cd", dT ) / L;


julia> CartesianCategoriesTest( L, opposite, a, b, c, alpha, beta );

julia> CartesianCategoriesTest( L, opposite_primitive, a, b, c, alpha, beta );


julia> z = ZeroObject( L );


julia> alpha = UniversalMorphismFromZeroObject( a );

julia> beta = UniversalMorphismIntoZeroObject( a );


julia> CartesianCategoriesTest( L, opposite, z, a, a, alpha, beta );

julia> CartesianCategoriesTest( L, opposite_primitive, z, a, a, alpha, beta );


julia> CartesianCategoriesTest( L, opposite, a, z, z, beta, alpha );

julia> CartesianCategoriesTest( L, opposite_primitive, a, z, z, beta, alpha );


julia> a = "a" / T;

julia> b = "b" / T;

julia> c = "c" / T;

julia> d = "d" / T;


julia> a = aT / L;

julia> b = bT / L;

julia> c = cT / L;

julia> d = dT / L;


julia> alpha = MorphismConstructor( aT, "f_ab", bT ) / L;

julia> beta = MorphismConstructor( cT, "f_cd", dT ) / L;


julia> CocartesianCategoriesTest( L, opposite, a, b, c, alpha, beta );

julia> CocartesianCategoriesTest( L, opposite_primitive, a, b, c, alpha, beta );


julia> z = ZeroObject( L );


julia> alpha = UniversalMorphismFromZeroObject( a );

julia> beta = UniversalMorphismIntoZeroObject( a );


julia> CocartesianCategoriesTest( L, opposite, z, a, a, alpha, beta );

julia> CocartesianCategoriesTest( L, opposite_primitive, z, a, a, alpha, beta );


julia> CocartesianCategoriesTest( L, opposite, a, z, z, beta, alpha );

julia> CocartesianCategoriesTest( L, opposite_primitive, a, z, z, beta, alpha );


julia> aT = "a" / T;

julia> bT = "b" / T;


julia> a = aT / L;

julia> b = bT / L;


julia> BraidedCartesianCategoriesTest( L, opposite, a, b );

julia> BraidedCartesianCategoriesTest( L, opposite_primitive, a, b );


julia> BraidedCartesianCategoriesTest( L, opposite, b, a );

julia> BraidedCartesianCategoriesTest( L, opposite_primitive, b, a );


julia> z = ZeroObject( L );


julia> BraidedCartesianCategoriesTest( L, opposite, z, a );

julia> BraidedCartesianCategoriesTest( L, opposite_primitive, z, a );


julia> BraidedCartesianCategoriesTest( L, opposite, a, z );

julia> BraidedCartesianCategoriesTest( L, opposite_primitive, a, z );


julia> a = "a" / T / L;

julia> l = [ "b" / T / L, "c" / T / L, "d" / T / L ];

julia> M = [ 3, 2, 4 ];


julia> CodistributiveCocartesianCategoriesTest( L, opposite_primitive, a, l, M );

julia> CodistributiveCocartesianCategoriesTest( L, opposite, a, l, M );


julia> a = "a" / T / L;

julia> l = [ "b" / T / L, "c" / T / L, "d" / T / L ];

julia> M = [ 3, 2, 4 ];


julia> DistributiveCartesianCategoriesTest( L, opposite_primitive, a, l, M );

julia> DistributiveCartesianCategoriesTest( L, opposite, a, l, M );


julia> aT = "a" / T;

julia> bT = "b" / T;


julia> a = aT / L;

julia> b = bT / L;


julia> BraidedCocartesianCategoriesTest( L, opposite, a, b );

julia> BraidedCocartesianCategoriesTest( L, opposite_primitive, a, b );


julia> BraidedCocartesianCategoriesTest( L, opposite, b, a );

julia> BraidedCocartesianCategoriesTest( L, opposite_primitive, b, a );


julia> z = ZeroObject( L );


julia> BraidedCocartesianCategoriesTest( L, opposite, z, a );

julia> BraidedCocartesianCategoriesTest( L, opposite_primitive, z, a );


julia> BraidedCocartesianCategoriesTest( L, opposite, a, z );

julia> BraidedCocartesianCategoriesTest( L, opposite_primitive, a, z );


julia> a = "a" / T;

julia> b = "b" / T;

julia> c = "c" / T;

julia> d = "d" / T;


julia> a = aT / L;

julia> b = bT / L;

julia> c = cT / L;

julia> d = dT / L;


julia> tT = TerminalObject( T );


julia> a_product_bT = DirectProduct( aT, bT );

julia> c_product_dT = DirectProduct( cT, dT );


julia> exp_abT = Exponential( aT, bT );

julia> exp_cdT = Exponential( cT, dT );


julia> alphaT = MorphismConstructor( aT, "f_ab", bT );

julia> betaT = MorphismConstructor( cT, "f_cd", dT );

julia> gammaT = MorphismConstructor( a_product_bT, "f_abt", tT );

julia> deltaT = MorphismConstructor( c_product_dT, "f_cdt", tT );

julia> epsilonT = MorphismConstructor( tT, "f_texpab", exp_abT );

julia> zetaT = MorphismConstructor( tT, "f_texpcd", exp_cdT );


julia> alpha = AsMorphismInLazyCategory( a, alphaT, b );

julia> beta = AsMorphismInLazyCategory( c, betaT, d );

julia> gamma = AsMorphismInLazyCategory( DirectProduct( a, b ), gammaT, TerminalObject( L ) );

julia> delta = AsMorphismInLazyCategory( DirectProduct( c, d ), deltaT, TerminalObject( L ) );

julia> epsilon = AsMorphismInLazyCategory( TerminalObject( L ), epsilonT, Exponential( a, b ) );

julia> zeta = AsMorphismInLazyCategory( TerminalObject( L ), zetaT, Exponential( c, d ) );


julia> CartesianClosedCategoriesTest( L, opposite, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta );

julia> CartesianClosedCategoriesTest( L, opposite_primitive, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta );


julia> zT = ZeroObject( T );

julia> z = zT / L;


julia> z_product_aT = DirectProduct( zT, aT );

julia> a_product_zT = DirectProduct( aT, zT );


julia> exp_zaT = Exponential( zT, aT );

julia> exp_azT = Exponential( aT, zT );


julia> alphaT = MorphismConstructor( zT, "f_za", aT );

julia> betaT = MorphismConstructor( aT, "f_az", zT );

julia> gammaT = MorphismConstructor( z_product_aT, "f_zat", tT );

julia> deltaT = MorphismConstructor( a_product_zT, "f_azt", tT );

julia> epsilonT = MorphismConstructor( tT, "f_texpza", exp_zaT );

julia> zetaT = MorphismConstructor( tT, "f_texpaz", exp_azT );


julia> alpha = AsMorphismInLazyCategory( z, alphaT, a );

julia> beta = AsMorphismInLazyCategory( a, betaT, z );

julia> gamma = AsMorphismInLazyCategory( DirectProduct( z, a ), gammaT, TerminalObject( L ) );

julia> delta = AsMorphismInLazyCategory( DirectProduct( a, z ), deltaT, TerminalObject( L ) );

julia> epsilon = AsMorphismInLazyCategory( TerminalObject( L ), epsilonT, Exponential( z, a ) );

julia> zeta = AsMorphismInLazyCategory( TerminalObject( L ), zetaT, Exponential( a, z ) );


julia> CartesianClosedCategoriesTest( L, opposite, z, a, a, z, alpha, beta, gamma, delta, epsilon, zeta );

julia> CartesianClosedCategoriesTest( L, opposite_primitive, z, a, a, z, alpha, beta, gamma, delta, epsilon, zeta );


julia> a = "a" / T;

julia> b = "b" / T;

julia> c = "c" / T;

julia> d = "d" / T;


julia> a = aT / L;

julia> b = bT / L;

julia> c = cT / L;

julia> d = dT / L;


julia> iT = InitialObject( T );


julia> a_product_bT = Coproduct( aT, bT );

julia> c_product_dT = Coproduct( cT, dT );


julia> coexp_abT = Coexponential( aT, bT );

julia> coexp_cdT = Coexponential( cT, dT );


julia> alphaT = MorphismConstructor( aT, "f_ab", bT );

julia> betaT = MorphismConstructor( cT, "f_cd", dT );

julia> gammaT = MorphismConstructor( iT, "f_iab", a_product_bT );

julia> deltaT = MorphismConstructor( iT, "f_icd", c_product_dT );

julia> epsilonT = MorphismConstructor( coexp_abT, "f_coexpabi", iT );

julia> zetaT = MorphismConstructor( coexp_cdT, "f_coexpcdi", iT );


julia> alpha = AsMorphismInLazyCategory( a, alphaT, b );

julia> beta = AsMorphismInLazyCategory( c, betaT, d );

julia> gamma = AsMorphismInLazyCategory( InitialObject( L ), gammaT, Coproduct( a, b ) );

julia> delta = AsMorphismInLazyCategory( InitialObject( L ), deltaT, Coproduct( c, d ) );

julia> epsilon = AsMorphismInLazyCategory( Coexponential( a, b ), epsilonT, InitialObject( L ) );

julia> zeta = AsMorphismInLazyCategory( Coexponential( c, d ), zetaT, InitialObject( L ) );


julia> CocartesianCoclosedCategoriesTest( L, opposite, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta );

julia> CocartesianCoclosedCategoriesTest( L, opposite_primitive, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta );


julia> zT = ZeroObject( T );

julia> z = zT / L;


julia> z_product_aT = Coproduct( zT, aT );

julia> a_product_zT = Coproduct( aT, zT );


julia> coexp_zaT = Coexponential( zT, aT );

julia> coexp_azT = Coexponential( aT, zT );


julia> alphaT = MorphismConstructor( zT, "f_za", aT );

julia> betaT = MorphismConstructor( aT, "f_az", zT );

julia> gammaT = MorphismConstructor( iT, "f_iza", z_product_aT );

julia> deltaT = MorphismConstructor( iT, "f_iaz", a_product_zT );

julia> epsilonT = MorphismConstructor( coexp_zaT, "f_coexpzai", iT );

julia> zetaT = MorphismConstructor( coexp_azT, "coexpazi", iT );


julia> alpha = AsMorphismInLazyCategory( z, alphaT, a );

julia> beta = AsMorphismInLazyCategory( a, betaT, z );

julia> gamma = AsMorphismInLazyCategory( InitialObject( L ), gammaT, Coproduct( z, a ) );

julia> delta = AsMorphismInLazyCategory( InitialObject( L ), deltaT, Coproduct( a, z ) );

julia> epsilon = AsMorphismInLazyCategory( Coexponential( z, a ), epsilonT, InitialObject( L ) );

julia> zeta = AsMorphismInLazyCategory( Coexponential( a, z ), zetaT, InitialObject( L ) );


julia> CocartesianCoclosedCategoriesTest( L, opposite, z, a, a, z, alpha, beta, gamma, delta, epsilon, zeta );

julia> CocartesianCoclosedCategoriesTest( L, opposite_primitive, z, a, a, z, alpha, beta, gamma, delta, epsilon, zeta );


```
