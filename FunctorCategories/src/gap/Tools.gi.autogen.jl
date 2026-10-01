# SPDX-License-Identifier: GPL-2.0-or-later
# FunctorCategories: Categories of functors
#
# Implementations
#

#= comment for Julia
##
@InstallMethod( QUO,
        [ IsMatrix, FilterIntersection( IsCapCategory, HasCommutativeSemiringOfLinearCategory ) ],
        
  function ( mat, A )
    
    return HomalgMatrix( mat, CommutativeSemiringOfLinearCategory( A ) ) / A;
    
end );
# =#

##
## Required for Julia: set conjunction-derived lattice/Heyting properties that GAP infers via InstallTrueMethod conjunctions but Julia cannot;
## call on the modeling category of the finite (co)completion before WrapperCategory.
@BindGlobal( "ADD_CONJUNCTION_DERIVED_LATTICE_PROPERTIES",
  function ( cat )
    
    ## BicartesianCategories.gi: InstallTrueMethod( IsBicartesianClosedCategory, IsBicartesianCategory and IsCartesianClosedCategory );
    if (HasIsBicartesianCategory( cat ) && IsBicartesianCategory( cat ) &&
       HasIsCartesianClosedCategory( cat ) && IsCartesianClosedCategory( cat ))
      #= comment for Julia
      @Assert( 0, HasIsBicartesianClosedCategory( cat ), "Expected cat to have IsBicartesianClosedCategory property" );
      # =#
      SetIsBicartesianClosedCategory( cat, true );
    end;
    
    ## BicartesianCategories.gi: InstallTrueMethod( IsBicartesianCoclosedCategory, IsBicartesianCategory and IsCocartesianCoclosedCategory );
    if (HasIsBicartesianCategory( cat ) && IsBicartesianCategory( cat ) &&
       HasIsCocartesianCoclosedCategory( cat ) && IsCocartesianCoclosedCategory( cat ))
      #= comment for Julia
      @Assert( 0, HasIsBicartesianCoclosedCategory( cat ), "Expected cat to have IsBicartesianCoclosedCategory property" );
      # =#
      SetIsBicartesianCoclosedCategory( cat, true );
    end;
    
    ## Lattice.gi: InstallTrueMethod( IsStrictCartesianCategory, IsPosetCategory and IsCartesianCategory );
    if (HasIsPosetCategory( cat ) && IsPosetCategory( cat ) &&
       HasIsCartesianCategory( cat ) && IsCartesianCategory( cat ))
      #= comment for Julia
      @Assert( 0, HasIsStrictCartesianCategory( cat ), "Expected cat to have IsStrictCartesianCategory property" );
      # =#
      SetIsStrictCartesianCategory( cat, true );
    end;
    
    ## Lattice.gi: InstallTrueMethod( IsStrictCocartesianCategory, IsPosetCategory and IsCocartesianCategory );
    if (HasIsPosetCategory( cat ) && IsPosetCategory( cat ) &&
       HasIsCocartesianCategory( cat ) && IsCocartesianCategory( cat ))
      #= comment for Julia
      @Assert( 0, HasIsStrictCocartesianCategory( cat ), "Expected cat to have IsStrictCocartesianCategory property" );
      # =#
      SetIsStrictCocartesianCategory( cat, true );
    end;
    
    ## Lattice.gi: InstallTrueMethod( IsCartesianProset, IsThinCategory and IsCartesianCategory );
    if (HasIsThinCategory( cat ) && IsThinCategory( cat ) &&
       HasIsCartesianCategory( cat ) && IsCartesianCategory( cat ))
      #= comment for Julia
      @Assert( 0, HasIsCartesianProset( cat ), "Expected cat to have IsCartesianProset property" );
      # =#
      SetIsCartesianProset( cat, true );
    end;
    
    ## Lattice.gi: InstallTrueMethod( IsCocartesianProset, IsThinCategory and IsCocartesianCategory );
    if (HasIsThinCategory( cat ) && IsThinCategory( cat ) &&
       HasIsCocartesianCategory( cat ) && IsCocartesianCategory( cat ))
      #= comment for Julia
      @Assert( 0, HasIsCocartesianProset( cat ), "Expected cat to have IsCocartesianProset property" );
      # =#
      SetIsCocartesianProset( cat, true );
    end;
    
    ## Lattice.gi: InstallTrueMethod( IsBicartesianProset, IsCartesianProset and IsCocartesianProset );
    if (HasIsCartesianProset( cat ) && IsCartesianProset( cat ) &&
       HasIsCocartesianProset( cat ) && IsCocartesianProset( cat ))
      #= comment for Julia
      @Assert( 0, HasIsBicartesianProset( cat ), "Expected cat to have IsBicartesianProset property" );
      # =#
      SetIsBicartesianProset( cat, true );
    end;
    
    ## Lattice.gi: InstallTrueMethod( IsMeetSemiLattice, IsCartesianProset and IsSkeletalCategory );
    if (HasIsCartesianProset( cat ) && IsCartesianProset( cat ) &&
       HasIsSkeletalCategory( cat ) && IsSkeletalCategory( cat ))
      #= comment for Julia
      @Assert( 0, HasIsMeetSemiLattice( cat ), "Expected cat to have IsMeetSemiLattice property" );
      # =#
      SetIsMeetSemiLattice( cat, true );
    end;
    
    ## Lattice.gi: InstallTrueMethod( IsJoinSemiLattice, IsCocartesianProset and IsSkeletalCategory );
    if (HasIsCocartesianProset( cat ) && IsCocartesianProset( cat ) &&
       HasIsSkeletalCategory( cat ) && IsSkeletalCategory( cat ))
      #= comment for Julia
      @Assert( 0, HasIsJoinSemiLattice( cat ), "Expected cat to have IsJoinSemiLattice property" );
      # =#
      SetIsJoinSemiLattice( cat, true );
    end;
    
    ## Lattice.gi: InstallTrueMethod( IsLattice, IsMeetSemiLattice and IsJoinSemiLattice );
    if (HasIsMeetSemiLattice( cat ) && IsMeetSemiLattice( cat ) &&
       HasIsJoinSemiLattice( cat ) && IsJoinSemiLattice( cat ))
      #= comment for Julia
      @Assert( 0, HasIsLattice( cat ), "Expected cat to have IsLattice property" );
      # =#
      SetIsLattice( cat, true );
    end;
    
    ## Lattice.gi: InstallTrueMethod( IsDistributiveBicartesianProset, IsBicartesianProset and IsDistributiveCategory );
    if (HasIsBicartesianProset( cat ) && IsBicartesianProset( cat ) &&
       HasIsDistributiveCategory( cat ) && IsDistributiveCategory( cat ))
      #= comment for Julia
      @Assert( 0, HasIsDistributiveBicartesianProset( cat ), "Expected cat to have IsDistributiveBicartesianProset property" );
      # =#
      SetIsDistributiveBicartesianProset( cat, true );
    end;
    
    ## Lattice.gi: InstallTrueMethod( IsDistributiveLattice, IsDistributiveBicartesianProset and IsSkeletalCategory );
    if (HasIsDistributiveBicartesianProset( cat ) && IsDistributiveBicartesianProset( cat ) &&
       HasIsSkeletalCategory( cat ) && IsSkeletalCategory( cat ))
      #= comment for Julia
      @Assert( 0, HasIsDistributiveLattice( cat ), "Expected cat to have IsDistributiveLattice property" );
      # =#
      SetIsDistributiveLattice( cat, true );
    end;
    
    ## Lattice.gi: InstallTrueMethod( IsBiHeytingAlgebroid, IsDistributiveBicartesianProset and IsEquivalentToFiniteCategory );
    if (HasIsDistributiveBicartesianProset( cat ) && IsDistributiveBicartesianProset( cat ) &&
       HasIsEquivalentToFiniteCategory( cat ) && IsEquivalentToFiniteCategory( cat ))
      #= comment for Julia
      @Assert( 0, HasIsBiHeytingAlgebroid( cat ), "Expected cat to have IsBiHeytingAlgebroid property" );
      # =#
      SetIsBiHeytingAlgebroid( cat, true );
    end;
    
    ## BooleanAlgebra.gi: InstallTrueMethod( IsBiHeytingAlgebra, IsBiHeytingAlgebroid and IsSkeletalCategory );
    if (HasIsBiHeytingAlgebroid( cat ) && IsBiHeytingAlgebroid( cat ) &&
       HasIsSkeletalCategory( cat ) && IsSkeletalCategory( cat ))
      #= comment for Julia
      @Assert( 0, HasIsBiHeytingAlgebra( cat ), "Expected cat to have IsBiHeytingAlgebra property" );
      # =#
      SetIsBiHeytingAlgebra( cat, true );
    end;
    
    ## HeytingAlgebra.gi: InstallTrueMethod( IsHeytingAlgebra, IsHeytingAlgebroid and IsSkeletalCategory );
    if (HasIsHeytingAlgebroid( cat ) && IsHeytingAlgebroid( cat ) &&
       HasIsSkeletalCategory( cat ) && IsSkeletalCategory( cat ))
      #= comment for Julia
      @Assert( 0, HasIsHeytingAlgebra( cat ), "Expected cat to have IsHeytingAlgebra property" );
      # =#
      SetIsHeytingAlgebra( cat, true );
    end;
    
    ## CoHeytingAlgebra.gi: InstallTrueMethod( IsCoHeytingAlgebra, IsCoHeytingAlgebroid and IsSkeletalCategory );
    if (HasIsCoHeytingAlgebroid( cat ) && IsCoHeytingAlgebroid( cat ) &&
       HasIsSkeletalCategory( cat ) && IsSkeletalCategory( cat ))
      #= comment for Julia
      @Assert( 0, HasIsCoHeytingAlgebra( cat ), "Expected cat to have IsCoHeytingAlgebra property" );
      # =#
      SetIsCoHeytingAlgebra( cat, true );
    end;
    
    ## BicartesianCategories.gi: InstallTrueMethod( IsFiniteBicompleteCategory, IsFiniteCompleteCategory and IsFiniteCocompleteCategory );
    if (HasIsFiniteCompleteCategory( cat ) && IsFiniteCompleteCategory( cat ) &&
       HasIsFiniteCocompleteCategory( cat ) && IsFiniteCocompleteCategory( cat ))
      #= comment for Julia
      @Assert( 0, HasIsFiniteBicompleteCategory( cat ), "Expected cat to have IsFiniteBicompleteCategory property" );
      # =#
      SetIsFiniteBicompleteCategory( cat, true );
    end;
    
end );
