# SPDX-License-Identifier: GPL-2.0-or-later
# FunctorCategories: Categories of functors
#
# Implementations
#

##
InstallMethodWithCache( FreeDistributiveCompletion,
        "for a CAP category",
        [ IsCapCategory, IsCapCategory ],
        
  function( fp_category, range_category_of_hom_structure )
    local name, category_filter, category_object_filter, category_morphism_filter,
          finite_completion, finite_cocompletion,
          free_distributive_completion;
    
    ##
    name = @Concatenation( "FreeDistributiveCompletion( ", Name( fp_category ), " )" );
    
    ##
    category_filter = IsFreeDistributiveCompletion;
    category_object_filter = IsObjectInFreeDistributiveCompletion;
    category_morphism_filter = IsMorphismInFreeDistributiveCompletion;
    
    ## building the categorical tower:
    
    finite_completion = FiniteCompletion( fp_category, range_category_of_hom_structure
                            #= comment for julia (Temporarily)
                           ; overhead = false
                            # =#
                            );
    
    finite_cocompletion = FiniteCocompletion( finite_completion, range_category_of_hom_structure
                            #= comment for julia (Temporarily)
                           ; overhead = false
                            # =#
                            );
    
    ##
    free_distributive_completion =
      WrapperCategory( finite_cocompletion,
              @rec( name = name,
                   category_filter = category_filter,
                   category_object_filter = category_object_filter,
                   category_morphism_filter = category_morphism_filter,
                   only_primitive_operations = true )
              );
    
    SetUnderlyingCategory( free_distributive_completion, fp_category );
    
    if (HasIsInitialCategory( fp_category ) && IsInitialCategory( fp_category ))
        @Assert( 0, [ ] == MissingOperationsForConstructivenessOfCategory( free_distributive_completion, "IsEquippedWithHomomorphismStructure" ) );
    end;
    
    return free_distributive_completion;
    
end );

##
@InstallMethod( FreeDistributiveCompletion,
        "for a CAP category",
        [ IsCapCategory ],
        
  function( fp_category )
    
    @Assert( 0, HasRangeCategoryOfHomomorphismStructure( fp_category ) );
    
    return FreeDistributiveCompletion( fp_category, RangeCategoryOfHomomorphismStructure( fp_category ) );
    
end );

##
@InstallMethod( EmbeddingOfUnderlyingCategory,
        "for a free distributive completion category",
        [ IsFreeDistributiveCompletion ],
        
  function( free_distributive_completion )
    local D, Y;
    
    D = ModelingCategory( free_distributive_completion );
    
    Y = PreCompose(
                 EmbeddingOfUnderlyingCategory( UnderlyingCategory( D ) ),
                 EmbeddingOfUnderlyingCategory( D ) );
    
    return PreCompose( Y, WrappingFunctor( free_distributive_completion ) );
    
end );

##
@InstallMethod( /,
        "for a string and a free distributive completion category",
        [ IsString, IsFreeDistributiveCompletion ],
        
  function( name, free_distributive_completion )
    local F, Y, Yc;
    
    F = UnderlyingCategory( free_distributive_completion );
    
    Y = EmbeddingOfUnderlyingCategory( free_distributive_completion );
    
    Yc = CallFuncListAtRuntime( ApplyFunctor, [ Y,  F[name] ] );
    
    if (IsObjectInFreeDistributiveCompletion( Yc ))
        
        SetIsProjective( Yc, true );
        
    elseif (IsMorphismInFreeDistributiveCompletion( Yc ))
        
        #if CanCompute( free_distributive_completion, "IsMonomorphism" ))
        #    IsMonomorphism( Yc );
        #fi;
        
        #if CanCompute( free_distributive_completion, "IsSplitMonomorphism" ))
        #    IsSplitMonomorphism( Yc );
        #fi;
        
        #if CanCompute( free_distributive_completion, "IsEpimorphism" ))
        #    IsEpimorphism( Yc );
        #fi;
        
        #if CanCompute( free_distributive_completion, "IsSplitEpimorphism" ))
        #    IsSplitEpimorphism( Yc );
        #fi;
        
        ## IsIsomorphism == IsSplitMonomorphism and IsSplitEpimorphism
        ## we add this here in case the logic is deactivated
        #if CanCompute( free_distributive_completion, "IsIsomorphism" ))
        #    IsIsomorphism( Yc );
        #fi;
        
    end;
    
    return Yc;
    
end );

##
@InstallMethod( /,
        "for a string and an object in a free distributive completion category",
        [ IsString, IsObjectInFreeDistributiveCompletion ],
        
  function( name, object )
    
    return UnderlyingCell( object )[name];
    
end );

##
@InstallMethod( /,
        "for a string and a morphism in a free distributive completion category",
        [ IsString, IsMorphismInFreeDistributiveCompletion ],
        
  function( name, morphism )
    
    return UnderlyingCell( morphism )[name];
    
end );

#=
INSTALL_DOT_METHOD( IsFreeDistributiveCompletion );
INSTALL_DOT_METHOD( IsObjectInFreeDistributiveCompletion );
INSTALL_DOT_METHOD( IsMorphismInFreeDistributiveCompletion );
# =#

##
@InstallMethod( SetOfObjects,
        "for a free distributive completion category",
        [ IsFreeDistributiveCompletion ],
        
  function( free_distributive_completion )
    
    return SetOfObjectsOfCategory( free_distributive_completion );
    
end );

##
@InstallMethod( SetOfGeneratingMorphisms,
        "for a free distributive completion category",
        [ IsFreeDistributiveCompletion ],
        
  function( free_distributive_completion )
    
    return SetOfGeneratingMorphismsOfCategory( free_distributive_completion );
    
end );
