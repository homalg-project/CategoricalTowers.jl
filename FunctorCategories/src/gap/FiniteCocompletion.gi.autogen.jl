# SPDX-License-Identifier: GPL-2.0-or-later
# FunctorCategories: Categories of functors
#
# Implementations
#

##
InstallMethodWithCache( FiniteCocompletion,
        "for a CAP category",
        [ IsCapCategory, IsCapCategory ],
        
  function( fp_category, range_category_of_hom_structure )
    local name, category_filter, category_object_filter, category_morphism_filter,
          PSh,
          finite_cocompletion;
    
    ##
    name = @Concatenation( "FiniteCocompletion( ", Name( fp_category ), " )" );
    
    ##
    category_filter = IsFiniteCocompletion;
    category_object_filter = IsObjectInFiniteCocompletion;
    category_morphism_filter = IsMorphismInFiniteCocompletion;
    
    ## building the categorical tower:
    
    PSh = PreSheaves( fp_category, range_category_of_hom_structure; FinalizeCategory = true, overhead = false );
    
    ##
    finite_cocompletion =
      WrapperCategory( PSh,
              @rec( name = name,
                   category_filter = category_filter,
                   category_object_filter = category_object_filter,
                   category_morphism_filter = category_morphism_filter,
                   only_primitive_operations = true )
              );
    
    SetUnderlyingCategory( finite_cocompletion, fp_category );
    
    return finite_cocompletion;
    
end );

##
@InstallMethod( FiniteCocompletion,
        "for a CAP category",
        [ IsCapCategory ],
        
  function( fp_category )
    
    if (@not HasRangeCategoryOfHomomorphismStructure( fp_category ))
        TryNextMethod( );
    end;
    
    return FiniteCocompletion( fp_category, RangeCategoryOfHomomorphismStructure( fp_category ) );
    
end );

##
@InstallMethod( EmbeddingOfUnderlyingCategory,
        "for a finite cocompletion category",
        [ IsFiniteCocompletion ],
        
  function( finite_cocompletion )
    local Y;
    
    Y = YonedaEmbeddingOfSourceCategory( ModelingCategory( finite_cocompletion ) );
    
    return PreCompose( Y, WrappingFunctor( finite_cocompletion ) );
    
end );

##
@InstallMethod( /,
        "for a string and a finite cocompletion category",
        [ IsString, IsFiniteCocompletion ],
        
  function( name, finite_cocompletion )
    local F, Y, Yc;
    
    F = UnderlyingCategory( finite_cocompletion );
    
    Y = EmbeddingOfUnderlyingCategory( finite_cocompletion );
    
    Yc = CallFuncListAtRuntime( ApplyFunctor, [ Y, F[name] ] );
    
    if (IsObjectInFiniteCocompletion( Yc ))
        
        SetIsProjective( Yc, true );
        
    elseif (IsMorphismInFiniteCocompletion( Yc ))
        
        #if CanCompute( finite_cocompletion, "IsMonomorphism" ))
        #    IsMonomorphism( Yc );
        #fi;
        
        #if CanCompute( finite_cocompletion, "IsSplitMonomorphism" ))
        #    IsSplitMonomorphism( Yc );
        #fi;
        
        #if CanCompute( finite_cocompletion, "IsEpimorphism" ))
        #    IsEpimorphism( Yc );
        #fi;
        
        #if CanCompute( finite_cocompletion, "IsSplitEpimorphism" ))
        #    IsSplitEpimorphism( Yc );
        #fi;
        
        ## IsIsomorphism == IsSplitMonomorphism and IsSplitEpimorphism
        ## we add this here in case the logic is deactivated
        if (CanCompute( finite_cocompletion, "IsIsomorphism" ))
            IsIsomorphism( Yc );
        end;
        
    end;
    
    return Yc;
    
end );

#= comment for Julia
##
INSTALL_DOT_METHOD( IsFiniteCocompletion );
# =#

##
@InstallMethod( /,
        "for a string and a cell in a finite cocompletion category",
        [ IsString, IsCellInFiniteCocompletion ],
        
  function( name, cell )
    
    return UnderlyingCell( cell )[name];
    
end );

#= comment for Julia
INSTALL_DOT_METHOD( IsCellInFiniteCocompletion );
# =#

##
@InstallMethod( SetOfObjects,
        "for a finite cocompletion category",
        [ IsFiniteCocompletion ],
        
  function( finite_cocompletion )
    
    return SetOfObjectsOfCategory( finite_cocompletion );
    
end );

##
@InstallMethod( SetOfGeneratingMorphisms,
        "for a finite cocompletion category",
        [ IsFiniteCocompletion ],
        
  function( finite_cocompletion )
    
    return SetOfGeneratingMorphismsOfCategory( finite_cocompletion );
    
end );
