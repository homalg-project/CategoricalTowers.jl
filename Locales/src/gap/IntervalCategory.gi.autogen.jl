# SPDX-License-Identifier: GPL-2.0-or-later
# Locales: Locales, frames, coframes, meet semi-lattices of locally closed subsets, and Boolean algebras of constructible sets
#
# Implementations
#

##
@InstallGlobalFunction( "CreateIntervalCategory",
  function( )
    local IntervalCategory;
    
    IntervalCategory =
      CreateCapCategoryWithDataTypes( "IntervalCategory",
              IsIntervalCategory,
              IsObjectInIntervalCategory,
              IsMorphismInIntervalCategory,
              IsCapCategoryTwoCell,
              IsBigInt,
              fail,
              fail );
    
    IntervalCategory.supports_empty_limits = true;
    
    SetDefiningTripleOfUnderlyingQuiver( IntervalCategory,
            Triple( 2, 1, [ PairGAP( 0, 1 ) ] ) );

    IntervalCategory.compiler_hints =
      @rec( category_attribute_names =
           [ "DefiningTripleOfUnderlyingQuiver",
             ] );
    
    SetIsFiniteCategory( IntervalCategory, true );
    
    SetIsBooleanAlgebra( IntervalCategory, true );
    
    SET_RANGE_CATEGORY_Of_HOMOMORPHISM_STRUCTURE( IntervalCategory, IntervalCategory );
    
    SetIsCategoryWithDecidableLifts( IntervalCategory, true );
    SetIsCategoryWithDecidableColifts( IntervalCategory, true );
    
    ## BicartesianCategories.gi: InstallTrueMethod( IsFiniteBicompleteCategory, IsFiniteCompleteCategory and IsFiniteCocompleteCategory );
    #= comment for Julia
    @Assert( 0, IsFiniteBicompleteCategory( IntervalCategory ) );
    # =#
    SetIsFiniteBicompleteCategory( IntervalCategory, true );
    
    ## Poset.gi: InstallTrueMethod( IsPosetCategory, IsThinCategory and IsSkeletalCategory );
    #= comment for Julia
    @Assert( 0, IsPosetCategory( IntervalCategory ) );
    # =#
    SetIsPosetCategory( IntervalCategory, true );
    
    ## BooleanAlgebra.gi, Lattice.gi: Composition of multiple TrueMethods
    #= comment for Julia
    @Assert( 0, IsDistributiveBicartesianProset( IntervalCategory ) );
    # =#
    SetIsDistributiveBicartesianProset( IntervalCategory, true );
    
    ##
    AddObjectConstructor( IntervalCategory,
      function( cat, truth_value )
        
        return CreateCapCategoryObjectWithAttributes( cat,
                       Cardinality, truth_value );
        
    end );
    
    ##
    AddObjectDatum( IntervalCategory,
      function( cat, obj )
        
        return Cardinality( obj );
        
    end );
    
    ##
    AddMorphismConstructor( IntervalCategory,
      function( cat, source, map, range )
        
        return CreateCapCategoryMorphismWithAttributes( cat,
                       source,
                       range,
                       AsList, map );
        
    end );
    
    ##
    AddMorphismDatum( IntervalCategory,
      function( cat, mor )
        
        return AsList( mor );
        
    end );
    
    ##
    AddUniqueMorphism( IntervalCategory,
      function( cat, source, range )
        
        return MorphismConstructor( cat,
                       source,
                       (0):(Cardinality( source ) - 1),
                       range );
        
    end );
    
    ##
    AddIsWellDefinedForObjects( IntervalCategory,
      function( cat, obj )
        
        return ObjectDatum( cat, obj ) == BigInt( 0 ) || ObjectDatum( cat, obj ) == BigInt( 1 );
        
    end );
    
    ##
    AddIsWellDefinedForMorphisms( IntervalCategory,
      function( cat, mor )
        
        return !( IsTerminal( cat, Source( mor ) ) && IsInitial( cat, Target( mor ) ) );
        
    end );
    
    ##
    AddIsEqualForObjects( IntervalCategory,
      function( cat, obj_1, obj_2 )
        
        return IsIdenticalObj( ObjectDatum( cat, obj_1 ), ObjectDatum( cat, obj_2 ) );
        
    end );
    
    ##
    AddIsEqualForMorphisms( IntervalCategory,
      function( cat, mor_1, mor_2 )
        
        return true;
        
    end );
    
    ##
    AddInitialObject( IntervalCategory,
      function( cat )
        
        return ObjectConstructor( cat, BigInt( 0 ) );
        
    end );
    
    ##
    AddIsInitial( IntervalCategory,
      function( cat, a )
        
        return IsEqualForObjects( cat, a, InitialObject( cat ) );
        
    end );
    
    ##
    AddTerminalObject( IntervalCategory,
      function( cat )
        
        return ObjectConstructor( cat, BigInt( 1 ) );
        
    end );
    
    ##
    AddIsTerminal( IntervalCategory,
      function( cat, a )
        
        return IsEqualForObjects( cat, a, TerminalObject( cat ) );
        
    end );
    
    ##
    AddSetOfObjectsOfCategory( IntervalCategory,
      function( cat )
        
        return [ InitialObject( cat ), TerminalObject( cat ) ];
        
    end );
    
    ##
    AddSetOfGeneratingMorphismsOfCategory( IntervalCategory,
      function( cat )
        
        return [ UniversalMorphismIntoTerminalObjectWithGivenTerminalObject( cat,
                       InitialObject( cat ),
                       TerminalObject( cat ) ) ];
        
    end );
    
    ##
    AddCoproduct( IntervalCategory,
      function( cat, L )
        
        if (ForAny( L, obj -> IsTerminal( cat, obj ) ))
            return TerminalObject( cat );
        end;
        
        return InitialObject( cat );
        
    end );
    
    ##
    AddCoexponentialOnObjects( IntervalCategory,
      function( cat, a, b )
        
        if (IsTerminal( cat, a ) || IsInitial( cat, b ))
            return TerminalObject( cat );
        end;
        
        return InitialObject( cat );
        
    end );
    
    ##
    AddDirectProduct( IntervalCategory,
      function( cat, L )
        
        if (ForAny( L, obj -> IsInitial( cat, obj ) ))
            return InitialObject( cat );
        end;
        
        return TerminalObject( cat );
        
    end );
    
    ##
    AddExponentialOnObjects( IntervalCategory,
      function( cat, a, b )
        
        if (IsInitial( cat, a ) || IsTerminal( cat, b ))
            return TerminalObject( cat );
        end;
        
        return InitialObject( cat );
        
    end );
    
    ##
    AddMorphismsOfExternalHom( IntervalCategory,
      function( cat, a, b )
        
        if (IsTerminal( cat, a ) && IsInitial( cat, b ))
            return CapJitTypedExpression( [ ], cat -> CapJitDataTypeOfListOf( CapJitDataTypeOfMorphismOfCategory( cat ) ) );;
        end;
        
        return [ UniqueMorphism( cat, a, b ) ];
        
    end );
    
    ##
    AddExactCoverWithGlobalElements( IntervalCategory,
      function( cat, a )
        
        return MorphismsOfExternalHom( cat, TerminalObject( cat ), a );
        
    end );
    
    Finalize( IntervalCategory );
    
    return IntervalCategory;
    
end );

##
@BindGlobal( "IntervalCategory", CreateIntervalCategory( ) );

##
@InstallMethod( SetOfObjects,
        "for an interval category",
        [ IsIntervalCategory ],
        
  function( cat )
    
    return SetOfObjectsOfCategory( cat );
    
end );

##
@InstallMethod( SetOfGeneratingMorphisms,
        "for an interval category",
        [ IsIntervalCategory ],
        
  function( cat )
    
    return SetOfGeneratingMorphismsOfCategory( cat );
    
end );

##
@InstallGlobalFunction( ADD_COMMON_METHODS_FOR_ENRICHMENT_OVER_INTERVAL_CATEGORY,
  function( preordered_set )
    local V;
    
    V = ValueOption( "range_of_HomStructure" );
    
    if (V == fail)
        V = IntervalCategory;
    elseif (@not IsIntervalCategory( V ))
        Error( "the value `V` of the option key `range_of_HomStructure` is not an interval category\n" );
    end;
    
    SET_RANGE_CATEGORY_Of_HOMOMORPHISM_STRUCTURE( preordered_set, V );
    
end );

##
AddDerivationToCAP( IsHomSetInhabited,
        "IsHomSetInhabited for categories enriched over the interval category",
        [ [ HomomorphismStructureOnObjects, 1 ],
          [ IsInitial, 1, RangeCategoryOfHomomorphismStructure ] ],
        
  function( cat, a, b )
    local range_cat;
    
    range_cat = RangeCategoryOfHomomorphismStructure( cat );
    
    return @not IsInitial( range_cat,
                   HomomorphismStructureOnObjects( cat, a, b ) );
    
end; CategoryGetters = @rec( range_cat = RangeCategoryOfHomomorphismStructure ),
CategoryFilter = function( cat )
      return HasRangeCategoryOfHomomorphismStructure( cat ) &&
             IsIntervalCategory( RangeCategoryOfHomomorphismStructure( cat ) );
  end );

##
AddFinalDerivationBundle( "adding the homomorphism structure using IsHomSetInhabited and IntervalCategory",
        [ [ TerminalObject, 1, RangeCategoryOfHomomorphismStructure ],
          [ IsHomSetInhabited, 1 ],
          [ InitialObject, 1, RangeCategoryOfHomomorphismStructure ],
          [ UniversalMorphismIntoTerminalObjectWithGivenTerminalObject, 1, RangeCategoryOfHomomorphismStructure ],
          [ UniqueMorphism, 1, RangeCategoryOfHomomorphismStructure ],
          [ UniqueMorphism, 1 ],
          ],
        [ DistinguishedObjectOfHomomorphismStructure,
          HomomorphismStructureOnObjects,
          HomomorphismStructureOnMorphisms,
          HomomorphismStructureOnMorphismsWithGivenObjects,
          InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure,
          InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects,
          InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism
          ],
[
  DistinguishedObjectOfHomomorphismStructure,
  [ [ TerminalObject, 1, RangeCategoryOfHomomorphismStructure ] ],
  function ( cat )
    local range_cat;
    
    range_cat = RangeCategoryOfHomomorphismStructure( cat );
    
    return TerminalObject( range_cat );
    
end
],
[
  HomomorphismStructureOnObjects,
  [ [ TerminalObject, 1, RangeCategoryOfHomomorphismStructure ],
    [ IsHomSetInhabited, 1 ],
    [ InitialObject, 1, RangeCategoryOfHomomorphismStructure ] ],
  function ( cat, a, b )
    local range_cat;
    
    range_cat = RangeCategoryOfHomomorphismStructure( cat );
    
    if (IsHomSetInhabited( cat, a, b ))
        return TerminalObject( range_cat );
    else
        return InitialObject( range_cat );
    end;
    
end
],
[
  HomomorphismStructureOnMorphismsWithGivenObjects,
  [ [ UniqueMorphism, 1, RangeCategoryOfHomomorphismStructure ] ],
  function ( cat, s, alpha, gamma, r )
    local range_cat;
    
    range_cat = RangeCategoryOfHomomorphismStructure( cat );
    
    return UniqueMorphism( range_cat, s, r );
    
end
],
[
  InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects,
  [ [ UniversalMorphismIntoTerminalObjectWithGivenTerminalObject, 1, RangeCategoryOfHomomorphismStructure ] ],
  function( cat, t, alpha, r )
    local range_cat;
    
    range_cat = RangeCategoryOfHomomorphismStructure( cat );
    
    return UniversalMorphismIntoTerminalObjectWithGivenTerminalObject( range_cat, t, r );
    
end
],
[
  InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism,
  [ [ UniqueMorphism, 1 ] ],
  function( cat, a, b, iota )
    
    return UniqueMorphism( cat, a, b );
    
end
]; CategoryFilter = function( cat )
      return HasIsThinCategory( cat ) && IsThinCategory( cat ) &&
             HasRangeCategoryOfHomomorphismStructure( cat ) &&
             IsIntervalCategory( RangeCategoryOfHomomorphismStructure( cat ) );
    end,
    CategoryGetters = @rec( range_cat = RangeCategoryOfHomomorphismStructure )
);

####################################
#
# View, Print, and Display methods:
#
####################################

##
@InstallMethod( PrintString,
        "for an object in an interval category",
        [ IsObjectInIntervalCategory ],
        
  function( obj )
    
    if (ObjectDatum( obj ) == 0)
        return "<(⊥)>";
    elseif (ObjectDatum( obj ) == 1)
        return "<(⊤)>";
    else
        Error( "ObjectDatum( obj ) is not in [ 0, 1 ]\n" );
    end;
    
end );

##
@InstallMethod( ViewString,
        "for an object in an interval category",
        [ IsObjectInIntervalCategory ],
        
  function( obj )
    
    return PrintString( obj );
    
end );

##
@InstallMethod( DisplayString,
        "for an object in an interval category",
        [ IsObjectInIntervalCategory ],
        
  function( obj )
    
    return @Concatenation( ViewString( obj ), "\n" );
    
end );

##
@InstallMethod( ViewString,
        "for a morphism in an interval category",
        [ IsMorphismInIntervalCategory ],
        
  function( mor )
    local obj;
    
    if (IsEndomorphism( mor ))
        obj = Source( mor );
        if (ObjectDatum( obj ) == 0)
            return "(⊥)-[(⊥)]->(⊥)";
        elseif (ObjectDatum( obj ) == 1)
            return "(⊤)-[(⊤)]->(⊤)";
        else
            Error( "ObjectDatum( obj ) is not in [ 0, 1 ]\n" );
        end;
    elseif (IsInitial( Source( mor ) ) && IsTerminal( Target( mor ) ))
        return "(⊥)-[(⇒)]->(⊤)";
    else
        Error( "the morphism <mor> of the interval category is not well-defined\n" );
    end;
    
end );

##
@InstallMethod( PrintString,
        "for a morphism in an interval category",
        [ IsMorphismInIntervalCategory ],
        
  ViewString );

##
@InstallMethod( DisplayString,
        "for a morphism in an interval category",
        [ IsMorphismInIntervalCategory ],
        
  function( mor )
    
    return @Concatenation( ViewString( mor ), "\n" );
    
end );
