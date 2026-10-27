

```jldoctest
julia> using CAP, CartesianCategories, MonoidalCategories, AdditiveClosuresForCAP, ToolsForCategoricalTowers, Toposes, LazyCategories


julia> true
true

julia> T = TerminalCategoryWithMultipleObjects();

julia> L = LazyCategory( T; primitive_operations = true, optimize = 0 );

julia> opposite = Opposite( L, "Opposite with all operations" );

julia> opposite_primitive = Opposite( L, "Opposite with primitive operations"; only_primitive_operations = true );


julia> a = "a" / T / L;

julia> b = "b" / T / L;


julia> MonoidalCategoriesTensorProductOnObjectsAndTensorUnitTest( L, opposite, a, b );

julia> MonoidalCategoriesTensorProductOnObjectsAndTensorUnitTest( L, opposite_primitive, a, b );


julia> z = ZeroObject( L );


julia> MonoidalCategoriesTensorProductOnObjectsAndTensorUnitTest( L, opposite, z, b );

julia> MonoidalCategoriesTensorProductOnObjectsAndTensorUnitTest( L, opposite_primitive, z, b );


julia> MonoidalCategoriesTensorProductOnObjectsAndTensorUnitTest( L, opposite, a, z );

julia> MonoidalCategoriesTensorProductOnObjectsAndTensorUnitTest( L, opposite_primitive, a, z );


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


julia> MonoidalCategoriesTest( L, opposite, a, b, c, alpha, beta );

julia> MonoidalCategoriesTest( L, opposite_primitive, a, b, c, alpha, beta );


julia> z = ZeroObject( L );


julia> alpha = UniversalMorphismFromZeroObject( a );

julia> beta = UniversalMorphismIntoZeroObject( a );


julia> MonoidalCategoriesTest( L, opposite, z, a, a, alpha, beta );

julia> MonoidalCategoriesTest( L, opposite_primitive, z, a, a, alpha, beta );


julia> MonoidalCategoriesTest( L, opposite, a, z, z, beta, alpha );

julia> MonoidalCategoriesTest( L, opposite_primitive, a, z, z, beta, alpha );


julia> a = "a" / T / L;

julia> l = [ "b" / T / L, "c" / T / L, "d" / T / L ];

julia> M = [ 3, 2, 4 ];


julia> AdditiveMonoidalCategoriesTest( L, opposite_primitive, a, l, M );

julia> AdditiveMonoidalCategoriesTest( L, opposite, a, l, M );


julia> a = "a" / T / L;

julia> b = "b" / T / L;


julia> BraidedMonoidalCategoriesTest( L, opposite, a, b );

julia> BraidedMonoidalCategoriesTest( L, opposite_primitive, a, b );


julia> BraidedMonoidalCategoriesTest( L, opposite, b, a );

julia> BraidedMonoidalCategoriesTest( L, opposite_primitive, b, a );


julia> z = ZeroObject( L );


julia> BraidedMonoidalCategoriesTest( L, opposite, z, a );

julia> BraidedMonoidalCategoriesTest( L, opposite_primitive, z, a );


julia> BraidedMonoidalCategoriesTest( L, opposite, a, z );

julia> BraidedMonoidalCategoriesTest( L, opposite_primitive, a, z );


julia> aT = "a" / T;

julia> bT = "b" / T;

julia> cT = "c" / T;

julia> dT = "d" / T;


julia> a = aT / L;

julia> b = bT / L;

julia> c = cT / L;

julia> d = dT / L;


julia> uT = TensorUnit( T );


julia> a_product_bT = TensorProduct( aT, bT );

julia> c_product_dT = TensorProduct( cT, dT );


julia> hom_abT = InternalHom( aT, bT );

julia> hom_cdT = InternalHom( cT, dT );


julia> alphaT = MorphismConstructor( aT, "f_ab", bT );

julia> betaT = MorphismConstructor( cT, "f_cd", dT );

julia> gammaT = MorphismConstructor( a_product_bT, "f_abu", uT );

julia> deltaT = MorphismConstructor( c_product_dT, "f_cdu", uT );

julia> epsilonT = MorphismConstructor( uT, "f_uhomab", hom_abT );

julia> zetaT = MorphismConstructor( uT, "f_uhomcd", hom_cdT );


julia> alpha = AsMorphismInLazyCategory( a, alphaT, b );

julia> beta = AsMorphismInLazyCategory( c, betaT, d );

julia> gamma = AsMorphismInLazyCategory( TensorProduct( a, b ), gammaT, TensorUnit( L ) );

julia> delta = AsMorphismInLazyCategory( TensorProduct( c, d ), deltaT, TensorUnit( L ) );

julia> epsilon = AsMorphismInLazyCategory( TensorUnit( L ), epsilonT, InternalHom( a, b ) );

julia> zeta = AsMorphismInLazyCategory( TensorUnit( L ), zetaT, InternalHom( c, d ) );


julia> ClosedMonoidalCategoriesTest( L, opposite, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta );

julia> ClosedMonoidalCategoriesTest( L, opposite_primitive, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta );


julia> zT = ZeroObject( T );

julia> z = zT / L;


julia> z_product_aT = TensorProduct( zT, aT );

julia> a_product_zT = TensorProduct( aT, zT );


julia> hom_zaT = InternalHom( zT, aT );

julia> hom_azT = InternalHom( aT, zT );


julia> alphaT = MorphismConstructor( zT, "f_za", aT );

julia> betaT = MorphismConstructor( aT, "f_az", zT );

julia> gammaT = MorphismConstructor( z_product_aT, "f_zau", uT );

julia> deltaT = MorphismConstructor( a_product_zT, "f_azu", uT );

julia> epsilonT = MorphismConstructor( uT, "f_uhomza", hom_zaT );

julia> zetaT = MorphismConstructor( uT, "f_uhomaz", hom_azT );


julia> alpha = AsMorphismInLazyCategory( z, alphaT, a );

julia> beta = AsMorphismInLazyCategory( a, betaT, z );

julia> gamma = AsMorphismInLazyCategory( TensorProduct( z, a ), gammaT, TensorUnit( L ) );

julia> delta = AsMorphismInLazyCategory( TensorProduct( a, z ), deltaT, TensorUnit( L ) );

julia> epsilon = AsMorphismInLazyCategory( TensorUnit( L ), epsilonT, InternalHom( z, a ) );

julia> zeta = AsMorphismInLazyCategory( TensorUnit( L ), zetaT, InternalHom( a, z ) );


julia> ClosedMonoidalCategoriesTest( L, opposite, z, a, a, z, alpha, beta, gamma, delta, epsilon, zeta );

julia> ClosedMonoidalCategoriesTest( L, opposite_primitive, z, a, a, z, alpha, beta, gamma, delta, epsilon, zeta );


julia> aT = "a" / T;

julia> bT = "b" / T;

julia> cT = "c" / T;

julia> dT = "d" / T;


julia> a = aT / L;

julia> b = bT / L;

julia> c = cT / L;

julia> d = dT / L;


julia> uT = TensorUnit( T );


julia> a_product_bT = TensorProduct( aT, bT );

julia> c_product_dT = TensorProduct( cT, dT );


julia> cohom_abT = InternalCoHom( aT, bT );

julia> cohom_cdT = InternalCoHom( cT, dT );


julia> alphaT = MorphismConstructor( aT, "f_ab", bT );

julia> betaT = MorphismConstructor( cT, "f_cd", dT );

julia> gammaT = MorphismConstructor( uT, "f_uab", a_product_bT );

julia> deltaT = MorphismConstructor( uT, "f_ucd", c_product_dT );

julia> epsilonT = MorphismConstructor( cohom_abT, "f_cohomabu", uT );

julia> zetaT = MorphismConstructor( cohom_cdT, "f_cohomcdu", uT);


julia> alpha = AsMorphismInLazyCategory( a, alphaT, b );

julia> beta = AsMorphismInLazyCategory( c, betaT, d );

julia> gamma = AsMorphismInLazyCategory( TensorUnit( L ), gammaT, TensorProduct( a, b ) );

julia> delta = AsMorphismInLazyCategory( TensorUnit( L ), deltaT, TensorProduct( c, d ) );

julia> epsilon = AsMorphismInLazyCategory( InternalCoHom( a, b ), epsilonT, TensorUnit( L ) );

julia> zeta = AsMorphismInLazyCategory( InternalCoHom( c, d ), zetaT, TensorUnit( L ) );


julia> CoclosedMonoidalCategoriesTest( L, opposite, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta );

julia> CoclosedMonoidalCategoriesTest( L, opposite_primitive, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta );


julia> zT = ZeroObject( T );

julia> z = zT / L;


julia> z_product_aT = TensorProduct( zT, aT );

julia> a_product_zT = TensorProduct( aT, zT );


julia> cohom_zaT = InternalCoHom( zT, aT );

julia> cohom_azT = InternalCoHom( aT, zT );


julia> alphaT = MorphismConstructor( zT, "f_za", aT );

julia> betaT = MorphismConstructor( aT, "f_az", zT );

julia> gammaT = MorphismConstructor( uT, "f_uza", z_product_aT );

julia> deltaT = MorphismConstructor( uT, "f_uaz", a_product_zT );

julia> epsilonT = MorphismConstructor( cohom_zaT, "f_cohomzau", uT );

julia> zetaT = MorphismConstructor( cohom_azT, "cohomazu", uT );


julia> alpha = AsMorphismInLazyCategory( z, alphaT, a );

julia> beta = AsMorphismInLazyCategory( a, betaT, z );

julia> gamma = AsMorphismInLazyCategory( TensorUnit( L ), gammaT, TensorProduct( z, a ) );

julia> delta = AsMorphismInLazyCategory( TensorUnit( L ), deltaT, TensorProduct( a, z ) );

julia> epsilon = AsMorphismInLazyCategory( InternalCoHom( z, a ), epsilonT, TensorUnit( L ) );

julia> zeta = AsMorphismInLazyCategory( InternalCoHom( a, z ), zetaT, TensorUnit( L ) );


julia> CoclosedMonoidalCategoriesTest( L, opposite, z, a, a, z, alpha, beta, gamma, delta, epsilon, zeta );

julia> CoclosedMonoidalCategoriesTest( L, opposite_primitive, z, a, a, z, alpha, beta, gamma, delta, epsilon, zeta );


julia> a = "a" / T / L;

julia> b = "b" / T / L;

julia> c = "c" / T / L;

julia> d = "d" / T / L;


julia> alpha = IdentityMorphism( a );


julia> RigidSymmetricClosedMonoidalCategoriesTest( L, opposite, a, b, c, d, alpha );

julia> RigidSymmetricClosedMonoidalCategoriesTest( L, opposite_primitive, a, b, c, d, alpha );


julia> z = ZeroObject( L );


julia> alpha = IdentityMorphism( a );


julia> RigidSymmetricClosedMonoidalCategoriesTest( L, opposite, z, b, c, z, alpha );

julia> RigidSymmetricClosedMonoidalCategoriesTest( L, opposite_primitive, z, b, c, z, alpha );


julia> a = "a" / T / L;

julia> b = "b" / T / L;

julia> c = "c" / T / L;

julia> d = "d" / T / L;


julia> alpha = IdentityMorphism( a );


julia> RigidSymmetricCoclosedMonoidalCategoriesTest( L, opposite, a, b, c, d, alpha );

julia> RigidSymmetricCoclosedMonoidalCategoriesTest( L, opposite_primitive, a, b, c, d, alpha );


julia> z = ZeroObject( L );


julia> alpha = IdentityMorphism( a );


julia> RigidSymmetricCoclosedMonoidalCategoriesTest( L, opposite, a, b, c, d, alpha );

julia> RigidSymmetricCoclosedMonoidalCategoriesTest( L, opposite_primitive, a, b, c, d, alpha );


```
