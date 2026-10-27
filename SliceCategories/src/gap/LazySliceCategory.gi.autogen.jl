# SPDX-License-Identifier: GPL-2.0-or-later
# SliceCategories: Slice categories
#
# Implementations
#

##
@InstallMethod( AsSliceCategoryCell,
        "for a list",
        [ IsList ],
        
  function( L )
    local B, S, o;
    
    B = Target( L[1] );
    
    S = LazySliceCategory( B );
    
    return CallFuncListAtRuntime( ObjectConstructor, [ S, L ] );
    
end );

##
@InstallMethod( AsSliceCategoryCell,
        "for a CAP morphism and a CAP lazy slice category",
        [ IsCapCategoryMorphism, IsLazySliceCategory ],
        
  function( m, S )
    
    return ObjectConstructor( S, [ m ] );
    
end );

##
@InstallMethod( /,
        "for a CAP morphism and a CAP lazy slice category",
        [ IsCapCategoryMorphism, IsLazySliceCategory ],
        
  AsSliceCategoryCell );

##
@InstallMethod( AsSliceCategoryCell,
        "for two CAP objects in a lazy slice category and a CAP morphism",
        [ IsObjectInALazySliceCategory, IsCapCategoryMorphism, IsObjectInALazySliceCategory ],
        
  function( source, morphism, range )
    local S, m;
    
    S = CapCategory( source );
    
    return MorphismConstructor( S, source, morphism, range );
    
end );

##
@InstallMethod( UnderlyingMorphism,
        "for a CAP object in a lazy slice category",
        [ IsObjectInALazySliceCategory ],
        
  function( a )
    local L, morphism_from_biased_weak_fiber_product_to_sink;
    
    L = UnderlyingMorphismList( a );
    
    ## this should be handled somewhere else globally
    if (Length( L ) == 1)
        return L[1];
    end;
    
    morphism_from_biased_weak_fiber_product_to_sink = function( I, J )
        return PreCompose( ProjectionOfBiasedWeakFiberProduct( I, J ), I );
    end;
    
    return ObjectConstructor( CapCategory( a ), Iterated( L, morphism_from_biased_weak_fiber_product_to_sink ) );
    
end );
    
##
@InstallMethod( InclusionFunctor,
        [ IsLazySliceCategory ],
        
  function( S )
    local C, name, F;
    
    C = AmbientCategory( S );
    
    name = @Concatenation( "The inclusion functor from ", Name( S ), " in ", Name( C ) );
    
    F = CapFunctor( name, S, C );
    
    AddObjectFunction( F,
      function( a )
        
        return UnderlyingCell( a );
        
    end );
    
    AddMorphismFunction( F,
      function( s, alpha, r )
        
        return UnderlyingCell( alpha );
        
    end );
    
    return F;
    
end );

##
@InstallMethod( LazySliceCategory,
        "for a CAP category object",
        [ IsCapCategoryObject ],
        
  function( B )
    local C, over_tensor_unit,
          name, category_filter, category_object_filter, category_morphism_filter,
          object_constructor, object_datum, S;
    
    C = CapCategory( B );
    
    over_tensor_unit = CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "over_tensor_unit", false );
    
    if (over_tensor_unit)
        name = @Concatenation( "LazySliceCategoryOverTensorUnit( ", Name( C ), " )" );
    else
        name = @Concatenation( "A lazy slice category of ", Name( C ) );
    end;
    
    if (IsIdenticalObj( over_tensor_unit, true ))
        category_filter = IsLazySliceCategoryOverTensorUnit;
        category_object_filter = IsObjectInALazySliceCategoryOverTensorUnit;
        category_morphism_filter = IsMorphismInALazySliceCategoryOverTensorUnit;
    else
        category_filter = IsLazySliceCategory;
        category_object_filter = IsObjectInALazySliceCategory;
        category_morphism_filter = IsMorphismInALazySliceCategory;
    end;
    
    # MorphismConstructor and MorphismDatum are set in CAP_INTERNAL_SLICE_CATEGORY
    # ObjectConstructor and ObjectDatum have to take the lazy/eager structure into account
    
    ##
    object_constructor =
      function( cat, underlying_morphism_list )
        
        if (IsCapCategoryMorphism( underlying_morphism_list ))
            
            underlying_morphism_list = [ underlying_morphism_list ];
            
        end;
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        @Assert( 0, IsDenseList( underlying_morphism_list ) );
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Perform( underlying_morphism_list, function ( mor ) CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY( mor, AmbientCategory( cat ), () -> "some entry of the object datum given to the object constructor of <cat>" ); end );
        
        if (@not ForAll( underlying_morphism_list, morphism -> IsEqualForObjects( Target( morphism ), BaseObject( cat ) ) ))
            
            Error( "the targets of the morphisms and the base object of the slice category S are not equal\n" );
            
        end;
        
        return CreateCapCategoryObjectWithAttributes( S,
                       UnderlyingMorphismList, underlying_morphism_list );
        
    end;
    
    ##
    object_datum =
      function( cat, object )
        
        return UnderlyingMorphismList( object );
        
    end;
    
    S = CAP_INTERNAL_SLICE_CATEGORY( B,
                 over_tensor_unit,
                 name,
                 category_filter,
                 category_object_filter,
                 category_morphism_filter,
                 object_constructor,
                 object_datum );
    
    if (CanCompute( C, "IsSplitEpimorphism" ))
        
        AddIsWeakTerminal( S,
          function( cat, M )
            local mor;
            
            mor = UnderlyingMorphismList( M );
            
            return ForAll( mor, m -> IsSplitEpimorphism( AmbientCategory( cat ), m ) );
            
        end );
        
    end;
    
    ##
    AddDirectProduct( S, # WeakDirectProduct
      function( cat, L )
        local l;
        
        l = L[1];
        
        if (ForAny( L, A -> IsInitial( cat, A ) ))
            return InitialObject( cat, l );
        end;
        
        L = Filtered( L, A -> @not IsTerminal( cat, A ) );
        
        ## this should be handled somewhere else globally
        if (L == [ ])
            return TerminalObject( cat, l );
        elseif (Length( L ) == 1)
            return L[1];
        end;
        
        L = List( L, UnderlyingMorphismList );
        
        L = @Concatenation( L );
        
        l = ObjectConstructor( cat, L );
        
        SetIsTerminal( l, false );
        
        return l;
        
    end );
    
    if (CanCompute( C, "UniversalMorphismFromCoproduct" ))
        
        SetIsCocartesianCategory( S, true );
        
        ##
        AddCoproduct( S,
           function( cat, L )
            local l;
            
            ## triggers radical computations which we want to avoid by all means
            #L = MaximalObjects( L, IsHomSetInhabited );
            ## instead:
            
            l = L[1];
            
            ## testing the membership of 1 might be very expensive for some ideals in the sum
            if (ForAny( L, a -> HasIsTerminal( cat, a ) && IsTerminal( cat, a ) ))
                return TerminalObject( cat, l );
            end;
            
            L = Filtered( L, A -> @not IsInitial( cat, A ) );
            
            ## this should be handled somewhere else globally
            if (L == [ ])
                return InitialObject( cat, l );
            elseif (Length( L ) == 1)
                return L[1];
            end;
            
            L = List( L, UnderlyingMorphism );
            
            L = DuplicateFreeList( L );
            
            ## examples show that the GB computations of the entries of L
            ## (needed to check IsLiftable) might be immensely more expensive
            ## than the GB of the resulting UniversalMorphismFromCoproduct( L ),
            ## so never execute the next line:
            #L = MaximalObjects( L, IsLiftable );
            
            l = UniversalMorphismFromCoproduct( AmbientCategory( cat ), L );
            
            l = ObjectConstructor( cat, l );
            
            SetIsInitial( l, false );
            
            return l;
            
        end );
        
    end;
    
    Finalize( S );
    
    return S;
    
end );

##
@InstallMethod( LazySliceCategoryOverTensorUnit,
        "for a CAP category",
        [ IsCapCategory ],
        
  function( M )
    local S;

    if (!(HasIsMonoidalCategory( M ) && IsMonoidalCategory( M )))

        Error( Name( M ), " is not monoidal\n");

    end;
    
    S = LazySliceCategory( TensorUnit( M ),
                 over_tensor_unit = true );
    
    return S;
    
end );

##################################
##
## View & Display
##
##################################

##
@InstallMethod( ViewString,
    [ IsObjectInALazySliceCategory ],
  function( a )
    
    return @Concatenation( "An object in the lazy slice category given by: ", @Concatenation( List( UnderlyingMorphismList( a ), ViewString ) ) );
    
end );

##
@InstallMethod( ViewString,
    [ IsMorphismInALazySliceCategory ],
  function( phi )
    
    return @Concatenation( "A morphism in the lazy slice category given by: ", ViewString( UnderlyingCell( phi ) ) );
    
end );

##
@InstallMethod( DisplayString,
    [ IsObjectInALazySliceCategory ],
  function( a )
    
    return @Concatenation( DisplayString( UnderlyingMorphism( a ) ), "\nAn object in the lazy slice category given by the above data\n" );
    
end );

##
@InstallMethod( DisplayString,
    [ IsMorphismInALazySliceCategory ],
  function( phi )
    
    return @Concatenation( DisplayString( UnderlyingCell( phi ) ), "\nA morphism in the lazy slice category given by the above data\n" );
    
end );
