# SPDX-License-Identifier: GPL-2.0-or-later
# FiniteCocompletions: Finite (co)product/(co)limit (co)completions
#
# Implementations
#

##
@InstallMethod( FiniteStrictCoproductCompletion,
        "for a CAP category",
        [ IsCapCategory ],
        
  @FunctionWithNamedArguments(
  [
    [ "no_precompiled_code", false ],
    [ "FinalizeCategory", true ],
  ],
  function( CAP_NAMED_ARGUMENTS, C )
    local name, category_filter, category_object_filter, category_morphism_filter,
          object_datum_type, morphism_datum_type,
          UC, H,
          object_func, morphism_func, object_func_inverse, morphism_func_inverse, extended;
    
    name = @Concatenation( "FiniteStrictCoproductCompletion( ", Name( C ), " )" );
    
    ##
    category_filter = IsFiniteStrictCoproductCompletion;
    category_object_filter = IsObjectInFiniteStrictCoproductCompletion;
    category_morphism_filter = IsMorphismInFiniteStrictCoproductCompletion;
    
    ##
    object_datum_type =
      CapJitDataTypeOfNTupleOf( 2,
              IsBigInt,
              CapJitDataTypeOfListOf( CapJitDataTypeOfObjectOfCategory( C ) ) );
    
    ##
    morphism_datum_type =
      CapJitDataTypeOfNTupleOf( 2,
              CapJitDataTypeOfListOf( IsBigInt ),
              CapJitDataTypeOfListOf( CapJitDataTypeOfMorphismOfCategory( C ) ) );
    
    ##
    UC =
      CreateCapCategoryWithDataTypes(
              name,
              category_filter,
              category_object_filter,
              category_morphism_filter,
              IsCapCategoryTwoCell,
              object_datum_type,
              morphism_datum_type,
              fail );
    
    ## UC supports empty limits, regardless of C
    UC.supports_empty_limits = true;
    
    ##
    UC.compiler_hints =
      @rec( category_attribute_names =
           [ "UnderlyingCategory",
             ],
           );
    
    ##
    SetUnderlyingCategory( UC, C );
    
    SetIsCocartesianCategory( UC, true );
    
    SetIsStrictCocartesianCategory( UC, true );
    
    if (HasIsCartesianCategory( C ) && IsCartesianCategory( C ))
        if (HasIsStrictCartesianCategory( C ) && IsStrictCartesianCategory( C ))
            SetIsStrictCartesianCategory( UC, true );
        end;
        SetIsDistributiveCategory( UC, true );
    end;
    
    if (HasIsFiniteCompleteCategory( C ) && IsFiniteCompleteCategory( C ))
        
        SetIsFiniteCompleteCategory( UC, true );
        
    end;
    
    if (HasRangeCategoryOfHomomorphismStructure( C ))
        
        H = RangeCategoryOfHomomorphismStructure( C );
        
        if (IsIntervalCategory( H ))
            
            SetIsThinCategory( UC, true );
            SetIsCategoryWithDecidableColifts( UC, true );
            
            if (HasIsEquivalentToFiniteCategory( C ) && IsEquivalentToFiniteCategory( C ))
                SetIsEquivalentToFiniteCategory( UC, true );
            end;
            
        end;
        
    end;
    
    ##
    AddObjectConstructor( UC,
      function ( UC, pair_of_int_and_list )
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        @Assert( 0,
                IsBigInt( pair_of_int_and_list[1] ) &&
                pair_of_int_and_list[1] == Length( pair_of_int_and_list[2] ) &&
                ForAll( pair_of_int_and_list[2], obj -> IsCapCategoryObject( obj ) && IsIdenticalObj( UnderlyingCategory( UC ), CapCategory( obj ) ) ) );
        
        return CreateCapCategoryObjectWithAttributes( UC,
                       PairOfIntAndList, pair_of_int_and_list );
        
    end );
    
    ##
    AddObjectDatum( UC,
      function ( UC, object )
        
        return PairOfIntAndList( object );
        
    end );
    
    ##
    AddMorphismConstructor( UC,
      function ( UC, S, pair_of_lists, T )
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        @Assert( 0, IsList( pair_of_lists ) &&
                Length( pair_of_lists ) == 2 &&
                IsList( pair_of_lists[1] ) &&
                IsList( pair_of_lists[2] ) );
        
        return CreateCapCategoryMorphismWithAttributes( UC,
                       S,
                       T,
                       PairOfLists, pair_of_lists );
        
    end );
    
    ##
    AddMorphismDatum( UC,
      function ( UC, morphism )
        
        return PairOfLists( morphism );
        
    end );
    
    if (CanCompute( C, "IsWellDefinedForObjects" ))
        
        ##
        AddIsWellDefinedForObjects( UC,
          function ( UC, object )
            local pair, C;
            
            pair = PairOfIntAndList( object );
            
            C = UnderlyingCategory( UC );
            
            return IsBigInt( pair[1] ) &&
                   pair[1] >= 0 &&
                   Length( pair[2] ) == pair[1] &&
                   ForAll( pair[2], obj -> IsWellDefinedForObjects( C, obj ) );
            
        end, OperationWeight( C, "IsWellDefinedForObjects" ) );
        
    end;
    
    if (CanCompute( C, "IsEqualForObjects" ) &&
       CanCompute( C, "IsWellDefinedForMorphisms" ))
        
        ##
        AddIsWellDefinedForMorphisms( UC,
          function ( UC, morphism )
            local source_pair, target_pair, pair_of_lists, s, t, map, C, S, T, mors;
            
            source_pair = PairOfIntAndList( Source( morphism ) );
            target_pair = PairOfIntAndList( Target( morphism ) );
            
            pair_of_lists = PairOfLists( morphism );
            
            ## SkeletalFinSets code:
            s = source_pair[1];
            t = target_pair[1];
            
            map = pair_of_lists[1];
            
            ## FiniteStrictCoproductCompletion code:
            C = UnderlyingCategory( UC );
            
            S = source_pair[2];
            T = target_pair[2];
            
            mors = pair_of_lists[2];
            
            return s == Length( map ) &&
                   s == Length( mors ) &&
                   ForAll( (1):(s), i -> map[i] >= 0 && map[i] < t ) &&
                   ForAll( (1):(s), i ->
                           IsEqualForObjects( C, Source( mors[i] ), S[i] ) &&
                           IsEqualForObjects( C, Target( mors[i] ), T[1 + map[i]] ) &&
                           IsWellDefinedForMorphisms( C, mors[i] ) );
            
        end, 4 * OperationWeight( C, "IsEqualForObjects" ) + 2 * OperationWeight( C, "IsWellDefinedForMorphisms" ) );
        
    end;
    
    if (CanCompute( C, "IsEqualForObjects" ))
        
        ##
        AddIsEqualForObjects( UC,
          function ( UC, object1, object2 )
            local pair1, pair2, C, L1, L2;
            
            pair1 = PairOfIntAndList( object1 );
            pair2 = PairOfIntAndList( object2 );
            
            ## SkeletalFinSets code:
            if (@not pair1[1] == pair2[1])
                return false;
            end;
            
            ## FiniteStrictCoproductCompletion code:
            C = UnderlyingCategory( UC );
            
            L1 = pair1[2];
            L2 = pair2[2];
            
            return ForAll( (1):(pair1[1]), i -> IsEqualForObjects( C, L1[i], L2[i] ) );
            
        end, 2 * OperationWeight( C, "IsEqualForObjects" ) );
        
    end;
    
    if (CanCompute( C, "IsEqualForMorphisms" ))
        
        ##
        AddIsEqualForMorphisms( UC,
          function ( UC, morphism1, morphism2 )
            local pair_of_lists1, pair_of_lists2, C, s, m1, m2;
            
            pair_of_lists1 = PairOfLists( morphism1 );
            pair_of_lists2 = PairOfLists( morphism2 );
            
            ## SkeletalFinSets code:
            if (@not pair_of_lists1[1] == pair_of_lists2[1])
                return false;
            end;
            
            ## FiniteStrictCoproductCompletion code:
            C = UnderlyingCategory( UC );
            
            s = PairOfIntAndList( Source( morphism1 ) )[1];
            
            m1 = pair_of_lists1[2];
            m2 = pair_of_lists2[2];
            
            return ForAll( (1):(s), i -> IsEqualForMorphisms( C, m1[i], m2[i] ) );
            
        end, 2 * OperationWeight( C, "IsEqualForMorphisms" ) );
        
    end;
    
    if (!( HasRangeCategoryOfHomomorphismStructure( C ) && IsIntervalCategory( H ) ))
        
        ##
        AddIsCongruentForMorphisms( UC,
          function ( UC, morphism1, morphism2 )
            local pair_of_lists1, pair_of_lists2, C, s, m1, m2;
            
            pair_of_lists1 = PairOfLists( morphism1 );
            pair_of_lists2 = PairOfLists( morphism2 );
            
            ## SkeletalFinSets code:
            if (@not pair_of_lists1[1] == pair_of_lists2[1])
                return false;
            end;
            
            ## FiniteStrictCoproductCompletion code:
            C = UnderlyingCategory( UC );
            
            s = PairOfIntAndList( Source( morphism1 ) )[1];
            
            m1 = pair_of_lists1[2];
            m2 = pair_of_lists2[2];
            
            return ForAll( (1):(s), i -> IsCongruentForMorphisms( C, m1[i], m2[i] ) );

        end );
        #end, 2 * OperationWeight( C, "IsCongruentForMorphisms" ) );
        
    end;
    
    if (CanCompute( C, "IdentityMorphism" ))
        
        ##
        AddIdentityMorphism( UC,
          function ( UC, object )
            local pair, map, C, mor;
            
            pair = PairOfIntAndList( object );
            
            ## SkeletalFinSets code:
            map = (0):(pair[1] - 1);
            
            ## FiniteStrictCoproductCompletion code:
            C = UnderlyingCategory( UC );
            
            mor = List( pair[2], objC -> IdentityMorphism( C, objC ) );
            
            return MorphismConstructor( UC, object, PairGAP( map, mor ), object );
            
        end, 2 * OperationWeight( C, "IdentityMorphism" ) );
        
    end;

    if (CanCompute( C, "PreCompose" ))
        
        ##
        AddPreCompose( UC,
          function ( UC, pre_morphism, post_morphism )
            local S, T, pair_of_lists_pre, pair_of_lists_post,
                  maps_pre, maps_post, s, maps_cmp,
                  C, mors_pre, mors_post, mors_cmp;
            
            S = Source( pre_morphism );
            T = Target( post_morphism );
            
            pair_of_lists_pre = PairOfLists( pre_morphism );
            pair_of_lists_post = PairOfLists( post_morphism );
            
            ## SkeletalFinSets code:
            maps_pre = pair_of_lists_pre[1];
            maps_post = pair_of_lists_post[1];
            
            s = (0):(PairOfIntAndList( S )[1] - 1);
            
            maps_cmp = List( s, i ->
                              maps_post[1 + maps_pre[1 + i]] );
            
            ## FiniteStrictCoproductCompletion code:
            C = UnderlyingCategory( UC );
            
            mors_pre = pair_of_lists_pre[2];
            mors_post = pair_of_lists_post[2];
            
            mors_cmp = List( s, i ->
                              PreCompose( C,
                                      mors_pre[1 + i],
                                      mors_post[1 + maps_pre[1 + i]] ) );
            
            return MorphismConstructor( UC, S, PairGAP( maps_cmp, mors_cmp ), T );
            
        end, 2 * OperationWeight( C, "PreCompose" ) );
        
    end;
    
    if (!( HasRangeCategoryOfHomomorphismStructure( C ) && IsIntervalCategory( H ) ))
        
        if (CanCompute( C, "IsMonomorphism" ))
            
            ##
            AddIsMonomorphism( UC,
              function ( UC, morphism )
                local source_pair, target_pair, pair_of_lists, s, t, map, C, mors;
                
                source_pair = PairOfIntAndList( Source( morphism ) );
                target_pair = PairOfIntAndList( Target( morphism ) );
                
                pair_of_lists = PairOfLists( morphism );
                
                ## SkeletalFinSets code:
                s = source_pair[1];
                t = target_pair[1];
                
                map = pair_of_lists[1];
                
                ## FiniteStrictCoproductCompletion code:
                C = UnderlyingCategory( UC );
                
                mors = pair_of_lists[2];
                
                return SKELETAL_CATEGORY_OF_FINITE_SETS_IsMonomorphism( map, t ) &&
                       ForAll( (1):(s), i -> IsMonomorphism( C, mors[i] ) );
                
            end, 2 * OperationWeight( C, "IsMonomorphism" ) );
            
        end;
        
        if (CanCompute( C, "IsLiftable" ))
            
            ## is β liftable along α?
            AddIsLiftable( UC,
              function ( UC, beta, alpha )
                local C, alpha_datum, beta_datum, alpha_map, beta_map, alpha_mor, beta_mor, is_liftable, S, s;
                
                C = UnderlyingCategory( UC );
                
                alpha_datum = PairOfLists( alpha );
                beta_datum = PairOfLists( beta );
                
                alpha_map = alpha_datum[1];
                beta_map = beta_datum[1];
                
                alpha_mor = alpha_datum[2];
                beta_mor = beta_datum[2];
                
                is_liftable =
                  function ( b )
                    local beta_b, fiber_of_beta_b_along_alpha;
                    
                    beta_b = beta_map[1 + b];
                    
                    fiber_of_beta_b_along_alpha = Positions( alpha_map, beta_b );
                    
                    ## note: ForAny( [ ], func ) == false
                    return ForAny( fiber_of_beta_b_along_alpha, a -> IsLiftable( C, beta_mor[1 + b], alpha_mor[a] ) );
                    
                end;
                
                S = Source( beta );
                
                s = PairOfIntAndList( S )[1];
                
                return ForAll( (0):(s - 1), b -> is_liftable( b ) );
                
            end );
            #end, 2 * OperationWeight( C, "IsLiftable" ) ); ## for this to work add OperationWeight in Hom-structure
            
        end;
        
        if (CanCompute( C, "IsLiftable" ) &&
           CanCompute( C, "Lift" ))
            
            SetIsCategoryWithDecidableLifts( UC, true );
            
            ## the lift χ of β along α, i.e., χ α == β
            AddLift( UC,
              function ( UC, beta, alpha )
                local C, alpha_datum, beta_datum, alpha_map, beta_map,
                      alpha_mor, beta_mor, chi, map, mor, S, T, s;
                
                C = UnderlyingCategory( UC );
                
                alpha_datum = PairOfLists( alpha );
                beta_datum = PairOfLists( beta );
                
                alpha_map = alpha_datum[1];
                beta_map = beta_datum[1];
                
                alpha_mor = alpha_datum[2];
                beta_mor = beta_datum[2];
                
                chi =
                  function ( b )
                    local beta_b, fiber_of_beta_b_along_alpha, a;
                    
                    beta_b = beta_map[1 + b];
                    
                    fiber_of_beta_b_along_alpha = Positions( alpha_map, beta_b );
                    
                    return -1 + BigInt( SafeFirst( fiber_of_beta_b_along_alpha, a -> IsLiftable( C, beta_mor[1 + b], alpha_mor[a] ) ) );
                    
                end;
                
                S = Source( beta );
                T = Source( alpha );
                
                s = PairOfIntAndList( S )[1];
                
                map = List( (0):(s - 1), b -> chi( b ) );
                
                mor = List( (0):(s - 1), b -> Lift( C, beta_mor[1 + b], alpha_mor[1 + map[1 + b]] ) );
                
                return MorphismConstructor( UC,
                               S,
                               PairGAP( map, mor ),
                               T );
                
            end );
            #end, 2 * OperationWeight( C, "IsLiftable" ) + 2 * OperationWeight( C, "Lift" ) ); ## for this to work add OperationWeight in Hom-structure
            
        end;
        
    end;
    
    ##
    AddIsInitial( UC,
      function ( UC, object )
        
        ## SkeletalFinSets code:
        return PairOfIntAndList( object )[1] == 0;
        
    end );
    
    ## even if C has an initial object, the initial object of UC is a different one
    AddInitialObject( UC,
      function ( UC )
        
        return ObjectConstructor( UC,
                       PairGAP( ## SkeletalFinSets code:
                             BigInt( 0 ),
                             ## FiniteStrictCoproductCompletion code:
                             CapJitTypedExpression( [ ], UC -> CapJitDataTypeOfListOf( CapJitDataTypeOfObjectOfCategory( UnderlyingCategory( UC ) ) ) ) ) );
        
    end );
    
    ##
    AddUniversalMorphismFromInitialObjectWithGivenInitialObject( UC,
      function ( UC, object, I )
        
        return MorphismConstructor( UC,
                       I,
                       PairGAP( CapJitTypedExpression( [ ], ( ) -> CapJitDataTypeOfListOf( IsBigInt ) ),
                             CapJitTypedExpression( [ ], UC -> CapJitDataTypeOfListOf( CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( UC ) ) ) ) ),
                       object );
        
    end );
    
    if (CanCompute( C, "IsTerminal" ))
        
        ##
        AddIsTerminal( UC,
          function ( UC, object )
            local pair;
            
            pair = PairOfIntAndList( object );
            
            return pair[1] == BigInt( 1 ) && ## SkeletalFinSets code
                   IsTerminal( UnderlyingCategory( UC ), pair[2][1] ); ## FiniteStrictCoproductCompletion code
            
        end, OperationWeight( C, "IsTerminal" ) );
        
    end;
    
    if (CanCompute( C, "TerminalObject" ))
        
        ## the terminal object of UC is that of C
        AddTerminalObject( UC,
          function ( UC )
            
            return ObjectConstructor( UC,
                           PairGAP( ## SkeletalFinSets code
                                 BigInt( 1 ),
                                 ## FiniteStrictCoproductCompletion code
                                 [ TerminalObject( UnderlyingCategory( UC ) ) ] ) );
            
        end, OperationWeight( C, "TerminalObject" ) );
        
    end;
    
    if (CanCompute( C, "UniversalMorphismIntoTerminalObjectWithGivenTerminalObject" ))
        
        ##
        AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject( UC,
          function ( UC, object, T )
            local pair, L, map, C, t, mor;
            
            pair = PairOfIntAndList( object );
            
            ## SkeletalFinSets code:
            map = ListWithIdenticalEntries( pair[1], BigInt( 0 ) );
            
            ## FiniteStrictCoproductCompletion code:
            C = UnderlyingCategory( UC );
            
            t = TerminalObject( C );
            
            mor = List( pair[2], objC ->
                         UniversalMorphismIntoTerminalObjectWithGivenTerminalObject( C, objC, t ) );
            
            return MorphismConstructor( UC, object, PairGAP( map, mor ), T );
            
        end, 2 * OperationWeight( C, "UniversalMorphismIntoTerminalObjectWithGivenTerminalObject" ) );
        
    end;
    
    ##
    AddCoproduct( UC,
      function ( UC, D )
        local data;
        
        data = List( D, PairOfIntAndList );
        
        return ObjectConstructor( UC,
                       PairGAP( ## SkeletalFinSets code:
                             Sum( List( data, datum -> datum[1] ) ),
                             ## FiniteStrictCoproductCompletion code:
                             @Concatenation( List( data, datum -> datum[2] ) ) ) );
        
    end );
    
    ##
    AddInjectionOfCofactorOfCoproductWithGivenCoproduct( UC,
      function ( UC, D, k, coproduct )
        local data, lengths, sum, pair, lk, map, C, mor;
        
        data = List( D, PairOfIntAndList );
        
        ## SkeletalFinSets code:
        lengths = List( data, datum -> datum[1] );
        
        sum = Sum( lengths[(1):(k - 1)] );
        
        lk = lengths[k];
        
        map = (sum):(sum + lk - 1);
        
        ## FiniteStrictCoproductCompletion code:
        C = UnderlyingCategory( UC );
        
        mor = List( data[k][2], objC -> IdentityMorphism( C, objC ) );
        
        return MorphismConstructor( UC, D[k], PairGAP( map, mor ), coproduct );
        
    end );
    
    ##
    AddUniversalMorphismFromCoproductWithGivenCoproduct( UC,
      function ( UC, D, test_object, tau, S )
        local map, mor;
        
        ## SkeletalFinSets code:
        map = @Concatenation( List( tau, t -> PairOfLists( t )[1] ) );
        
        ## FiniteStrictCoproductCompletion code:
        mor = @Concatenation( List( tau, t -> PairOfLists( t )[2] ) );
        
        return MorphismConstructor( UC, S, PairGAP( map, mor ), test_object );
        
    end );
    
    ## the complements are disjoint since UC is extensive by
    ## [Prop. 2.4., Introduction to extensive and distributive categories, Carboni, Lack, Walters 1993]
    AddInjectionOfCoproductComplement( UC,
      function ( UC, iota )
        local S, T, T_datum, s, t, T_objs, iota_datum, idT, idT_mors, complement_map, complement_source, complement_mor;
        
        S = Source( iota );
        T = Target( iota );
        
        T_datum = PairOfIntAndList( T );
        
        s = PairOfIntAndList( S )[1];
        
        t = T_datum[1];
        T_objs = T_datum[2];
        
        iota_datum = PairOfLists( iota );
        
        idT = IdentityMorphism( UC, T );
        
        idT_mors = PairOfLists( idT )[2];
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        @Assert( 0, iota_datum[1] == DuplicateFreeList( iota_datum[1] ) );
        
        ## SkeletalFinSets code:
        complement_map = Difference( (0):(t - 1), iota_datum[1] );
        
        ## FiniteStrictCoproductCompletion code:
        complement_source = ObjectConstructor( UC,
                                     PairGAP( t - s,
                                           List( complement_map, i -> T_objs[1 + i] ) ) );
        
        complement_mor = List( complement_map, i -> idT_mors[1 + i] );
        
        return MorphismConstructor( UC,
                       complement_source,
                       PairGAP( complement_map,
                             complement_mor ),
                       T );
        
    end );
    
    if (CanCompute( C, "DirectProduct" ))
        
        ##
        AddDirectProduct( UC,
          function ( UC, D )
            local C, data, cartesian;
            
            C = UnderlyingCategory( UC );
            
            data = List( D, PairOfIntAndList );
            
            ## using the "double-reverse" in the below GAP command Cartesian
            ## is enforced by our convention for ProjectionInFactorOfDirectProduct in SkeletalFinSets:
            
            # gap> A = FinSet( 3 );
            # |3|
            # gap> B = FinSet( 4 );
            # |4|
            # gap> data = List( [ A, B ], AsList );
            # [ [ 0 .. 2 ], [ 0 .. 3 ] ]
            # gap> pi1 = ProjectionInFactorOfDirectProduct( [ A, B ], 1 );
            # |12| → |3|
            # gap> pi2 = ProjectionInFactorOfDirectProduct( [ A, B ], 2 );
            # |12| → |4|
            # gap> L1 = List( [ 0 .. 11 ], i -> [ pi1(i), pi2(i) ] );
            # [ [ 0, 0 ], [ 1, 0 ], [ 2, 0 ], [ 0, 1 ], [ 1, 1 ], [ 2, 1 ], [ 0, 2 ], [ 1, 2 ], [ 2, 2 ], [ 0, 3 ], [ 1, 3 ], [ 2, 3 ] ]
            # gap> L2 = List( Cartesian( Reversed( data ) ), Reversed );
            # [ [ 0, 0 ], [ 1, 0 ], [ 2, 0 ], [ 0, 1 ], [ 1, 1 ], [ 2, 1 ], [ 0, 2 ], [ 1, 2 ], [ 2, 2 ], [ 0, 3 ], [ 1, 3 ], [ 2, 3 ] ]
            # gap> L1 == L2;
            # true
            # gap> L3 = Cartesian( data );
            # [ [ 0, 0 ], [ 0, 1 ], [ 0, 2 ], [ 0, 3 ], [ 1, 0 ], [ 1, 1 ], [ 1, 2 ], [ 1, 3 ], [ 2, 0 ], [ 2, 1 ], [ 2, 2 ], [ 2, 3 ] ]
            # gap> L1 == L3;
            # false
            
            cartesian = List( Cartesian( List( Reversed( data ), datum -> datum[2] ) ), Reversed );
            
            ## this where distributivity is born:
            return ObjectConstructor( UC,
                           PairGAP( Product( List( data, datum -> datum[1] ) ), ## SkeletalFinSets code
                                 List( cartesian, L -> DirectProduct( C, L ) ) ) ); ## FiniteStrictCoproductCompletion code
            
        end, 2 * OperationWeight( C, "DirectProduct" ) );
        
    end;
    
    if (CanCompute( C, "ProjectionInFactorOfDirectProductWithGivenDirectProduct" ))
        
        ##
        AddProjectionInFactorOfDirectProductWithGivenDirectProduct( UC,
          function ( UC, D, k, P )
            local data, pair, d, pk, dk, p, map, C, product_objects, cartesian, mor;
            
            data = List( D, PairOfIntAndList );
            
            pair = PairOfIntAndList( P );
            
            ## SkeletalFinSets code:
            d = List( data, datum -> datum[1] );
            
            pk = Product( d[(1):(k - 1)] );
            
            dk = d[k];
            
            p = pair[1];
            
            map = List( (0):(p - 1), i -> RemInt( QuoInt( i, pk ), dk ) );
            
            ## FiniteStrictCoproductCompletion code:
            C = UnderlyingCategory( UC );
            
            product_objects = pair[2];
            
            cartesian = List( Cartesian( List( Reversed( data ), datum -> datum[2] ) ), Reversed );
            
            mor = List( (0):(p - 1), i -> ProjectionInFactorOfDirectProductWithGivenDirectProduct( C, cartesian[1 + i], k, product_objects[1 + i] ) );
            
            return MorphismConstructor( UC, P, PairGAP( map, mor ), D[k] );
            
        end, 2 * OperationWeight( C, "ProjectionInFactorOfDirectProductWithGivenDirectProduct" ) );
        
    end;
    
    if (CanCompute( C, "UniversalMorphismIntoDirectProductWithGivenDirectProduct" ))
        
        ##
        AddUniversalMorphismIntoDirectProductWithGivenDirectProduct( UC,
          function ( UC, D, T, tau, P )
            local data, target_pair, pairP, l, d, dd, tau_maps, m, map, C, cartesian, tau_mors, target_objects, product_objects, mor;
            
            data = List( D, PairOfIntAndList );
            
            target_pair = PairOfIntAndList( T );
            
            pairP = PairOfIntAndList( P );
            
            ## SkeletalFinSets code:
            l = Length( D );
            
            d = List( data, datum -> datum[1] );
            
            dd = List( (0):(l - 1), j -> Product( d[(1):(j)] ) );
            
            tau_maps = List( tau, t -> PairOfLists( t )[1] );
            
            m = (0):(target_pair[1] - 1);
            
            map = List( m, i -> Sum( (0):(l - 1), j -> tau_maps[1 + j][1 + i] * dd[1 + j] ) );
            
            ## FiniteStrictCoproductCompletion code:
            C = UnderlyingCategory( UC );
            
            cartesian = List( Cartesian( List( Reversed( data ), datum -> datum[2] ) ), Reversed );
            
            tau_mors = List( tau, t -> PairOfLists( t )[2] );
            
            target_objects = target_pair[2];
            
            product_objects = pairP[2];
            
            mor = List( m,
                         i -> UniversalMorphismIntoDirectProductWithGivenDirectProduct( C,
                                 cartesian[1 + map[1 + i]],
                                 target_objects[1 + i],
                                 List( (1):(l), j -> tau_mors[j][1 + i] ),
                                 product_objects[1 + map[1 + i]] ) );
            
            return MorphismConstructor( UC, T, PairGAP( map, mor ), P );
            
        end, 2 * OperationWeight( C, "UniversalMorphismIntoDirectProductWithGivenDirectProduct" ) );
        
    end;
    
    if (CanCompute( C, "Equalizer" ))
        
        AddEqualizer( UC,
          function( UC, common_source, list_of_parallel_morphisms )
            local S, s, cofactors, n, data, maps, emb, eq, C, mors, lists_of_parallel_morphisms_in_C, Eq;
            
            S = PairOfIntAndList( common_source );
            
            s = S[1];
            
            cofactors = S[2];
            
            n = Length( list_of_parallel_morphisms );
            
            data = List( list_of_parallel_morphisms, mor -> PairOfLists( mor ) );
            
            ## SkeletalFinSets code:
            
            maps = List( data, datum -> datum[1] );
            
            emb = Filtered( (0):(s - 1), x -> ForAll( (1):(n - 1), j -> maps[j][1 + x] == maps[j + 1][1 + x] ) );
            
            eq = Length( emb );
            
            ## FiniteStrictCoproductCompletion code:
            C = UnderlyingCategory( UC );
            
            mors = List( data, datum -> datum[2] );
            
            lists_of_parallel_morphisms_in_C = List( (0):(eq - 1), i -> List( (1):(n), j -> mors[j][1 + emb[1 + i]] ) );
            
            Eq = List( (0):(eq - 1), i ->
                        Equalizer( C,
                                cofactors[1 + emb[1 + i]],
                                lists_of_parallel_morphisms_in_C[1 + i] ) );
            
            return ObjectConstructor( UC, PairGAP( eq, Eq ) );
            
        end, 2 * OperationWeight( C, "Equalizer" ) );
        
    end;
    
    if (CanCompute( C, "EmbeddingOfEqualizerWithGivenEqualizer" ))
        
        AddEmbeddingOfEqualizerWithGivenEqualizer( UC,
          function( UC, common_source, list_of_parallel_morphisms, equalizer )
            local S, s, cofactors, n, data, eq_data, eq, Eq, maps, emb, C, mors, lists_of_parallel_morphisms_in_C, mor;
            
            S = PairOfIntAndList( common_source );
            
            s = S[1];
            
            cofactors = S[2];
            
            n = Length( list_of_parallel_morphisms );
            
            data = List( list_of_parallel_morphisms, PairOfLists );
            
            eq_data = PairOfIntAndList( equalizer );
            
            eq = eq_data[1];
            Eq = eq_data[2];
            
            ## SkeletalFinSets code:
            
            maps = List( data, datum -> datum[1] );
            
            emb = Filtered( (0):(s - 1), x -> ForAll( (1):(n - 1), j -> maps[j][1 + x] == maps[j + 1][1 + x] ) );
            
            #% CAP_JIT_DROP_NEXT_STATEMENT
            @Assert( 0, eq == Length( emb ) );
            
            ## FiniteStrictCoproductCompletion code:
            C = UnderlyingCategory( UC );
            
            mors = List( data, datum -> datum[2] );
            
            lists_of_parallel_morphisms_in_C = List( (0):(eq - 1), i -> List( (1):(n), j -> mors[j][1 + emb[1 + i]] ) );
            
            mor = List( (0):(eq - 1), i ->
                         EmbeddingOfEqualizerWithGivenEqualizer( C,
                                 cofactors[1 + emb[1 + i]],
                                 lists_of_parallel_morphisms_in_C[1 + i],
                                 Eq[1 + i] ) );
            
            return MorphismConstructor( UC, equalizer, PairGAP( emb, mor ), common_source );
            
        end, 2 * OperationWeight( C, "EmbeddingOfEqualizerWithGivenEqualizer" ) );
        
    end;
    
    if (CanCompute( C, "UniversalMorphismIntoEqualizerWithGivenEqualizer" ))
        
        AddUniversalMorphismIntoEqualizerWithGivenEqualizer( UC,
          function( UC, common_source, list_of_parallel_morphisms, test_object, test_morphism, equalizer )
            local S, s, cofactors, n, data, test_object_datum, t, t_objs, test_morphism_datum, test_map, test_mor, eq_data, eq, Eq,
                  maps, emb, map, C, mors, lists_of_parallel_morphisms_in_C, mor;
            
            S = PairOfIntAndList( common_source );
            
            s = S[1];
            
            cofactors = S[2];
            
            n = Length( list_of_parallel_morphisms );
            
            data = List( list_of_parallel_morphisms, PairOfLists );
            
            test_object_datum = PairOfIntAndList( test_object );
            
            t = test_object_datum[1];
            t_objs = test_object_datum[2];
            
            test_morphism_datum = PairOfLists( test_morphism );
            
            test_map = test_morphism_datum[1];
            test_mor = test_morphism_datum[2];
            
            eq_data = PairOfIntAndList( equalizer );
            
            eq = eq_data[1];
            Eq = eq_data[2];
            
            ## SkeletalFinSets code:
            
            maps = List( data, datum -> datum[1] );
            
            emb = Filtered( (0):(s - 1), x -> ForAll( (1):(n - 1), j -> maps[j][1 + x] == maps[j + 1][1 + x] ) );
            
            map = List( (0):(t - 1), x -> -1 + BigInt( SafePosition( emb, test_map[1 + x] ) ) );
            
            #% CAP_JIT_DROP_NEXT_STATEMENT
            @Assert( 0, eq == Length( emb ) );
            
            ## FiniteStrictCoproductCompletion code:
            C = UnderlyingCategory( UC );
            
            mors = List( data, datum -> datum[2] );
            
            lists_of_parallel_morphisms_in_C = List( (0):(eq - 1), i -> List( (1):(n), j -> mors[j][1 + emb[1 + i]] ) );
            
            mor = List( (0):(t - 1), k ->
                         UniversalMorphismIntoEqualizerWithGivenEqualizer( C,
                                 cofactors[1 + emb[1 + map[1 + k]]],
                                 lists_of_parallel_morphisms_in_C[1 + map[1 + k]],
                                 t_objs[1 + k],
                                 test_mor[1 + k],
                                 Eq[1 + map[1 + k]] ) );
            
            return MorphismConstructor( UC, test_object, PairGAP( map, mor ), equalizer );
            
        end, 2 * OperationWeight( C, "UniversalMorphismIntoEqualizerWithGivenEqualizer" ) );
        
    end;
    
    if (HasIsFiniteCategory( C ) && IsFiniteCategory( C ) &&
       HasRangeCategoryOfHomomorphismStructure( C ) && IsIntervalCategory( H ) &&
       CanCompute( C, "SetOfObjectsOfCategory" ))
        
        SetIsFiniteCategory( UC, true );
        
        ##
        AddSetOfObjectsOfCategory( UC,
          function( UC )
            local C, Yoneda, representables, joins;
            
            C = UnderlyingCategory( UC );
            
            Yoneda = EmbeddingOfUnderlyingCategoryData( UC )[2];
            
            representables = List( SetOfObjects( C ), Yoneda[1] );
            
            joins = AllCoproducts( UC, representables );
            
            return List( @Concatenation( joins ), entry -> entry[2] );
            
        end, 2 * OperationWeight( C, "SetOfObjectsOfCategory" ) );
        
    end;
    
    if (HasIsEquippedWithHomomorphismStructure( C ) && IsEquippedWithHomomorphismStructure( C ) &&
       MissingOperationsForConstructivenessOfCategory( C, "IsEquippedWithHomomorphismStructure" ) == [ ] &&
       HasRangeCategoryOfHomomorphismStructure( C ) &&
       HasIsCartesianCategory( H ) && IsCartesianCategory( H ) &&
       MissingOperationsForConstructivenessOfCategory( H, "IsCartesianCategory" ) == [ ])
        
        if (( HasIsTerminalCategory( H ) && IsTerminalCategory( H ) ) ||
           !( HasIsCocartesianCategory( H ) && IsCocartesianCategory( H ) ))
            
            if (IsIdenticalObj( C, H ))
                
                # prevent infinite recursion
                H = UC;
                
            else
                
                H = FiniteStrictCoproductCompletion( H );
                
            end;
            
            # prepare for ExtendRangeOfHomomorphismStructureByFullEmbedding
            
            object_func = function ( C, H, object )
                #% CAP_JIT_RESOLVE_FUNCTION
                
                return ObjectConstructor( H, PairGAP( BigInt( 1 ), [ object ] ) );
                
            end;
            
            morphism_func = function ( C, H, source, morphism, target )
                #% CAP_JIT_RESOLVE_FUNCTION
                
                return MorphismConstructor( H,
                    source,
                    PairGAP( [ BigInt( 0 ) ], [ morphism ] ),
                    target );
                
            end;
            
            object_func_inverse = function ( C, H, object )
                local datum;
                #% CAP_JIT_RESOLVE_FUNCTION
                
                datum = ObjectDatum( H, object );
                
                #% CAP_JIT_DROP_NEXT_STATEMENT
                @Assert( 0, Length( datum ) == 2 && IsBigInt( datum[1] ) && datum[1] == BigInt( 1 ) && Length( datum[2] ) == datum[1] );
                
                return datum[2][1];
                
            end;
            
            morphism_func_inverse = function ( C, H, source, pair_of_lists, target )
                local morphism;
                #% CAP_JIT_RESOLVE_FUNCTION
                
                #% CAP_JIT_DROP_NEXT_STATEMENT
                @Assert( 0, pair_of_lists[1] == [ BigInt( 0 ) ] && Length( pair_of_lists[2] ) == BigInt( 1 ) );
                
                morphism = pair_of_lists[2][1];
                
                #% CAP_JIT_DROP_NEXT_STATEMENT
                @Assert( 0, IsCapCategoryMorphism( morphism ) && IsIdenticalObj( CapCategory( morphism ), C ) );
                
                #% CAP_JIT_DROP_NEXT_STATEMENT
                @Assert( 0, IsEqualForObjects( source, Source( pair_of_lists[2][1] ) ) );
                
                #% CAP_JIT_DROP_NEXT_STATEMENT
                @Assert( 0, IsEqualForObjects( target, Target( pair_of_lists[2][1] ) ) );
                
                return pair_of_lists[2][1];
                
            end;
            
            extended = true;
            
            ExtendRangeOfHomomorphismStructureByFullEmbedding( C, H, object_func, morphism_func, object_func_inverse, morphism_func_inverse );
            
        else
            
            extended = false;
            
            ExtendRangeOfHomomorphismStructureByIdentityAsFullEmbedding( C );
            
        end;
        
        SET_RANGE_CATEGORY_Of_HOMOMORPHISM_STRUCTURE( UC, H );
        
        ##
        AddDistinguishedObjectOfHomomorphismStructure( UC,
          function( UC )
            local H;
            
            H = RangeCategoryOfHomomorphismStructure( UC );
            
            return DistinguishedObjectOfHomomorphismStructureExtendedByFullEmbedding( UnderlyingCategory( UC ), H );
            
        end );
        
        ##
        AddHomomorphismStructureOnObjects( UC,
          function( UC, S, T )
            local C, H, source_pair, target_pair, s, t, source_objects, target_objects, maps;
            
            C = UnderlyingCategory( UC );
            H = RangeCategoryOfHomomorphismStructure( UC );
            
            source_pair = PairOfIntAndList( S );
            target_pair = PairOfIntAndList( T );
            
            s = source_pair[1];
            t = target_pair[1];
            
            source_objects = source_pair[2];
            target_objects = target_pair[2];
            
            maps = List( (0):(t ^ s - 1), m ->
                          List( (0):(s - 1), i ->
                                DigitInPositionalNotation( m, i, s, t  ) ) );
            
            return Coproduct( H,
                           List( maps, map ->
                                 DirectProduct( H,
                                         List( (0):(s - 1), i ->
                                               HomomorphismStructureOnObjectsExtendedByFullEmbedding( C, H,
                                                       source_objects[1 + i], target_objects[1 + map[1 + i]] ) ) ) ) );
            
        end );
        
        ##
        AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( UC,
          function( UC, distinguished_object, phi, target )
            local C, H, source_pair, target_pair, s, t, maps, source_objects, target_objects, Homs, homs, pair_of_lists, map, mor, number, intros, intro;
            
            C = UnderlyingCategory( UC );
            H = RangeCategoryOfHomomorphismStructure( UC );
            
            source_pair = PairOfIntAndList( Source( phi ) );
            target_pair = PairOfIntAndList( Target( phi ) );
            
            s = source_pair[1];
            t = target_pair[1];
            
            maps = List( (0):(t ^ s - 1), m ->
                          List( (0):(s - 1), i ->
                                DigitInPositionalNotation( m, i, s, t ) ) );
            
            source_objects = source_pair[2];
            target_objects = target_pair[2];
            
            Homs = List( maps, map ->
                          List( (0):(s - 1), i ->
                                HomomorphismStructureOnObjectsExtendedByFullEmbedding( C, H,
                                        source_objects[1 + i], target_objects[1 + map[1 + i]] ) ) );
            
            homs = List( Homs, L -> DirectProduct( H, L ) );
            
            pair_of_lists = PairOfLists( phi );
            
            map = pair_of_lists[1];
            mor = pair_of_lists[2];
            
            ## map -> number
            number = Sum( (0):(s - 1), i -> map[1 + i] * t^i );
            
            intros = List( (0):(s - 1), i ->
                            InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjectsExtendedByFullEmbedding( C, H,
                                    distinguished_object,
                                    mor[1 + i], ## ∈ C₁
                                    Homs[1 + number][1 + i] ) );
            
            intro = UniversalMorphismIntoDirectProductWithGivenDirectProduct( H,
                             Homs[1 + number],
                             distinguished_object,
                             intros,
                             homs[1 + number] );
            
            return PreCompose( H,
                           intro,
                           InjectionOfCofactorOfCoproductWithGivenCoproduct( H,
                                   homs,
                                   1 + number,
                                   target ) );
            
        end );
        
        if (extended)
            
            ##
            AddHomomorphismStructureOnMorphismsWithGivenObjects( UC,
              function ( UC, source, alpha, gamma, target )
                local C, UV, H, source_alpha, target_alpha, source_gamma, target_gamma,
                      source_alpha_length, target_alpha_length, source_gamma_length, target_gamma_length,
                      Hom_target_alpha_source_gamma, Hom_source_alpha_target_gamma,
                      alpha_datum, gamma_datum, f, h, alpha_mor, gamma_mor, cmp_maps_and_mors, map_and_mor;
                
                C = UnderlyingCategory( UC );
                UV = RangeCategoryOfHomomorphismStructure( UC );
                H = UnderlyingCategory( UV );
                
                source_alpha = PairOfIntAndList( Source( alpha ) );
                target_alpha = PairOfIntAndList( Target( alpha ) );
                
                source_gamma = PairOfIntAndList( Source( gamma ) );
                target_gamma = PairOfIntAndList( Target( gamma ) );
                
                source_alpha_length = source_alpha[1];
                target_alpha_length = target_alpha[1];
                
                source_gamma_length = source_gamma[1];
                target_gamma_length = target_gamma[1];
                
                Hom_target_alpha_source_gamma = ObjectDatum( UV, source );
                Hom_source_alpha_target_gamma = ObjectDatum( UV, target );
                
                alpha_datum = PairOfLists( alpha );
                gamma_datum = PairOfLists( gamma );
                
                f = alpha_datum[1];
                h = gamma_datum[1];
                
                alpha_mor = alpha_datum[2];
                gamma_mor = gamma_datum[2];
                
                cmp_maps_and_mors =
                  function( gg )
                    local g, cmp_f_g_h, map_value,
                          Hom_target_alpha_source_gamma_g, Hom_source_alpha_target_gamma_fgh,
                          Hom_target_alpha_source_gamma_g_factors, Hom_source_alpha_target_gamma_fgh_factors,
                          mor_value;
                    
                    g = List( (0):(target_alpha_length - 1), i -> RemInt( QuoInt( gg, source_gamma_length ^ i ), source_gamma_length ) );
                    
                    cmp_f_g_h = List( (0):(source_alpha_length - 1), j -> h[1 + g[1 + f[1 + j]]] );
                    
                    map_value = Sum( (0):(source_alpha_length - 1), i -> cmp_f_g_h[1 + i] * target_gamma_length ^ i );
                    
                    Hom_target_alpha_source_gamma_g = Hom_target_alpha_source_gamma[2][1 + gg];

                    Hom_source_alpha_target_gamma_fgh = Hom_source_alpha_target_gamma[2][1 + map_value];
                    
                    Hom_target_alpha_source_gamma_g_factors = List( (0):(target_alpha_length - 1), j ->
                                                                    HomomorphismStructureOnObjects( C,
                                                                            target_alpha[2][1 + j],
                                                                            source_gamma[2][1 + g[1 + j]] ) );
                    
                    Hom_source_alpha_target_gamma_fgh_factors = List( (0):(source_alpha_length - 1), i ->
                                                                      HomomorphismStructureOnObjects( C,
                                                                              source_alpha[2][1 + i],
                                                                              target_gamma[2][1 + cmp_f_g_h[1 + i]] ) );
                    
                    mor_value = UniversalMorphismIntoDirectProductWithGivenDirectProduct( H,
                                         Hom_source_alpha_target_gamma_fgh_factors,
                                         Hom_target_alpha_source_gamma_g,
                                         List( (0):(source_alpha_length - 1), i ->
                                               PreCompose( H,
                                                       ProjectionInFactorOfDirectProductWithGivenDirectProduct( H,
                                                               Hom_target_alpha_source_gamma_g_factors,
                                                               1 + f[1 + i],
                                                               Hom_target_alpha_source_gamma_g ),
                                                       HomomorphismStructureOnMorphismsWithGivenObjects( C,
                                                               Hom_target_alpha_source_gamma_g_factors[1 + f[1 + i]],
                                                               alpha_mor[1 + i],
                                                               gamma_mor[1 + g[1 + f[1 + i]]],
                                                               Hom_source_alpha_target_gamma_fgh_factors[1 + i] ) ) ),
                                         Hom_source_alpha_target_gamma_fgh );
                    
                    return PairGAP( map_value, mor_value );
                    
                end;
                
                map_and_mor = List( (0):(Hom_target_alpha_source_gamma[1] - 1), cmp_maps_and_mors );
                
                return MorphismConstructor( UV,
                               source,
                               PairGAP( List( map_and_mor, a -> a[1] ),
                                     List( map_and_mor, a -> a[2] ) ),
                               target );
                
            end );
            
            ##
            AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( UC,
              function( UC, S, T, morphism )
                local C, UV, H, source_pair, target_pair, s, t, maps, source_objects, target_objects, Homs, homs, pair_of_lists, number, map, m, mor;
                
                C = UnderlyingCategory( UC );
                UV = RangeCategoryOfHomomorphismStructure( UC );
                H = UnderlyingCategory( UV );
                
                source_pair = PairOfIntAndList( S );
                target_pair = PairOfIntAndList( T );
                
                s = source_pair[1];
                t = target_pair[1];
                
                maps = List( (0):(t ^ s - 1), m ->
                              List( (0):(s - 1), i ->
                                    DigitInPositionalNotation( m, i, s, t ) ) );
                
                source_objects = source_pair[2];
                target_objects = target_pair[2];
                
                Homs = List( maps, map ->
                              List( (0):(s - 1), i ->
                                    HomomorphismStructureOnObjects( C,
                                            source_objects[1 + i], target_objects[1 + map[1 + i]] ) ) );
                
                homs = List( Homs, L -> DirectProduct( H, L ) );
                
                pair_of_lists = MorphismDatum( UV, morphism );
                
                #% CAP_JIT_DROP_NEXT_STATEMENT
                @Assert( 0, Length( pair_of_lists[1] ) == 1 );
                
                number = pair_of_lists[1][1];
                
                ## number -> map
                map = List( (0):(s - 1), i -> RemInt( QuoInt( number, t^i ), t ) );
                
                #% CAP_JIT_DROP_NEXT_STATEMENT
                @Assert( 0, map == maps[1 + number] );
                
                m = pair_of_lists[2][1];
                
                mor = List( (0):(s - 1), i ->
                             InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( C,
                                     source_objects[1 + i],
                                     target_objects[1 + map[1 + i]],
                                     PreCompose( H,
                                             m,
                                             ProjectionInFactorOfDirectProductWithGivenDirectProduct( H,
                                                     Homs[1 + number],
                                                     1 + i,
                                                     homs[1 + number] ) ) ) );
                
                return MorphismConstructor( UC,
                               S,
                               PairGAP( map, mor ),
                               T );
                
            end );
            
            if (CanCompute( C, "MorphismsOfExternalHom" ))
                
                ##
                AddMorphismsOfExternalHom( UC,
                  function ( UC, source, target )
                    local C, source_pair, target_pair, s, t, maps, source_objects, target_objects, mors, L;
                    
                    C = UnderlyingCategory( UC );
                    
                    source_pair = PairOfIntAndList( source );
                    target_pair = PairOfIntAndList( target );
                    
                    ## SkeletalFinSets code:
                    
                    s = source_pair[1];
                    t = target_pair[1];
                    
                    maps = List( (0):(t ^ s - 1), m ->
                                  List( (0):(s - 1), i ->
                                        DigitInPositionalNotation( m, i, s, t ) ) );
                    ## FiniteStrictCoproductCompletion code:
                    
                    source_objects = source_pair[2];
                    target_objects = target_pair[2];
                    
                    mors = List( maps, map ->
                                  List( Cartesian( Reversed(
                                          List( (0):(s - 1), i ->
                                                MorphismsOfExternalHom( C, source_objects[1 + i], target_objects[1 + map[1 + i]] ) ) ) ), Reversed ) );
                    
                    L = List( (0):(t ^ s - 1), m ->
                               List( mors[1 + m], mor -> PairGAP( maps[1 + m], mor ) ) );
                    
                    L = @Concatenation( L );
                    
                    return List( L, map_mor ->
                                 MorphismConstructor( UC,
                                         source,
                                         map_mor,
                                         target ) );
                    
                end );
                
            end;
            
        elseif (IsSkeletalCategoryOfFiniteSets( H ) ||
          IsSkeletalCategoryOfFiniteSetsAsFiniteStrictCoproductCompletionOfTerminalCategory( H ) ||
          IsIntervalCategory( H ))
            
            ##
            AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( UC,
              function( UC, S, T, morphism )
                local C, UV, H, source_pair, target_pair, s, t, maps, source_objects, target_objects, Homs, homs, value, number, map, m, mor;
                
                C = UnderlyingCategory( UC );
                H = RangeCategoryOfHomomorphismStructure( UC );
                
                source_pair = PairOfIntAndList( S );
                target_pair = PairOfIntAndList( T );
                
                s = source_pair[1];
                t = target_pair[1];
                
                maps = List( (0):(t ^ s - 1), m ->
                              List( (0):(s - 1), i ->
                                    DigitInPositionalNotation( m, i, s, t ) ) );
                
                source_objects = source_pair[2];
                target_objects = target_pair[2];
                
                Homs = List( maps, map ->
                              List( (0):(s - 1), i ->
                                    HomomorphismStructureOnObjects( C,
                                            source_objects[1 + i], target_objects[1 + map[1 + i]] ) ) );
                
                homs = List( Homs, L -> DirectProduct( H, L ) );
                
                value = MorphismDatum( H, morphism )[1];
                
                number = BigInt( SafeFirst( (0):(t ^ s - 1), i -> Sum( List( homs[(1):(1 + i)], Cardinality ) ) > value ) );
                
                ## number -> map
                map = List( (0):(s - 1), i -> DigitInPositionalNotation( number, i, s, t ) );
                
                #% CAP_JIT_DROP_NEXT_STATEMENT
                @Assert( 0, map == maps[1 + number] );
                
                mor = List( (0):(s - 1), i ->
                             InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( C,
                                     source_objects[1 + i],
                                     target_objects[1 + map[1 + i]],
                                     PreCompose( H,
                                             Lift( H,
                                                   morphism,
                                                   InjectionOfCofactorOfCoproduct( H,
                                                           homs,
                                                           1 + number ) ),
                                             ProjectionInFactorOfDirectProductWithGivenDirectProduct( H,
                                                     Homs[1 + number],
                                                     1 + i,
                                                     homs[1 + number] ) ) ) );
                
                return MorphismConstructor( UC,
                               S,
                               PairGAP( map, mor ),
                               T );
                
            end );
            
        end;
        
    end;
    
    #if false)
    if (no_precompiled_code != true &&
       HasRangeCategoryOfHomomorphismStructure( C ))
        
        if (IsCategoryFromDataTables( C ) && IsSkeletalCategoryOfFiniteSets( H ))
            
            ADD_FUNCTIONS_FOR_FiniteStrictCoproductCompletionOfCategoryFromDataTablesPrecompiled( UC );
            
        end;
        
    end;
    
    if (FinalizeCategory)
        Finalize( UC );
    end;
    
    return UC;
    
end ) );

@FilterIntersection( IsObjectInFiniteStrictCoproductCompletion, HasIsZeroForObjects, IsZeroForObjects );
@FilterIntersection( IsMorphismInFiniteStrictCoproductCompletion, HasIsZeroForMorphisms, IsZeroForMorphisms );

##
@InstallMethod( FiniteStrictCoproductCompletion,
        "for a CAP category",
        [ FilterIntersection( IsCapCategory, IsInitialCategory ) ],
        
  @FunctionWithNamedArguments(
  [
    [ "FinalizeCategory", true ],
  ],
  function( CAP_NAMED_ARGUMENTS, I )
    local name, category_filter, category_object_filter, category_morphism_filter,
          create_func_object, create_func_morphism,
          object_constructor, object_datum, morphism_constructor, morphism_datum,
          H, UI;
    
    name = @Concatenation( "FiniteStrictCoproductCompletion( ", Name( I ), " )" );
    
    category_filter = IsFiniteStrictCoproductCompletion;
    
    category_object_filter = FilterIntersection( IsObjectInFiniteStrictCoproductCompletion, HasIsZeroForObjects, IsZeroForObjects );
    
    category_morphism_filter = FilterIntersection( IsMorphismInFiniteStrictCoproductCompletion, HasIsZeroForMorphisms, IsZeroForMorphisms );
    
    ## e.g., ZeroObject, DirectSum
    create_func_object =
        function( name, UI )
            
            return """
                function( input_arguments... )
                  
                  return ObjectConstructor( cat,
                                 PairGAP( BigInt( 0 ),
                                       CapJitTypedExpression( [ ], cat -> CapJitDataTypeOfListOf( CapJitDataTypeOfObjectOfCategory( UnderlyingCategory( cat ) ) ) ) ) );
                  
                end
            """;
            
        end;
    
    ## e.g., IdentityMorphism, PreCompose
    create_func_morphism =
        function( name, UI )
            
            return """
                function( input_arguments... )
                  
                  return MorphismConstructor( cat,
                                 top_source,
                                 PairGAP( CapJitTypedExpression( [ ], ( ) -> CapJitDataTypeOfListOf( IsBigInt ) ),
                                       CapJitTypedExpression( [ ], cat -> CapJitDataTypeOfListOf( CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( cat ) ) ) ) ),
                                 top_range );
                  
                end
            """;
            
        end;
    
    ##
    object_constructor =
      function ( UI, pair_of_int_and_list )
        
        return CreateCapCategoryObjectWithAttributes( UI,
                       PairOfIntAndList, pair_of_int_and_list );
        
    end;
    
    object_datum = ( UI, object ) -> PairOfIntAndList( object );
    
    morphism_constructor =
      function ( UI, S, pair_of_lists, T )
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        @Assert( 0, IsList( pair_of_lists ) &&
                Length( pair_of_lists ) == 2 &&
                IsList( pair_of_lists[1] ) &&
                IsList( pair_of_lists[2] ) );
        
        return CreateCapCategoryMorphismWithAttributes( UI,
                       S,
                       T,
                       PairOfLists, pair_of_lists );
        
    end;
    
    morphism_datum = ( UI, morphism ) -> PairOfLists( morphism );
    
    if (HasRangeCategoryOfHomomorphismStructure( I ))
        H = RangeCategoryOfHomomorphismStructure( I );
        if (@not IsIdenticalObj( I, H ))
            H = FiniteStrictCoproductCompletion( H );
        else
            H = "self";
        end;
    else
        H = "self";
    end;
    
    UI =
      CAP_INTERNAL_CONSTRUCTOR_FOR_TERMINAL_CATEGORY( @rec(
              name = name,
              supports_empty_limits = true,
              category_filter = category_filter,
              category_object_filter = category_object_filter,
              category_morphism_filter = category_morphism_filter,
              create_func_object = create_func_object,
              create_func_morphism = create_func_morphism,
              object_constructor = object_constructor,
              object_datum = object_datum,
              morphism_constructor = morphism_constructor,
              morphism_datum = morphism_datum,
              range_category_of_homomorphism_structure = H,
              ) );
    
    ##
    SetUnderlyingCategory( UI, I );
    
    ##
    UI.compiler_hints.category_attribute_names =
      [ "UnderlyingCategory",
        ];
    
    ##
    AddSetOfObjectsOfCategory( UI,
      function( UI )
        
        return [ InitialObject( UI ) ];
        
    end );
    
    ##
    AddIsWellDefinedForObjects( UI,
      function( UI, object )
        
        return true;
        
    end );
    
    ##
    AddIsWellDefinedForMorphisms( UI,
      function( UI, morphism )
        
        return true;
        
    end );
    
    ## will be derived using IsHomSetInhabited in an Ab-category
    #AddIsEqualForObjects( UI,
    #  function( UI, object1, object2 )
    #    
    #    return true;
    #    
    #end );
    
    ##
    AddIsEqualForMorphisms( UI,
      function( UI, morphism1, morphism2 )
        
        return true;
        
    end );
    
    ## if H == "self", the Hom-structure will be derived from the closed monoidal structure
    if (@not H == "self")
        
        ##
        AddDistinguishedObjectOfHomomorphismStructure( UI,
          function( UI )
            local H;
            
            H = RangeCategoryOfHomomorphismStructure( UI );
            
            return InitialObject( H );
            
        end );
        
        ##
        AddHomomorphismStructureOnObjects( UI,
                function( UI, S, T )
            
            return DistinguishedObjectOfHomomorphismStructure( UI );
            
        end );
        
        ##
        AddHomomorphismStructureOnMorphismsWithGivenObjects( UI,
          function ( UI, source, alpha, gamma, target )
            local H;
            
            H = RangeCategoryOfHomomorphismStructure( UI );
            
            return MorphismConstructor( H, source, fail, target );
            
        end );
        
        ##
        AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( UI,
          function( UI, distinguished_object, phi, target )
            local H;
            
            H = RangeCategoryOfHomomorphismStructure( UI );
            
            return MorphismConstructor( H, distinguished_object, fail, target );
            
        end );
        
        ##
        AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( UI,
          function( UI, S, T, morphism )
            
            return MorphismConstructor( UI, S, fail, T );
            
        end );
        
    end;
    
    ##
    AddMorphismsOfExternalHom( UI,
      function( UI, object1, object2 )
        
        return [ IdentityMorphism( UI, object1 ) ];
        
    end );
    
    if (FinalizeCategory)
        Finalize( UI );
    end;
    
    @Assert( 0, [ ] == MissingOperationsForConstructivenessOfCategory( UI, "IsEquippedWithHomomorphismStructure" ) );
    
    return UI;
    
end ) );

##
@InstallMethod( SetOfObjects,
        "for a finite coproduct cocompletion category",
        [ IsFiniteStrictCoproductCompletion ],
        
  function( UC )
    
    return SetOfObjectsOfCategory( UC );
    
end );

##
@InstallMethod( EnrichmentSpecificFiniteStrictCoproductCompletion,
        "for a category and its range category of homomorphism structure",
        [ IsCapCategory, IsIntervalCategory ],
        
  @FunctionWithNamedArguments(
  [
    [ "FinalizeCategory", true ],
  ],
  function( CAP_NAMED_ARGUMENTS, C, H )
    
    if (@not IsIdenticalObj( H, RangeCategoryOfHomomorphismStructure( C ) ))
        Error( "the second category `H` must coincide with the range category of homomorphism structure of the first category `C`\n" );
    end;
    
    return FiniteStrictCoproductCompletion( C; FinalizeCategory = FinalizeCategory );
    
end ) );

##
@InstallMethod( EnrichmentSpecificFiniteStrictCoproductCompletion,
        "for a category and its range category of homomorphism structure",
        [ IsCapCategory, IsSkeletalCategoryOfFiniteSets ],
        
  @FunctionWithNamedArguments(
  [
    [ "FinalizeCategory", true ],
  ],
  function( CAP_NAMED_ARGUMENTS, C, H )
    
    if (@not IsIdenticalObj( H, RangeCategoryOfHomomorphismStructure( C ) ))
        Error( "the second category `H` must coincide with the range category of homomorphism structure of the first category `C`\n" );
    end;
    
    return FiniteStrictCoproductCompletion( C; FinalizeCategory = FinalizeCategory );
    
end ) );

##
@InstallMethod( EmbeddingOfUnderlyingCategoryData,
        "for a finite coproduct cocompletion category",
        [ IsFiniteStrictCoproductCompletion ],
        
  function( UC )
    local embedding_on_objects, embedding_on_morphisms;
    
    embedding_on_objects =
      objC -> ObjectConstructor( UC, PairGAP( BigInt( 1 ), [ objC ] ) );
    
    embedding_on_morphisms =
      ( source, morC, target ) -> MorphismConstructor( UC, source, PairGAP( [ BigInt( 0 ) ], [ morC ] ), target );
    
    return Triple( UnderlyingCategory( UC ),
                   PairGAP( embedding_on_objects, embedding_on_morphisms ),
                   UC );
    
end );

##
@InstallMethod( EmbeddingOfUnderlyingCategory,
        "for a finite coproduct cocompletion category",
        [ IsFiniteStrictCoproductCompletion ],
        
  function( UC )
    local data, Y;
    
    data = EmbeddingOfUnderlyingCategoryData( UC );
    
    Y = CapFunctor( "Embedding functor into a finite strict coproduct cocompletion category", data[1], UC );
    
    AddObjectFunction( Y, data[2][1] );
    
    AddMorphismFunction( Y, data[2][2] );
    
    return Y;
    
end );

##
@InstallMethod( /,
        "for a string and a finite coproduct cocompletion category",
        [ IsString, IsFiniteStrictCoproductCompletion ],
        
  function( name, UC )
    local C, Y, Yc;
    
    C = UnderlyingCategory( UC );
    
    Y = EmbeddingOfUnderlyingCategory( UC );
    
    Yc = CallFuncListAtRuntime( ApplyFunctor, [ Y, C[name] ] );
    
    if (IsObjectInFiniteStrictCoproductCompletion( Yc ))

        #TODO: is this true?
        #SetIsProjective( Yc, true );
        
    elseif (IsMorphismInFiniteStrictCoproductCompletion( Yc ))
        
        if (CanCompute( UC, "IsMonomorphism" ))
            IsMonomorphism( Yc );
        end;
        
        if (CanCompute( UC, "IsSplitMonomorphism" ))
            IsSplitMonomorphism( Yc );
        end;
        
        if (CanCompute( UC, "IsEpimorphism" ))
            IsEpimorphism( Yc );
        end;
        
        if (CanCompute( UC, "IsSplitEpimorphism" ))
            IsSplitEpimorphism( Yc );
        end;
        
        ## IsIsomorphism == IsSplitMonomorphism and IsSplitEpimorphism
        ## we add this here in case the logic is deactivated
        if (CanCompute( UC, "IsIsomorphism" ))
            IsIsomorphism( Yc );
        end;
        
    end;
    
    return Yc;
    
end );

#= comment for Julia
INSTALL_DOT_METHOD( IsFiniteStrictCoproductCompletion );
# =#

##
@InstallMethod( ExtendFunctorToFiniteStrictCoproductCompletionData,
        "for a two categories and a pair of functions",
        [ IsFiniteStrictCoproductCompletion, IsList, FilterIntersection( IsCapCategory, IsCocartesianCategory ) ], ## IsStrictCocartesianCategory would exclude the lazy category
        
  function( UC, pair_of_funcs, category_with_strict_coproducts )
    local functor_on_objects, functor_on_morphisms,
          extended_functor_on_objects, extended_functor_on_morphisms;
    
    functor_on_objects = pair_of_funcs[1];
    functor_on_morphisms = pair_of_funcs[2];
    
    ## the code below is the doctrine-specific ur-algorithm for strict cocartesian (monoidal) categories
    
    extended_functor_on_objects =
      function( objUC )
        local L;
        
        L = PairOfIntAndList( objUC )[2];
        
        return Coproduct( category_with_strict_coproducts, List( L, functor_on_objects ) );
        
    end;

    extended_functor_on_morphisms =
      function( source, morUC, target )
        local source_pair, target_pair, s, t, S, T, source_diagram, target_diagram, pair_of_lists, map, mor, functor_on_mor;
        
        source_pair = PairOfIntAndList( Source( morUC ) );
        target_pair = PairOfIntAndList( Target( morUC ) );
        
        s = source_pair[1];
        t = target_pair[1];
        
        S = source_pair[2];
        T = target_pair[2];
        
        source_diagram = List( (0):(s - 1), i -> functor_on_objects( S[1 + i] ) );
        target_diagram = List( (0):(t - 1), i -> functor_on_objects( T[1 + i] ) );
        
        if (@not IsEqualForObjects( category_with_strict_coproducts, source, Coproduct( category_with_strict_coproducts, source_diagram ) ))
            Error( "source and Coproduct( source_diagram ) do not coincide\n" );
        end;
        
        if (@not IsEqualForObjects( category_with_strict_coproducts, target, Coproduct( category_with_strict_coproducts, target_diagram ) ))
            Error( "target and Coproduct( target_diagram ) do not coincide\n" );
        end;
        
        pair_of_lists = PairOfLists( morUC );
        
        map = pair_of_lists[1];
        mor = pair_of_lists[2];
        
        functor_on_mor =
          List( (0):(s - 1), i ->
                functor_on_morphisms(
                        source_diagram[1 + i],
                        mor[1 + i],
                        target_diagram[1 + map[1 + i]] ) );
        
        return MorphismBetweenCoproductsWithGivenCoproducts( category_with_strict_coproducts,
                       source,
                       source_diagram,
                       PairGAP( map, functor_on_mor ),
                       target_diagram,
                       target );
        
    end;
    
    return Triple( UC,
                   PairGAP( extended_functor_on_objects, extended_functor_on_morphisms ),
                   category_with_strict_coproducts );
    
end );

##
@InstallMethod( ExtendFunctorToFiniteStrictCoproductCompletion,
        "for a functor",
        [ IsCapFunctor ],
        
  function( F )
    local C, D, UC, data, UF;
    
    C = SourceOfFunctor( F );
    D = RangeOfFunctor( F );
    
    UC = FiniteStrictCoproductCompletion( C );
    
    data = ExtendFunctorToFiniteStrictCoproductCompletionData(
                    UC,
                    PairGAP( FunctorObjectOperation( F ), FunctorMorphismOperation( F ) ),
                    D );
    
    UF = CapFunctor( @Concatenation( "Extension to FiniteStrictCoproductCompletion( Source( ", Name( F ), " ) )" ), UC, D );
    
    AddObjectFunction( UF,
            data[2][1] );
    
    AddMorphismFunction( UF,
            data[2][2] );
    
    return UF;
    
end );

##
@InstallMethod( ExtendEmbeddingToFiniteStrictCoproductCompletion,
        "for a CAP category",
        [ IsCapCategory ],
        
  function( C )
    
    return ExtendFunctorToFiniteStrictCoproductCompletion( YonedaEmbedding( C ) );
    
end );

##
@InstallMethod( TensorizeObjectWithObjectInRangeCategoryOfHomomorphismStructure,
        "for a skeletal category of finite sets, a finite strict coproduct cocompletion, an object in the cocartesian category, and an object in the skeletal category of finite sets",
        [ IsSkeletalCategoryOfFiniteSets,
          FilterIntersection( IsCapCategory, IsFiniteStrictCoproductCompletion, HasRangeCategoryOfHomomorphismStructure ),
          IsCapCategoryObject, IsSkeletalFiniteSet ],
        
  function( H, UC, c, h )
    local l;
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    @Assert( 0, IsIdenticalObj( CapCategory( c ), UnderlyingCategory( UC ) ) );
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    @Assert( 0, IsIdenticalObj( CapCategory( h ), H ) );
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    @Assert( 0, IsIdenticalObj( RangeCategoryOfHomomorphismStructure( UC ), H ) );
    
    l = ObjectDatum( H, h );
    
    return ObjectConstructor( UC, PairGAP( l, ListWithIdenticalEntries( l, c ) ) );
    
end );

##
@InstallMethod( TensorizeObjectWithMorphismInRangeCategoryOfHomomorphismStructure,
        "for a skeletal category of finite sets, a finite strict coproduct cocompletion, three objects in the cocartesian category, and a morphism in the skeletal category of finite sets",
        [ IsSkeletalCategoryOfFiniteSets,
          FilterIntersection( IsCapCategory, IsFiniteStrictCoproductCompletion, HasRangeCategoryOfHomomorphismStructure ),
          IsCapCategoryObject, IsCapCategoryObject, IsSkeletalFiniteSetMap, IsCapCategoryObject ],
        
  function( H, UC, source, c, nu, target )
    local C, id_d, s, nu_list;
    
    C = UnderlyingCategory( UC );
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    @Assert( 0, IsIdenticalObj( CapCategory( c ), C ) );
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    @Assert( 0, IsIdenticalObj( CapCategory( nu ), H ) );
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    @Assert( 0, IsIdenticalObj( RangeCategoryOfHomomorphismStructure( UC ), H ) );
    
    id_d = IdentityMorphism( C, c );
    
    s = ObjectDatum( H, Source( nu ) );
    
    nu_list = MorphismDatum( H, nu );
    
    return MorphismConstructor( UC,
                   source,
                   PairGAP( nu_list, ListWithIdenticalEntries( s, id_d ) ),
                   target );
    
end );

##
@InstallMethod( TensorizeMorphismWithObjectInRangeCategoryOfHomomorphismStructure,
        "for a skeletal category of finite sets, a finite strict coproduct cocompletion, two objects and a morphism in the cocartesian category, and an object in the skeletal category of finite sets",
        [ IsSkeletalCategoryOfFiniteSets,
          FilterIntersection( IsCapCategory, IsFiniteStrictCoproductCompletion, HasRangeCategoryOfHomomorphismStructure ),
          IsCapCategoryObject, IsCapCategoryMorphism, IsSkeletalFiniteSet, IsCapCategoryObject ],
        
  function( H, UC, source, phi, h, target )
    local l;
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    @Assert( 0, IsIdenticalObj( CapCategory( phi ), UnderlyingCategory( UC ) ) );
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    @Assert( 0, IsIdenticalObj( CapCategory( h ), H ) );
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    @Assert( 0, IsIdenticalObj( RangeCategoryOfHomomorphismStructure( UC ), H ) );
    
    l = ObjectDatum( H, h );
    
    return MorphismConstructor( UC,
                   source,
                   PairGAP( (0):(l - 1), ListWithIdenticalEntries( l, phi ) ),
                   target );
    
end );

##
@InstallMethod( TensorizeObjectWithObjectInRangeCategoryOfHomomorphismStructure,
        "for a interval category, a finite strict coproduct cocompletion, an object in the cocartesian category, and an object in the interval category",
        [ IsIntervalCategory,
          FilterIntersection( IsCapCategory, IsFiniteStrictCoproductCompletion, HasRangeCategoryOfHomomorphismStructure ),
          IsCapCategoryObject, IsObjectInIntervalCategory ],
        
  function( H, UC, c, h )
    local l;
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    @Assert( 0, IsIdenticalObj( CapCategory( c ), UnderlyingCategory( UC ) ) );
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    @Assert( 0, IsIdenticalObj( CapCategory( h ), H ) );
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    @Assert( 0, IsIdenticalObj( RangeCategoryOfHomomorphismStructure( UC ), H ) );
    
    l = ObjectDatum( H, h );
    
    return ObjectConstructor( UC, PairGAP( l, ListWithIdenticalEntries( l, c ) ) );
    
end );

##
@InstallMethod( TensorizeObjectWithMorphismInRangeCategoryOfHomomorphismStructure,
        "for a interval category, a finite strict coproduct cocompletion, three objects in the cocartesian category, and a morphism in the interval category",
        [ IsIntervalCategory,
          FilterIntersection( IsCapCategory, IsFiniteStrictCoproductCompletion, HasRangeCategoryOfHomomorphismStructure ),
          IsCapCategoryObject, IsCapCategoryObject, IsMorphismInIntervalCategory, IsCapCategoryObject ],
        
  function( H, UC, source, c, nu, target )
    local C, id_d, s, nu_list;
    
    C = UnderlyingCategory( UC );
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    @Assert( 0, IsIdenticalObj( CapCategory( c ), C ) );
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    @Assert( 0, IsIdenticalObj( CapCategory( nu ), H ) );
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    @Assert( 0, IsIdenticalObj( RangeCategoryOfHomomorphismStructure( UC ), H ) );
    
    id_d = IdentityMorphism( C, c );
    
    s = ObjectDatum( H, Source( nu ) );
    
    nu_list = MorphismDatum( H, nu );
    
    return MorphismConstructor( UC,
                   source,
                   PairGAP( nu_list, ListWithIdenticalEntries( s, id_d ) ),
                   target );
    
end );

##
@InstallMethod( TensorizeMorphismWithObjectInRangeCategoryOfHomomorphismStructure,
        "for a interval category, a finite strict coproduct cocompletion, two objects and a morphism in the cocartesian category, and an object in the interval category",
        [ IsIntervalCategory,
          FilterIntersection( IsCapCategory, IsFiniteStrictCoproductCompletion, HasRangeCategoryOfHomomorphismStructure ),
          IsCapCategoryObject, IsCapCategoryMorphism, IsObjectInIntervalCategory, IsCapCategoryObject ],
        
  function( H, UC, source, phi, h, target )
    local l;
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    @Assert( 0, IsIdenticalObj( CapCategory( phi ), UnderlyingCategory( UC ) ) );
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    @Assert( 0, IsIdenticalObj( CapCategory( h ), H ) );
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    @Assert( 0, IsIdenticalObj( RangeCategoryOfHomomorphismStructure( UC ), H ) );
    
    l = ObjectDatum( H, h );
    
    return MorphismConstructor( UC,
                   source,
                   PairGAP( (0):(l - 1), ListWithIdenticalEntries( l, phi ) ),
                   target );
    
end );

##
@InstallMethod( DatumOfCellAsEvaluatableString,
        [ IsObjectInFiniteStrictCoproductCompletion, IsList ],
        
  function( obj, list_of_evaluatable_strings )
    local list_of_values, datum, data;
    
    list_of_values = List( list_of_evaluatable_strings, EvalString );
    
    datum = ObjectDatum( CapCategory( obj ), obj );
    
    data = List( datum[2], d -> CellAsEvaluatableString( d, list_of_evaluatable_strings ) );
    
    return @Concatenation( "PairGAP( ", StringGAP( datum[1] ), ", [ ", JoinStringsWithSeparator( data, ", " ), " ] )" );
    
end );

##
@InstallMethod( DatumOfCellAsEvaluatableString,
        [ IsMorphismInFiniteStrictCoproductCompletion, IsList ],
        
  function( mor, list_of_evaluatable_strings )
    local list_of_values, datum, data;
    
    list_of_values = List( list_of_evaluatable_strings, EvalString );
    
    datum = MorphismDatum( CapCategory( mor ), mor );
    
    data = List( datum[2], d -> CellAsEvaluatableString( d, list_of_evaluatable_strings ) );
    
    return @Concatenation( "PairGAP( [ ", JoinStringsWithSeparator( datum[1], ", " ), " ], [ ", JoinStringsWithSeparator( data, ", " ), " ] )" );
    
end );

##################################
##
## View & Display
##
##################################

##
@InstallMethod( DisplayString,
        [ IsObjectInFiniteStrictCoproductCompletion ],
        
  function ( a )
    local datum, entries;
    
    datum = ObjectDatum( a );
    
    if (datum[1] == 0)
        entries = " ";
    else
        entries = @Concatenation( " ", JoinStringsWithSeparator( List( datum[2], PrintString ), ", " ), " " );
    end;
    
    return @Concatenation(
              "[ ", StringGAP( datum[1] ), ", [", entries, "] ]",
              "\n\nAn object in ", Name( CapCategory( a ) ), " given by the above data\n" );
    
end );

##
@InstallMethod( DisplayString,
        [ IsMorphismInFiniteStrictCoproductCompletion ],
        
  function ( phi )
    local sFinSets;
    
    sFinSets = ValueGlobal( "SkeletalFinSetsAsFiniteStrictCoproductCompletionOfTerminalCategory" );
    
    return @Concatenation(
        PrintString( ObjectConstructor( sFinSets, PairOfIntAndList( Source( phi ) )[1] ) ),
        " ⱶ", PrintString( PairOfLists( phi )[1] ), "→ ",
        PrintString( ObjectConstructor( sFinSets, PairOfIntAndList( Target( phi ) )[1] ) ), "\n\n",
        StringDisplay( PairOfLists( phi )[2] ), "\n\n",
        "A morphism in ", Name( CapCategory( phi ) ), " given by the above data\n" );
    
end );
