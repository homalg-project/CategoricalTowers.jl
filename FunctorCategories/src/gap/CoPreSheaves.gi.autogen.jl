# SPDX-License-Identifier: GPL-2.0-or-later
# FunctorCategories: Categories of functors
#
# Implementations
#

####################################
#
# methods for operations:
#
####################################

##
@InstallMethod( ApplyObjectInCoPreSheafCategoryToObject,
        "for an object in a copresheaf category and a CAP object",
        [ IsCoPreSheafCategory, IsObjectInCoPreSheafCategory, IsCapCategoryObject ],
        
  function ( coPSh, F, objB )
    local pos;
    
    pos = SafePosition( SetOfObjects( Source( coPSh ) ), objB );
    
    return ValuesOfCoPreSheaf( F )[1][pos];
    
end );

##
@InstallMethod( UnderlyingCapTwoCategoryCell,
        "for an object in a copresheaf category",
        [ IsCoPreSheafCategory, IsObjectInCoPreSheafCategory ],
        
  function ( coPSh, F )
    local values;
    
    values = ValuesOfCoPreSheaf( F );
    
    return CapFunctor( Source( coPSh ), values[1], values[2], Target( coPSh ) );
    
end );

##
@InstallMethod( UnderlyingCapTwoCategoryCell,
        "for an object in a copresheaf category",
        [ IsObjectInCoPreSheafCategory ],
        
  function ( F )
    
    return UnderlyingCapTwoCategoryCell( CapCategory( F ), F );
    
end );

##
@InstallMethod( ApplyObjectInCoPreSheafCategoryToMorphism,
        "for an object in a copresheaf category and a CAP morphism",
        [ IsCoPreSheafCategory, IsObjectInCoPreSheafCategory, IsCapCategoryMorphism ],
        
  function ( coPSh, F, morB )
    local pos;
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    pos = Position( SetOfGeneratingMorphisms( Source( coPSh ) ), morB );
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    if (IsInt( pos ))
        return ValuesOfCoPreSheaf( F )[2][pos];
    end;
    
    return FunctorMorphismOperation( UnderlyingCapTwoCategoryCell( coPSh, F ) )(
                   ApplyObjectInCoPreSheafCategoryToObject( coPSh, F, Source( morB ) ),
                   morB,
                   ApplyObjectInCoPreSheafCategoryToObject( coPSh, F, Target( morB ) ) );
    
end );

##
@InstallMethod( ApplyMorphismInCoPreSheafCategoryToObject,
        "for a morphism in a copresheaf category and a CAP object",
        [ IsCoPreSheafCategory, IsMorphismInCoPreSheafCategory, IsCapCategoryObject ],
        
  function ( coPSh, eta, objB )
    local pos;
    
    pos = SafePosition( SetOfObjects( Source( coPSh ) ), objB );
    
    return ValuesOnAllObjects( eta )[pos];
    
end );

##
@InstallMethod( CallFuncList,
        "for an object in a copresheaf category and a list",
        [ IsObjectInCoPreSheafCategory, IsList ],
        
  function ( F, L )
    local coPSh;
    
    coPSh = CapCategory( F );
    
    if (IsCapCategoryObject( L[1] ))
        return ApplyObjectInCoPreSheafCategoryToObject( coPSh, F, L[1] );
    elseif (IsCapCategoryMorphism( L[1] ))
        return ApplyObjectInCoPreSheafCategoryToMorphism( coPSh, F, L[1] );
    end;
    
    Error( "the argument ", L[1], " is neither an object nor a morphism in ", Source( F ), "\n" );
    
end );

##
@InstallMethod( CallFuncList,
        "for a morphism in a copresheaf category and a list",
        [ IsMorphismInCoPreSheafCategory, IsList ],
        
  function ( eta, L )
    
    if (IsCapCategoryObject( L[1] ))
        return ApplyMorphismInCoPreSheafCategoryToObject( CapCategory( eta ), eta, L[1] );
    end;
    
    Error( "the argument ", L[1], " is not an object in ", Source( Source( eta ) ), "\n" );
    
end );

##
@InstallMethod( /,
        "for an object in a copresheaf category and a string",
        [ IsString, IsObjectInCoPreSheafCategory ],
        
  function ( name, F )
    
    return F( Source( F )[name] );
    
end );

#= comment for Julia
##
@InstallMethod( \.,
        "for an object in a copresheaf category and positive integer",
        [ IsObjectInCoPreSheafCategory, IsPosInt ],
        
  function ( F, string_as_int )
    
    return F( Source( F )[NameRNam( string_as_int ]) );
    
end );
# =#

##
@InstallMethod( /,
        "for a morphism in a copresheaf category and a string",
        [ IsString, IsMorphismInCoPreSheafCategory ],
        
  function ( name, eta )
    
    return eta( Source( Source( eta ) )[name] );
    
end );

#= comment for Julia
##
@InstallMethod( \.,
        "for a morphism in a copresheaf category and positive integer",
        [ IsMorphismInCoPreSheafCategory, IsPosInt ],
        
  function ( eta, string_as_int )
    
    return eta( Source( Source( eta ) )[NameRNam( string_as_int ]) );
    
end );
# =#

####################################
#
# methods for constructors:
#
####################################

##
@InstallMethod( CreateCoPreSheafByValues,
        "for a copresheaf category and two lists",
        [ IsCoPreSheafCategory, IsList ],
        
  function ( coPSh, values_of_copresheaf )
    
    return ObjectConstructor( coPSh, values_of_copresheaf );
    
end );

##
@InstallMethod( CreateCoPreSheafByValues,
        "for a copresheaf category and two lists",
        [ IsCoPreSheafCategory, IsList, IsList ],
        
  function ( coPSh, values_of_all_objects, values_of_all_generating_morphisms )
    
    return CreateCoPreSheafByValues( coPSh,
                   PairGAP( values_of_all_objects, values_of_all_generating_morphisms ) );
    
end );

##
@InstallMethod( CreateCoPreSheafByFunctions,
        "for a copresheaf category and two functions",
        [ IsCoPreSheafCategory, IsFunction, IsFunction ],
        
  function ( coPSh, copresheaf_on_objects, copresheaf_on_generating_morphisms )
    local defining_triple, nr_objs, nr_mors, mors, values_of_all_objects, values_of_all_generating_morphisms;
    
    defining_triple = DefiningTripleOfUnderlyingQuiver( Source( coPSh ) );
    
    nr_objs = defining_triple[1];
    nr_mors = defining_triple[2];
    mors = defining_triple[3];
    
    values_of_all_objects = LazyHList( (1):(nr_objs), o -> copresheaf_on_objects( o ) );
    values_of_all_generating_morphisms = LazyHList( (1):(nr_mors), m -> copresheaf_on_generating_morphisms(
                                                  copresheaf_on_objects( 1 + mors[m][1] ),
                                                  m,
                                                  copresheaf_on_objects( 1 + mors[m][2] ) ) );
    
    return CreateCoPreSheafByValues( coPSh, values_of_all_objects, values_of_all_generating_morphisms );
    
end );

##
@InstallMethod( CreateCoPreSheaf,
        "for a copresheaf category and a CAP functor",
        [ IsCoPreSheafCategory, IsCapFunctor ],
        
  function ( coPSh, F )
    local B, objs, mors, copresheaf_on_objects, copresheaf_on_generating_morphism;
    
    B = Source( coPSh );
    
    objs = SetOfObjects( B );
    mors = SetOfGeneratingMorphisms( B );
    
    copresheaf_on_objects = objB_index -> FunctorObjectOperation( F )( objs[objB_index] );
    copresheaf_on_generating_morphism = ( source, morB_index, range ) -> FunctorMorphismOperation( F )( source, mors[morB_index], range );
    
    return CreateCoPreSheafByFunctions( coPSh, copresheaf_on_objects, copresheaf_on_generating_morphism );
    
end );

##
@InstallMethod( CreateCoPreSheaf,
        "for a CAP functor",
        [ IsCapFunctor ],
        
  function ( F )
    local coPSh;
    
    coPSh = CoPreSheaves( SourceOfFunctor( F ), RangeOfFunctor( F ) );
    
    return CreateCoPreSheaf( coPSh, F );
    
end );

##
@InstallMethod( CreateCoPreSheaf,
        "for a CAP category, a record (of images of objects) and a record (of images of morphisms)",
        [ IsCapCategory, IsRecord, IsRecord ],
        
  function ( B, rec_images_of_objects, rec_images_of_morphisms )
    
    return CreateCoPreSheaf( CapFunctor( B, rec_images_of_objects, rec_images_of_morphisms ) );
    
end );

##
@InstallMethod( CreateCoPreSheaf,
        "for a CAP category, a list (of images of objects) and a list (of images of morphisms)",
        [ IsCapCategory, IsList, IsList ],
        
  function ( B, images_of_objects, images_of_morphisms )
    
    if (IsEmpty( images_of_objects ))
        Error( "the list of images is empty\n" );
    end;
    
    return CreateCoPreSheaf( CapFunctor( B, images_of_objects, images_of_morphisms, CapCategory( images_of_objects[1] ) ) );
    
end );

##
#= comment for Julia (requires Algebroids)
if (IsPackageMarkedForLoading( "Algebroids", ">= 2026.07-04" ))

@InstallMethod( CreateCoPreSheaf,
        "for a copresheaf category and two lists",
        [ IsCoPreSheafCategory && HasRangeCategoryOfHomomorphismStructure, IsList, IsList ],
        
  function ( coPSh, dims, matrices )
    local kmat, objects, morphisms, k, mat;
    
    if (dims == [ ])
        Error( "the list of dimensions is empty\n" );
    elseif (@not IsInt( dims[1] ))
        Error( "expecting a list of integers as the second argument but received ", dims, "\n" );
    end;
    
    kmat = RangeCategoryOfHomomorphismStructure( coPSh );
        
    if (!( IsMatrixCategory( kmat ) || IsCategoryOfRows( kmat ) ))
        TryNextMethod( );
    end;
    
    objects = List( dims, dim -> dim / kmat );
    
    morphisms = SetOfGeneratingMorphisms( Source( coPSh ) );
    
    k = CommutativeSemiringOfLinearCategory( kmat );
    
    mat =
      function ( m )
        local source, target;
        
        source = VertexIndex( UnderlyingVertex( Source( morphisms[m] ) ) );
        target = VertexIndex( UnderlyingVertex( Target( morphisms[m] ) ) );
        
        if (IsHomalgMatrix( matrices[m] ))
            m = matrices[m];
        else
            m = HomalgMatrix( One( k ) * matrices[m], dims[source], dims[target], k );
        end;
        
        return m / kmat;
        
    end;
    
    morphisms = List( (1):(Length( morphisms )), mat );
    
    return CreateCoPreSheafByValues( coPSh, objects, morphisms );
    
end );

end; # IsPackageMarkedForLoading( "Algebroids", ">= 2026.07-04" )
# =#

##
@InstallMethod( CreateCoPreSheafMorphismByValues,
        "for a copresheaf category, two objects in the copresheaf category, and a list",
        [ IsCoPreSheafCategory, IsObjectInCoPreSheafCategory, IsList, IsObjectInCoPreSheafCategory ],
        
  function ( coPSh, source, values_on_all_objects, range )
    
    return MorphismConstructor( coPSh, source, values_on_all_objects, range );
    
end );

##
@InstallMethod( CreateCoPreSheafMorphism,
        "for a copresheaf category, two objects in the copresheaf category, and a function",
        [ IsCoPreSheafCategory, IsObjectInCoPreSheafCategory, IsFunction, IsObjectInCoPreSheafCategory ],
        
  function ( coPSh, source, natural_transformation_on_objects, range )
    local nr_objs, source_values, range_values, values_on_all_objects;
    
    nr_objs = DefiningTripleOfUnderlyingQuiver( Source( coPSh ) )[1];
    
    source_values = ValuesOfCoPreSheaf( source )[1];
    range_values = ValuesOfCoPreSheaf( range )[1];
    
    values_on_all_objects = LazyHList( (1):(nr_objs),
                                     o -> natural_transformation_on_objects( source_values[o], o, range_values[o] ) );
    
    return CreateCoPreSheafMorphismByValues( coPSh, source, values_on_all_objects, range );
    
end );

##
@InstallMethod( CreateCoPreSheafMorphism,
        "for a copresheaf category and a CAP natural transformation",
        [ IsCoPreSheafCategory, IsCapNaturalTransformation ],
        
  function ( coPSh, eta )
    local B, objs;
    
    B = Source( coPSh );
    
    objs = SetOfObjects( B );
    
    return CreateCoPreSheafMorphism( coPSh,
                   CreateCoPreSheaf( Source( eta ) ),
                   ( source, objB_index, range ) -> NaturalTransformationOperation( eta )( source, objs[objB_index], range ),
                   CreateCoPreSheaf( Target( eta ) ) );
    
end );

##
@InstallMethod( CreateCoPreSheafMorphism,
        "for a CAP natural transformation",
        [ IsCapNaturalTransformation ],
        
  function ( eta )
    local F, coPSh;
    
    F = Source( eta );
    
    coPSh = CoPreSheaves( SourceOfFunctor( F ), RangeOfFunctor( F ) );
    
    return CreateCoPreSheafMorphism( coPSh, eta );
    
end );

##
@InstallMethod( CreateCoPreSheafMorphism,
        "for a record and two objects in a copresheaf category",
        [ IsObjectInCoPreSheafCategory, IsRecord, IsObjectInCoPreSheafCategory ],
        
  function ( U, e, V )
    local eta;

    eta = NaturalTransformation(
                   e,
                   UnderlyingCapTwoCategoryCell( U ),
                   UnderlyingCapTwoCategoryCell( V ) );
    
    return CreateCoPreSheafMorphism( eta );
    
end );

##
@InstallMethod( CreateCoPreSheafMorphism,
        "for two objects in a copresheaf category and a list",
        [ IsObjectInCoPreSheafCategory, IsList, IsObjectInCoPreSheafCategory ],
        
  function ( U, e, V )
    local kmat;
    
    if (@not IsEmpty( e ) && IsHomalgMatrix( e[1] ))
        
        kmat = Target( U );
        
        e = List( e, mat -> mat / kmat );
        
    end;
    
    return CreateCoPreSheafMorphismByValues( CapCategory( U ), U, e, V );
    
end );

##
InstallMethodWithCache( CoPreSheaves,
        "for a CAP category",
        [ IsCapCategory, IsCapCategory ],
        
  @FunctionWithNamedArguments(
  [ [ "no_precompiled_code", false ],
    [ "FinalizeCategory", true ],
    [ "overhead", true ]
  ],
  function ( CAP_NAMED_ARGUMENTS, B, D )
    local name, category_filter, category_object_filter, category_morphism_filter,
          object_datum_type, object_constructor, object_datum,
          morphism_datum_type, morphism_constructor, morphism_datum,
          Hom, O,
          modeling_tower_object_constructor, modeling_tower_object_datum,
          modeling_tower_morphism_constructor, modeling_tower_morphism_datum,
          coPSh, properties;
    
    ##
    name = @Concatenation( "CoPreSheaves( ", Name( B ), ", ", Name( D ), " )" );
    
    ##
    category_filter = IsCoPreSheafCategory;
    category_object_filter = IsObjectInCoPreSheafCategory;
    category_morphism_filter = IsMorphismInCoPreSheafCategory;
    
    ##
    object_datum_type =
      CapJitDataTypeOfNTupleOf( 2,
              CapJitDataTypeOfListOf( CapJitDataTypeOfObjectOfCategory( D ) ),
              CapJitDataTypeOfListOf( CapJitDataTypeOfMorphismOfCategory( D ) ) );
    
    object_constructor =
      function( coPSh, values_of_copresheaf )
          
          return CreateCapCategoryObjectWithAttributes( coPSh,
                        Source, Source( coPSh ),
                        Target, Target( coPSh ),
                        ValuesOfCoPreSheaf, values_of_copresheaf );
      end;
    
    object_datum = ( coPSh, o ) -> ValuesOfCoPreSheaf( o );
    
    ##
    morphism_datum_type =
      CapJitDataTypeOfListOf( CapJitDataTypeOfMorphismOfCategory( D ) );
    
    morphism_constructor =
      function( coPSh, source, values_on_all_objects, range )
          
          return CreateCapCategoryMorphismWithAttributes( coPSh,
                        source,
                        range,
                        ValuesOnAllObjects, values_on_all_objects );
      end;
    
    morphism_datum = ( coPSh, m ) -> ValuesOnAllObjects( m );
    
    ## building the categorical tower:
    
    Hom = FunctorCategory( B, D; FinalizeCategory = true, overhead = overhead );
    
    O = Opposite( Hom; only_primitive_operations_and_hom_structure = true, FinalizeCategory = true );
    
    if (HasIsInitialCategory( B ) && IsInitialCategory( B ))
        @Assert( 0, [ ] == MissingOperationsForConstructivenessOfCategory( O, "IsEquippedWithHomomorphismStructure" ) );
    end;
    
    ## from the raw object data to the object in the modeling category
    modeling_tower_object_constructor =
      function( coPSh, pair )
        local O, Hom;
        
        O = ModelingCategory( coPSh );
        
        Hom = OppositeCategory( O );
        
        return ObjectConstructor( O,
                       ObjectConstructor( Hom,
                               pair ) );
        
    end;
    
    ## from the object in the modeling category to the raw object data
    modeling_tower_object_datum =
      function( coPSh, obj )
        local O, Hom;
        
        O = ModelingCategory( coPSh );
        
        Hom = OppositeCategory( O );
        
        return ObjectDatum( Hom,
                       ObjectDatum( O,
                               obj ) );
        
    end;
    
    ## from the raw morphism data to the morphism in the modeling category
    modeling_tower_morphism_constructor =
      function( coPSh, source, images, range )
        local O, Hom;
        
        O = ModelingCategory( coPSh );
        
        Hom = OppositeCategory( O );
        
        return MorphismConstructor( O,
                       source,
                       MorphismConstructor( Hom,
                               ObjectDatum( O, range ),
                               images,
                               ObjectDatum( O, source ) ),
                       range );
        
    end;
    
    ## from the morphism in the modeling category to the raw morphism data
    modeling_tower_morphism_datum =
      function( coPSh, mor )
        local O, Hom;
        
        O = ModelingCategory( coPSh );
        
        Hom = OppositeCategory( O );
        
        return MorphismDatum( Hom,
                       MorphismDatum( O,
                               mor ) );
        
    end;
    
    ##
    coPSh =
      ReinterpretationOfCategory( O,
              @rec( name = name,
                   category_filter = category_filter,
                   category_object_filter = category_object_filter,
                   category_morphism_filter = category_morphism_filter,
                   object_datum_type = object_datum_type,
                   morphism_datum_type = morphism_datum_type,
                   object_constructor = object_constructor,
                   object_datum = object_datum,
                   morphism_constructor = morphism_constructor,
                   morphism_datum = morphism_datum,
                   modeling_tower_object_constructor = modeling_tower_object_constructor,
                   modeling_tower_object_datum = modeling_tower_object_datum,
                   modeling_tower_morphism_constructor = modeling_tower_morphism_constructor,
                   modeling_tower_morphism_datum = modeling_tower_morphism_datum,
                   only_primitive_operations = true )
             ; FinalizeCategory = false, overhead = overhead );
    
    SetSource( coPSh, B );
    SetTarget( coPSh, D );
    
    Append( coPSh.compiler_hints.category_attribute_names,
            [ "Source",
              "Target",
              ] );
    
    if (FinalizeCategory)
        Finalize( coPSh );
    end;
    
    return coPSh;
    
end ) );

##
#= comment for Julia (requires Algebroids)
if (IsPackageMarkedForLoading( "Algebroids", ">= 2026.07-04" ))

InstallMethodWithCache( CoPreSheaves,
        "for a CAP category and a homalg field",
        [ IsFpAlgebroidDefinedByQuiverAlgebra, IsHomalgRing && IsFieldForHomalg ],
        
  function ( B, k )
    local kmat, coPSh;
    
    if (HasRangeCategoryOfHomomorphismStructure( B ))
        
        kmat = RangeCategoryOfHomomorphismStructure( B );
        
    else
        
        kmat = CategoryOfRows( k );
        
    end;
    
    @Assert( 0, IsMatrixCategory( kmat ) || IsCategoryOfRows( kmat ) );
    
    CapCategorySwitchLogicOn( kmat );
    
    coPSh = CoPreSheaves( B, kmat );
    
    CapCategorySwitchLogicOn( coPSh );
    
    return coPSh;
    
end );

end; # IsPackageMarkedForLoading( "Algebroids", ">= 2026.07-04" )
# =#

##
@InstallMethod( CoPreSheaves,
        "for a CAP category",
        [ IsCapCategory ],
        
  @FunctionWithNamedArguments(
  [
    [ "FinalizeCategory", true ],
    [ "overhead", true ],
    [ "no_precompiled_code", false ],
  ],
  function( CAP_NAMED_ARGUMENTS, B )
    
    if (@not HasRangeCategoryOfHomomorphismStructure( B ))
        TryNextMethod( );
    end;
    
    return CoPreSheaves( B, RangeCategoryOfHomomorphismStructure( B ),
              FinalizeCategory = FinalizeCategory,
              overhead = overhead,
              no_precompiled_code = no_precompiled_code );
    
end ) );

##
@InstallMethod( SetOfObjects,
        "for a copresheaf category",
        [ IsCoPreSheafCategory ],
        
  function( coPSh )
    
    return SetOfObjectsOfCategory( coPSh );
    
end );

##
@InstallMethod( SetOfGeneratingMorphisms,
        "for a copresheaf category",
        [ IsCoPreSheafCategory ],
        
  function( coPSh )
    
    return SetOfGeneratingMorphismsOfCategory( coPSh );
    
end );

####################################
#
# Methods for attributes
#
####################################

##
@InstallMethod( CoYonedaEmbeddingDataOfSourceCategory,
        [ IsCoPreSheafCategory ],
        
  function ( coPSh )
    local B, coyoneda_data, coYoneda_on_objs, coYoneda_on_mors;
    
    B = Source( coPSh );
    
    coyoneda_data = CoYonedaEmbeddingData( B );
    
    coYoneda_on_objs =
      function ( obj )
        local Yobj;
        
        Yobj = CreateCoPreSheafByValues( coPSh, coyoneda_data[1]( obj ) );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        SetIsInjective( Yobj, true );
        
        return Yobj;
        
    end;
    
    coYoneda_on_mors =
      function ( source, mor, target )
        local source_on_objs, target_on_objs;
        
        source_on_objs = ObjectDatum( coPSh, source )[1];
        target_on_objs = ObjectDatum( coPSh, target )[1];
        
        return CreateCoPreSheafMorphismByValues( coPSh,
                       source,
                       coyoneda_data[2]( source_on_objs, mor, target_on_objs ),
                       target );
        
    end;
    
    return PairGAP( coYoneda_on_objs, coYoneda_on_mors );
    
end );

##
@InstallMethod( CoYonedaEmbeddingOfSourceCategory,
        "for a copresheaf category",
        [ IsCoPreSheafCategory ],
        
  function ( coPSh )
    local B, coYoneda, coYoneda_data;
    
    B = Source( coPSh );
    
    coYoneda = CapFunctor( "co-Yoneda embedding functor", B, coPSh );
    
    coYoneda_data = CoYonedaEmbeddingDataOfSourceCategory( coPSh );
    
    AddObjectFunction( coYoneda, coYoneda_data[1] );
    
    AddMorphismFunction( coYoneda,  coYoneda_data[2] );
    
    return coYoneda;
    
end );

##
@InstallMethod( CoYonedaEmbedding,
        [ IsCapCategory ],
        
  function ( B )
    
    if (@not HasRangeCategoryOfHomomorphismStructure( B ))
        TryNextMethod( );
    end;
    
    return CoYonedaEmbeddingOfSourceCategory( CoPreSheaves( B ) );
    
end );

##
@InstallMethod( /,
        "for a copresheaf category and a string",
        [ IsString, IsCoPreSheafCategory ],
        
  function( name, coPSh )
    local coY, F, coYc;
    
    coY = CoYonedaEmbeddingOfSourceCategory( coPSh );
    
    F = SourceOfFunctor( coY );
    
    coYc = CallFuncListAtRuntime( ApplyFunctor, [ coY, F[name] ] );
    
    if (IsObjectInPreSheafCategory( coYc ))
        
        SetIsProjective( coYc, true );
        
    elseif (IsMorphismInPreSheafCategory( coYc ))
        
        if (CanCompute( coPSh, "IsMonomorphism" ))
            IsMonomorphism( coYc );
        end;
        
        if (CanCompute( coPSh, "IsSplitMonomorphism" ))
            IsSplitMonomorphism( coYc );
        end;
        
        if (CanCompute( coPSh, "IsEpimorphism" ))
            IsEpimorphism( coYc );
        end;
        
        if (CanCompute( coPSh, "IsSplitEpimorphism" ))
            IsSplitEpimorphism( coYc );
        end;
        
        ## IsIsomorphism == IsSplitMonomorphism and IsSplitEpimorphism
        ## we add this here in case the logic is deactivated
        if (CanCompute( coPSh, "IsIsomorphism" ))
            IsIsomorphism( coYc );
        end;
        
    end;
    
    return coYc;
    
end );

#= comment for Julia
INSTALL_DOT_METHOD( IsCoPreSheafCategory );
# =#

####################################
#
# View, Print, Display and LaTeX methods:
#
####################################

##
#= comment for Julia (requires Algebroids)
if (IsPackageMarkedForLoading( "Algebroids", ">= 2026.07-04" ))

@InstallMethod( ViewString,
        [ IsObjectInCoPreSheafCategory ],
        
  function ( F )
    local algebroid, vertices, arrows, v_dim, v_string, a_dim, a_string, string;
    
    if (!(IsMatrixCategory( Target( CapCategory( F ) ) ) || IsCategoryOfRows( Target( CapCategory( F ) ) )))
        TryNextMethod();
    end;
    
    algebroid = Source( CapCategory( F ) );
    
    vertices = List( SetOfObjects( algebroid ), UnderlyingVertex );
    
    v_dim = List( ValuesOfCoPreSheaf( F )[1], ObjectDatum );
    
    v_string = ListN( vertices, v_dim, ( vertex, dim ) -> @Concatenation( "(", StringGAP( vertex ), ")->", StringGAP( dim ) ) );
    
    v_string = JoinStringsWithSeparator( v_string, ", " );
    
    arrows = List( SetOfGeneratingMorphisms( algebroid ), UnderlyingQuiverAlgebraElement );
    
    if (@not IsPathAlgebra( UnderlyingQuiverAlgebra( algebroid ) ))
      
      arrows = List( arrows, a -> Paths( Representative( a ) )[ 1 ] );
      
    else
      
      arrows = List( arrows, a -> Paths( a )[ 1 ] );
      
    end;
    
    a_dim = List( ValuesOfCoPreSheaf( F )[2], m -> [ ObjectDatum( Source( m ) ), ObjectDatum( Target( m ) ) ] );
    
    a_string = ListN( arrows, a_dim,
                  ( arrow, dim ) -> @Concatenation(
                      "(", StringGAP( arrow ), ")->", StringGAP( dim[ 1 ] ), "x", StringGAP( dim[ 2 ] ) )
                    );
    
    a_string = JoinStringsWithSeparator( a_string, ", " );
    
    string = @Concatenation( v_string, "; ", a_string );
    
    return @Concatenation( "<", string, ">" );
    
end );

end; # IsPackageMarkedForLoading( "Algebroids", ">= 2026.07-04" )
# =#

##
@InstallMethod( DisplayString,
        [ IsObjectInCoPreSheafCategory ],
        
  function ( F )
    local objects, images_of_objects, string, i, morphisms, images_of_morphisms;
    
    objects = SetOfObjects( Source( F ) );
    
    images_of_objects = ValuesOfCoPreSheaf( F )[1];
    
    string = "";
    
    for i in (1):(Length( objects ))
        
        string = @Concatenation( string,
                          "Image of ", ViewString( objects[i] ), ":\n",
                          StringDisplay( images_of_objects[i] ),
                          "\n" );
        
    end;
    
    morphisms = SetOfGeneratingMorphisms( Source( F ) );
    
    images_of_morphisms = ValuesOfCoPreSheaf( F )[2];
    
    for i in (1):(Length( morphisms ))
        
        string = @Concatenation( string,
                          "Image of ", StringView( morphisms[i] ), ":\n",
                          StringDisplay( images_of_morphisms[i] ),
                          "\n" );
        
    end;
    
    return @Concatenation( string,
                   "An object in ", Name( CapCategory( F ) ), " given by the above data\n" );
    
end );

##
#= comment for Julia (requires Algebroids)
if (IsPackageMarkedForLoading( "Algebroids", ">= 2026.07-04" ))

@InstallMethod( ViewString,
        [ IsMorphismInCoPreSheafCategory ],
        
  function ( eta )
    local vertices, s_dim, r_dim, string;
    
    if (!(IsMatrixCategory( Target( CapCategory( eta ) ) ) || IsCategoryOfRows( Target( CapCategory( eta ) ) )))
        TryNextMethod();
    end;
    
    vertices = List( SetOfObjects( Source( Source( eta ) ) ), UnderlyingVertex );
     
    s_dim = List( ValuesOfCoPreSheaf( Source( eta ) )[1], ObjectDatum );
    
    r_dim = List( ValuesOfCoPreSheaf( Target( eta ) )[1], ObjectDatum );
   
    string = ListN( vertices, s_dim, r_dim,
                ( vertex, s, r ) ->
                    @Concatenation( "(", StringGAP( vertex ), ")->", StringGAP( s ), "x", StringGAP( r ) ) );
    
    string = JoinStringsWithSeparator( string, ", " );
    
    return @Concatenation( "<", string, ">" );
    
end );

end; # IsPackageMarkedForLoading( "Algebroids", ">= 2026.07-04" )
# =#

##
@InstallMethod( DisplayString,
        [ IsMorphismInCoPreSheafCategory ],
        
  function ( eta )
    local objects, images_of_objects, string, i;
    
    objects = SetOfObjects( Source( Source( eta ) ) );
    
    images_of_objects = ValuesOnAllObjects( eta );
    
    string = "";
    
    for i in (1):(Length( objects ))
        
        string = @Concatenation( string,
                          "Image of ", ViewString( objects[i] ), ":\n",
                          StringDisplay( images_of_objects[i] ),
                          "\n" );
        
    end;
    
    return @Concatenation( string,
                   "A morphism in ", Name( CapCategory( eta ) ), " given by the above data\n" );
    
end );

##
@InstallMethod( LaTeXOutput,
          [ IsObjectInCoPreSheafCategory ],
          
  function( F )
    local objs, v_objs, mors, v_mors, s, i;
    
    objs = SetOfObjects( Source( F ) );
    v_objs = ValuesOfCoPreSheaf( F )[1];
    
    mors = SetOfGeneratingMorphisms( Source( F ) );
    v_mors = ValuesOfCoPreSheaf( F )[2];
    
    s = "\\begin[array][ccc]\n ";
    
    for i in (1):(Length( objs ))
      
      s = @Concatenation(
              s,
              LaTeXOutput( objs[ i ] ),
              " & \\mapsto & ",
              LaTeXOutput( v_objs[ i ] ),
              " \\\\ "
            );
      
    end;
    
    s = @Concatenation( s, "\\hline & & \\\\" );
    
    for i in (1):(Length( mors ))
      
      s = @Concatenation(
              s,
              LaTeXOutput( mors[ i ]; OnlyDatum = true ),
              " & \\mapsto & ",
              LaTeXOutput( v_mors[ i ]; OnlyDatum = false ),
              " \\\\ & & \\\\"
            );
    end;
    
    s = @Concatenation( s, "\\end[array]" );
    
    return s;
    
end );

##
@InstallMethod( LaTeXOutput,
          [ IsMorphismInCoPreSheafCategory ],
          
  @FunctionWithNamedArguments(
  [
    [ "OnlyDatum", false ],
  ],
  function( CAP_NAMED_ARGUMENTS, eta )
    local objs, v_objs, i, datum;
    
    objs = SetOfObjects( Source( Source( eta ) ) );
    
    v_objs = ValuesOnAllObjects( eta );
    
    datum = "\\begin[array][ccc]\n";
    
    for i in (1):(Length( objs ))
      
      datum = @Concatenation(
                  datum,
                  LaTeXOutput( objs[ i ] ),
                  " & \\mapsto & ",
                  LaTeXOutput( v_objs[ i ]; OnlyDatum = false ),
                  " \\\\ & & \\\\" );
    
    end;
    
    datum = @Concatenation( datum, "\\end[array]" );
    
    if (OnlyDatum == true)
      
      return datum;
      
    else
      
      return @Concatenation(
                LaTeXOutput( Source( eta ) ),
                "\\xrightarrow[",
                datum,
                "]",
                LaTeXOutput( Target( eta ) )
              );
    
    end;
    
end ) );
