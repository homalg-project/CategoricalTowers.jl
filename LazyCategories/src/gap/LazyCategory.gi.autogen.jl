# SPDX-License-Identifier: GPL-2.0-or-later
# LazyCategories: Construct an equivalent lazy category out of a CAP category
#
# Implementations
#

##
SetInfoLevel( InfoLazyCategory, 1 );

##
@InstallGlobalFunction( _EvaluationOfCell,
  function( c )
    
    return CallFuncList( ValueGlobal( GenesisOfCellOperation( c ) ),
                   List( GenesisOfCellArguments( c ), EvaluatedCell ) );
    
end );

##
@BindGlobal( "EVALUATED_CELL_IN_LAZY_CATEGORY",
  
  function( c )
    local C, show, count, result;
    
    C = CapCategory( c );
    
    show = C.show_evaluation;
    
    count = C.evaluations + 1;
    
    C.evaluations = count;
    
    if (show)
        Print( count, ".", FillWithCharacterAfterDecimalNumber( count, ' ', 7 ), ListWithIdenticalEntries( Log2Int( count ), ' ' ), "-> evaluating in ", C.shortname, ": ", GenesisOfCellOperation( c ), "\n" );
    else
        @Info( InfoLazyCategory, 2, count, ".", FillWithCharacterAfterDecimalNumber( count, ' ', 7 ), ListWithIdenticalEntries( Log2Int( count ), ' ' ), "-> evaluating in ", C.shortname, ": ", GenesisOfCellOperation( c ) );
    end;
    
    result = _EvaluationOfCell( c );
    
    if (show)
        Print( count, ".", FillWithCharacterAfterDecimalNumber( count, ' ', 7 ), ListWithIdenticalEntries( Log2Int( count ), ' ' ), "<- evaluated in ", C.shortname, ": ", GenesisOfCellOperation( c ), "\n" );
    else
        @Info( InfoLazyCategory, 2, count, ".", FillWithCharacterAfterDecimalNumber( count, ' ', 7 ), ListWithIdenticalEntries( Log2Int( count ), ' ' ), "<- evaluated in ", C.shortname, ": ", GenesisOfCellOperation( c ) );
    end;
    
    return result;
    
end );

##
@InstallMethod( EvaluatedCell,
        "for an object in a lazy category",
        [ IsObjectInLazyCategory ],

  EVALUATED_CELL_IN_LAZY_CATEGORY );

##
@InstallMethod( EvaluatedCell,
        "for a morphism in a lazy category",
        [ IsMorphismInLazyCategory ],

  EVALUATED_CELL_IN_LAZY_CATEGORY );

##
@InstallMethod( EvaluatedCell,
        "for a lazy category and an object therein",
        [ IsLazyCategory, IsObjectInLazyCategory ],
        
  function( C, c )
    
    return EvaluatedCell( c );
    
end );

##
@InstallMethod( EvaluatedCell,
        "for a lazy category and a morphism therein",
        [ IsLazyCategory, IsMorphismInLazyCategory ],
        
  function( C, c )
    
    return EvaluatedCell( c );
    
end );

##
@InstallMethod( EvaluatedCell,
        "for a lazy category",
        [ IsLazyCategory ],

  function( L )
    
    return UnderlyingCategory( L );
    
end );

##
@InstallMethod( EvaluatedCell,
        "for a list",
        [ IsList ],

  function( L )
    
    return List( L, EvaluatedCell );
    
end );

##
@InstallMethod( EvaluatedCell,
        "for a ring element",
        [ IsRingElement ],

  IdFunc );

##
@InstallMethod( SetLabel,
        "for a lazy category object and a string",
        [ IsObjectInLazyCategory, IsString ],

  function( c, str )
    
    c.Label = str;
    
end );

##
@InstallMethod( SetLabel,
        "for a lazy category morphism and a string",
        [ IsMorphismInLazyCategory, IsString ],

  function( c, str )
    
    c.Label = str;
    
end );

##
@InstallMethod( GetLabel,
        "for a CAP category object",
        [ IsCapCategoryObject ],
        
  function( o )
    local datum, label;
    
    if (@IsBound( o.Label ))
        return o.Label;
    end;
    
    if (@not CanCompute( CapCategory( o ), "ObjectDatum" ))
        return fail;
    end;
    
    datum = ObjectDatum( o );
    
    if (IsList( datum ))
        if (@not Length( datum ) == 1)
            return fail;
        end;
        datum = datum[1];
    end;
    
    if (@not IsCapCategoryCell( datum ))
        return fail;
    end;
    
    label = GetLabel( datum );
    
    o.Label = label;
    
    return label;
    
end );

##
@InstallMethod( GetLabel,
        "for a CAP category morphism",
        [ IsCapCategoryMorphism ],
        
  function( m )
    local datum, label;
    
    if (@IsBound( m.Label ))
        return m.Label;
    end;
    
    if (!( HasMorphismDatum( m ) || CanCompute( CapCategory( m ), "MorphismDatum" ) ))
        return fail;
    end;
    
    datum = MorphismDatum( m );
    
    if (IsList( datum ))
        if (!( Length( datum ) == 1 && IsList( datum[1] ) && Length( datum[1] ) == 1 ))
            return fail;
        end;
        datum = datum[1,1];
    end;
    
    if (@not IsCapCategoryCell( datum ))
        return fail;
    end;
    
    label = GetLabel( datum );
    
    m.Label = label;
    
    return label;
    
end );

##
@InstallMethod( GetLabel,
        "for a CAP category object",
        [ IsCellInLazyCategory ],
        
  function( c )
    local label;
    
    if (@IsBound( c.Label ))
        return c.Label;
    end;
    
    label = GetLabel( EvaluatedCell( c ) );
    
    if (@not label == fail)
        SetLabel( c, label );
    end;
    
    return label;
    
end );

##
@InstallMethod( IsEqualForCells,
        "for two lazy categories",
        [ IsLazyCategory, IsLazyCategory ],

  IsIdenticalObj );

##
@InstallMethod( IsEqualForCells,
        "for two CAP objects",
        [ IsCapCategoryObject, IsCapCategoryObject ],

  IsEqualForObjects );

##
@InstallMethod( IsEqualForCells,
        "for two CAP morphisms",
        [ IsCapCategoryMorphism, IsCapCategoryMorphism ],

  IsEqualForMorphismsOnMor );

##
@InstallMethod( IsEqualForCells,
        "for two lists",
        [ IsList, IsList ],

  function( L1, L2 )
    local l;

    l = Length( L1 );
    
    return l == Length( L2 ) &&
           ForAll( (1):(l), i -> IsEqualForCells( L1[i], L2[i] ) );
    
end );

##
@InstallMethod( IsEqualForCells,
        "for two ring elements",
        [ IsRingElement, IsRingElement ],
        
    function( a, b )
    
        return a == b;
    
end );

##
InstallMethodWithCache( AsObjectInLazyCategory,
        "for a lazy category and a CAP object",
        [ IsLazyCategory, IsCapCategoryObject ],
        
  function( D, object )
    
    if (@not IsIdenticalObj( CapCategory( object ), UnderlyingCategory( D ) ))
        
        Error( "the given object should belong to the underlying category: ", Name( UnderlyingCategory( D ) ), "\n" );
        
    end;
    
    return CreateCapCategoryObjectWithAttributes( D,
                   EvaluatedCell, object );
    
end );

##
@InstallMethod( AsObjectInLazyCategory,
        "for a lazy category, a string, and a list",
        [ IsLazyCategory, IsString, IsList ],
        
  function( D, name_of_operation, list_of_arguments )
    
    if (@not IsStringRep( name_of_operation ))
        TryNextMethod( );
    end;
    
    return ObjectConstructor( D, PairGAP( name_of_operation, list_of_arguments ) );
    
end );

##
@InstallMethod( AsMorphismInLazyCategory,
        "for two CAP objects in a lazy category and a CAP morphism",
        [ IsObjectInLazyCategory, IsCapCategoryMorphism, IsObjectInLazyCategory ],
        
  function( source, morphism, range )
    local D;
    
    D = CapCategory( source );
    
    if (@not IsIdenticalObj( CapCategory( morphism ), UnderlyingCategory( D ) ))
        
        Error( "the given morphism should belong to the underlying category: ", Name( UnderlyingCategory( D ) ), "\n" );
        
    end;
    
    return CreateCapCategoryMorphismWithAttributes( D,
                   source,
                   range,
                   EvaluatedCell, morphism );
    
end );

##
InstallMethodWithCache( AsMorphismInLazyCategory,
        "for a lazy category and a CAP morphism",
        [ IsLazyCategory, IsCapCategoryMorphism ],
        
  function( D, morphism )
    
    return AsMorphismInLazyCategory(
                   AsObjectInLazyCategory( D, Source( morphism ) ),
                   morphism,
                   AsObjectInLazyCategory( D, Target( morphism ) ) );
    
end );

##
@InstallMethod( AsMorphismInLazyCategory,
        "for two CAP objects in a lazy category, a string, and a list",
        [ IsLazyCategory, IsObjectInLazyCategory, IsString, IsList, IsObjectInLazyCategory ],
        
  function( D, source, name_of_operation, list_of_arguments, range )
    
    if (@not IsStringRep( name_of_operation ))
        TryNextMethod( );
    end;
    
    return MorphismConstructor( D,
                   source,
                   PairGAP( name_of_operation, list_of_arguments ),
                   range );
    
end );

##
@InstallMethod( AsMorphismInLazyCategory,
        "for two CAP objects in a lazy category, a string, and a list",
        [ IsObjectInLazyCategory, IsString, IsList, IsObjectInLazyCategory ],
        
  function( source, name_of_operation, list_of_arguments, range )
    
    if (@not IsStringRep( name_of_operation ))
        TryNextMethod( );
    end;
    
    return AsMorphismInLazyCategory( CapCategory( source ),
                   source,
                   name_of_operation, list_of_arguments,
                   range );
    
end );

##
@InstallMethod( GenesisOfCellOperation,
        "for an object in a lazy category",
        [ IsObjectInLazyCategory ],
        
  function( c )
    
    return GenesisOfCell( c )[1];
    
end );

##
@InstallMethod( GenesisOfCellOperation,
        "for a morphism in a lazy category",
        [ IsMorphismInLazyCategory ],
        
  function( c )
    
    return GenesisOfCell( c )[1];
    
end );

##
@InstallMethod( GenesisOfCellArguments,
        "for an object in a lazy category",
        [ IsObjectInLazyCategory ],
        
  function( c )
    
    return GenesisOfCell( c )[2];
    
end );

##
@InstallMethod( GenesisOfCellArguments,
        "for a morphism in a lazy category",
        [ IsMorphismInLazyCategory ],
        
  function( c )
    
    return GenesisOfCell( c )[2];
    
end );

##
@InstallMethod( LazyCategory,
        "for a CAP category",
        [ IsCapCategory ],
        
  @FunctionWithNamedArguments(
    [
        [ "optimize", 2 ],
        [ "show_evaluation", false ],
        [ "primitive_operations", false ],
        [ "cache", true ],
        [ "print", false ],
        [ "lazify_range_of_hom_structure", false ],
    ],
  function ( CAP_NAMED_ARGUMENTS, C )
    local name, category_filter, category_object_filter, category_morphism_filter,
          object_constructor, object_datum, morphism_constructor, morphism_datum,
          create_func_bool, create_func_object,
          create_func_morphism, create_func_universal_morphism,
          create_func_list_of_objects, list_of_operations_to_install, skip, func, pos,
          commutative_semiring, properties, ignore, supports_empty_limits, category_constructor_options,
          D, list, HC;
    
    ##
    if (HasName( C ))
        name = @Concatenation( "LazyCategory( ", Name( C ), " )" );
    else
        name = "lazy category";
    end;
    
    ##
    category_filter = IsLazyCategory;
    category_object_filter = IsObjectInLazyCategory;
    category_morphism_filter = IsMorphismInLazyCategory;
    
    ##
    object_constructor =
      function( D, object_operation_and_arguments_genesis_pair )
        
        @Assert( 0, IsCapCategory( object_operation_and_arguments_genesis_pair[2][1] ) );
        
        return CreateCapCategoryObjectWithAttributes( D,
                       GenesisOfCell, object_operation_and_arguments_genesis_pair );
        
    end;
    
    object_datum = ( D, obj ) -> GenesisOfCell( obj );
    
    morphism_constructor =
      function( D, source, morphism_operation_and_arguments_genesis_pair, range )
        
        return CreateCapCategoryMorphismWithAttributes( D,
                       source,
                       range,
                       GenesisOfCell, morphism_operation_and_arguments_genesis_pair );
        
    end;
    
    morphism_datum = ( D, mor ) -> GenesisOfCell( mor );
    
    ## e.g., IsSplitEpimorphism
    create_func_bool =
      function( name, D )
        
        return PairGAP( """
          function( input_arguments... )
            
            return operation_name( underlying_arguments... );
            
        end""", OperationWeight( C, name ) );
        
    end;
    
    ## e.g., ZeroObject, DirectSum
    create_func_object =
      function( name, D )
        
        return PairGAP( """
          function( input_arguments... )
            
            return top_object_getter( cat, PairGAP( "operation_name", [ input_arguments... ] ) );
            
        end""", OperationWeight( C, name ) );
        
    end;
    
    ## e.g., ZeroObjectFunctorial, IdentityMorphism, PreCompose
    create_func_morphism =
      function( name, D )
        
        return PairGAP( """
          function( input_arguments... )
            
            return top_morphism_getter( cat, top_source, PairGAP( "operation_name", [ input_arguments... ] ), top_range );
            
        end""", OperationWeight( C, name ) );
        
    end;
    
    create_func_list_of_objects =
      function( name, D )
        
        return PairGAP( """
          function( input_arguments... )
            local underlying_result;
            
            underlying_result = operation_name( underlying_arguments... );
            
            return List( underlying_result, object -> top_object_getter( cat, object ) );
            
        end""", OperationWeight( C, name ) );
        
    end;
    
    if (primitive_operations)
        list_of_operations_to_install = ListPrimitivelyInstalledOperationsOfCategoryWhereMorphismOperationsAreReplacedWithCorrespondingObjectAndWithGivenOperations( C );
    else
        list_of_operations_to_install = ListInstalledOperationsOfCategory( C );
    end;
    
    list_of_operations_to_install = ShallowCopy( list_of_operations_to_install );
    
    skip = [ "IsWellDefinedForObjects",
              "IsEqualForObjects",
              "IsWellDefinedForMorphisms",
              "IsEqualForMorphisms",
              "IsCongruentForMorphisms",
              "IsEqualForMorphismsOnMor",
              "IsEqualToIdentityMorphism",
              "IsEqualToZeroMorphism",
              "IsEqualForCacheForObjects",
              "IsEqualForCacheForMorphisms",
              "MultiplyWithElementOfCommutativeSemiringForMorphisms",
              ];
    
    for func in skip
        
        pos = Position( list_of_operations_to_install, func );
        if (@not pos == fail)
            Remove( list_of_operations_to_install, pos );
        end;
        
    end;
    
    properties = ListKnownCategoricalProperties( C );
    
    ignore = [ "IsSkeletalCategory" ];
    Append( ignore, Filtered( properties, p -> IsSpecializationOfFilter( IsSkeletalCategory, FilterByName( p ) ) ) );
    Append( ignore, Filtered( properties, p -> IsInt( PositionSublist( p, "Strict" ) ) ) );
    Append( ignore, Filtered( properties, p -> ForAny( ListImpliedFilters( FilterByName( p ) ), i -> IsInt( PositionSublist( i, "Strict" ) ) ) ) );
    
    properties = Difference( properties, ignore );
    
    if (@not IsEmpty( ignore ))
        @Info( InfoLazyCategory, 2, "LazyCategory cannot deal with strictness of monoidal structures yet, ",
              "so we will be ignoring the following properties for ", C, ": ", ignore );
        
        if (primitive_operations && HasIsMonoidalCategory( C ) && IsMonoidalCategory( C ))
            Append( list_of_operations_to_install,
                    [ "LeftUnitorWithGivenTensorProduct",
                      "RightUnitorWithGivenTensorProduct",
                      "AssociatorLeftToRightWithGivenTensorProducts",
                      "AssociatorRightToLeftWithGivenTensorProducts",
                      ] );
            
            list_of_operations_to_install = SortedList( list_of_operations_to_install );
            
        end;
        
    end;
    
    properties = Filtered( properties, p -> ValueGlobal( p )( C ) );
    
    if (@IsBound( C.supports_empty_limits ))
        supports_empty_limits = C.supports_empty_limits;
    else
        supports_empty_limits = false;
    end;
    
    category_constructor_options =
      @rec( name = name,
           category_filter = category_filter,
           category_object_filter = category_object_filter,
           category_morphism_filter = category_morphism_filter,
           properties = properties,
           object_constructor = object_constructor,
           object_datum = object_datum,
           morphism_constructor = morphism_constructor,
           morphism_datum = morphism_datum,
           list_of_operations_to_install = list_of_operations_to_install,
           supports_empty_limits = supports_empty_limits,
           underlying_category_getter_string = "UnderlyingCategory",
           underlying_category = C,
           underlying_object_getter_string = "EvaluatedCell",
           underlying_morphism_getter_string = "EvaluatedCell",
           top_object_getter_string = "ObjectConstructor",
           top_morphism_getter_string = "MorphismConstructor",
           ## these two operations make no sense for LazyCategory as we do not descend to the underlying category in the CAP operations, but rather in EvaluatedCell
           #generic_output_source_getter_string =,
           #generic_output_range_getter_string =,
           create_func_bool = "default",
           create_func_object = create_func_object,
           create_func_morphism = create_func_morphism,
           create_func_list_of_objects = create_func_list_of_objects,
           );
    
    if (HasCommutativeSemiringOfLinearCategory( C ))
        category_constructor_options.commutative_semiring_of_linear_category = CommutativeSemiringOfLinearCategory( C );
    end;
    
    D = CategoryConstructor( category_constructor_options );
    
    SetUnderlyingCategory( D, C );
    
    ##
    D.compiler_hints =
      @rec( category_attribute_names =
           [ "UnderlyingCategory",
             ],
           );
    
    if (optimize >= 1)
        
        AddPreCompose( D,
          function( D, phi, psi )
            local composition;
            
            if (IsEqualToIdentityMorphism( D, psi ))
                
                return phi;
                
            end;
            
            if (IsEqualToIdentityMorphism( D, phi ))
                
                return psi;
                
            end;
            
            if (CanCompute( D, "IsEqualToZeroMorphism" ))
                
                if (IsEqualToZeroMorphism( D, phi ) || IsEqualToZeroMorphism( D, psi ))
                    
                    return ZeroMorphism( D, Source( phi ), Target( psi ) );
                    
                end;
                
            end;
            
            return MorphismConstructor( D, Source( phi ), PairGAP( "PreCompose", [ D, phi, psi ] ), Target( psi ) );
            
        end, OperationWeight( C, "PreCompose" ) );

    end;
    
    if (optimize >= 2)
        
        if (CanCompute( C, "DirectSum" ))
            
            AddDirectSum( D,
              function( D, diagram )
                
                ## Logic
                if (Length( diagram ) == 1 && IsCapCategoryObject( diagram[1] ))
                    return diagram[1];
                end;
                
                return ObjectConstructor( D, PairGAP( "DirectSum", [ D, diagram ] ) );
                
            end, OperationWeight( C, "DirectSum" ) );
            
        end;
        
        if (CanCompute( C, "FiberProduct" ))
            
            AddFiberProduct( D,
              function( D, diagram )
                local ess;
                
                ess = Filtered( diagram, m -> @not IsEqualToIdentityMorphism( D, m ) );
                
                if (IsEmpty( ess ))
                    ess = [ diagram[1] ];
                end;
                
                if (Length( ess ) == 1)
                    return Source( ess[1] );
                end;
                
                return ObjectConstructor( D, PairGAP( "FiberProduct", [ D, diagram ] ) );
                
            end, OperationWeight( C, "FiberProduct" ) );
            
        end;
        
        if (CanCompute( C, "ProjectionInFactorOfFiberProductWithGivenFiberProduct" ))
            
            AddProjectionInFactorOfFiberProductWithGivenFiberProduct( D,
              function( D, diagram, k, P )
                local pos, mor;
                
                pos = PositionsProperty( diagram, m -> @not IsEqualToIdentityMorphism( D, m ) );
                
                if (IsEmpty( pos ))
                    pos = [ 1 ];
                end;
                
                if (Length( pos ) == 1)
                    
                    mor = diagram[pos[1]];
                    
                    if (k == pos[1])
                        return IdentityMorphism( D, Source( mor ) );
                    end;
                    
                    return mor;
                    
                end;
                
                return MorphismConstructor( D, P, PairGAP( "ProjectionInFactorOfFiberProductWithGivenFiberProduct", [ D, diagram, k, P ] ), Source( diagram[k] ) );
                
            end, OperationWeight( C, "ProjectionInFactorOfFiberProductWithGivenFiberProduct" ) );
            
        end;
        
        if (CanCompute( C, "Pushout" ))
            
            AddPushout( D,
             function( D, diagram )
                local ess;
                
                ess = Filtered( diagram, m -> @not IsEqualToIdentityMorphism( D, m ) );
                
                if (IsEmpty( ess ))
                    ess = [ diagram[1] ];
                end;
                
                if (Length( ess ) == 1)
                    return Target( ess[1] );
                end;
                
                return ObjectConstructor( D, PairGAP( "Pushout", [ D, diagram ] ) );
                
            end, OperationWeight( C, "Pushout" ) );
            
        end;
        
        if (CanCompute( C, "InjectionOfCofactorOfPushoutWithGivenPushout" ))
            
            AddInjectionOfCofactorOfPushoutWithGivenPushout( D,
              function( D, diagram, k, I )
                local pos, mor;
                
                pos = PositionsProperty( diagram, m -> @not IsEqualToIdentityMorphism( D, m ) );
                
                if (IsEmpty( pos ))
                    pos = [ 1 ];
                end;
                
                if (Length( pos ) == 1)
                    
                    mor = diagram[pos[1]];
                    
                    if (k == pos[1])
                        return IdentityMorphism( D, Target( mor ) );
                    end;
                    
                    return mor;
                    
                end;
                
                return MorphismConstructor( D, Target( diagram[k] ), PairGAP( "InjectionOfCofactorOfPushoutWithGivenPushout", [ D, diagram, k, I ] ), I );
                
            end, OperationWeight( C, "InjectionOfCofactorOfPushoutWithGivenPushout" ) );
            
        end;
        
    end;
    
    D.show_evaluation = show_evaluation;
    
    D.evaluations = 0;
    
    D.shortname = name[(Minimum( 15, Length( name ) )):(Minimum( Length( name ) - 2, 50 ))];
    D.shortname = @Concatenation( D.shortname, ListWithIdenticalEntries( 39 - Length( D.shortname ), '.' ) );
    
    if (cache)
        DeactivateCachingOfCategory( C );
        DeactivateCachingOfCategory( D );
    end;
    
    if (CanCompute( C, "IsWellDefinedForObjects" ))
        
        AddIsWellDefinedForObjects( D,
          function( D, a )
            local genesis, operation_name, arguments;
            
            # object must have a genesis or an evaluated cell
            if (!(HasGenesisOfCell( a ) || HasEvaluatedCell( a )))
                
                return false;
                
            end;
            
            if (HasGenesisOfCell( a ))
                
                genesis = GenesisOfCell( a );
                
                # genesis must be a pair
                if (!(IsList( genesis ) && Length( genesis ) == 2))
                    
                    return false;
                    
                end;
                
                operation_name = genesis[1];
                arguments = genesis[2];
                
                # operation_name must be the name of a CAP operation which returns an object
                if (!(IsString( operation_name ) && @IsBound( CAP_INTERNAL_METHOD_NAME_RECORD[operation_name] ) && StartsWith( CAP_INTERNAL_METHOD_NAME_RECORD[operation_name].return_type, "object")))
                    
                    return false;
                    
                end;
                
                # arguments must be a list of arguments of the CAP operation
                if (!(IsList( arguments ) && Length( arguments ) == Length( CAP_INTERNAL_METHOD_NAME_RECORD[operation_name].filter_list )))
                    
                    return false;
                    
                end;
                
            end;
            
            if (@not IsWellDefinedForObjects( C, EvaluatedCell( a ) ))
                
                return false;
                
            end;
            
            return true;
            
        end, OperationWeight( C, "IsWellDefinedForObjects" ) );
        
    end;
    
    AddIsEqualForObjects( D,
      function( D, a, b )
        
        if (HasGenesisOfCell( a ) == HasGenesisOfCell( b ))
            if (HasGenesisOfCell( a ))
                return GenesisOfCellOperation( a ) == GenesisOfCellOperation( b ) &&
                       IsEqualForCells( GenesisOfCellArguments( a ), GenesisOfCellArguments( b ) );
            else
                return IsEqualForObjects( C, EvaluatedCell( a ), EvaluatedCell( b ) );
            end;
        elseif (HasGenesisOfCell( a ) && Length( GenesisOfCellArguments( a ) ) == 1 && IsIdenticalObj( GenesisOfCellArguments( a )[1], D ))
            return IsEqualForObjects( C, _EvaluationOfCell( a ), EvaluatedCell( b ) );
        elseif (HasGenesisOfCell( b ) && Length( GenesisOfCellArguments( b ) ) == 1 && IsIdenticalObj( GenesisOfCellArguments( b )[1], D ))
            return IsEqualForObjects( C, EvaluatedCell( a ), _EvaluationOfCell( b ) );
        end;
        
        return false;
        
    end, OperationWeight( C, "IsEqualForObjects" ) );
    
    if (CanCompute( C, "IsWellDefinedForMorphisms" ))
        
        AddIsWellDefinedForMorphisms( D,
          function( D, phi )
            local genesis, operation_name, arguments;
            
            # morphism must have a genesis or an evaluated cell
            if (!(HasGenesisOfCell( phi ) || HasEvaluatedCell( phi )))
                
                return false;
                
            end;
            
            if (HasGenesisOfCell( phi ))
                
                genesis = GenesisOfCell( phi );
                
                # genesis must be a pair
                if (!(IsList( genesis ) && Length( genesis ) == 2))
                    
                    return false;
                    
                end;
                
                operation_name = genesis[1];
                arguments = genesis[2];
                
                # operation_name must be the name of a CAP operation which returns a morphism
                if (!(IsString( operation_name ) && @IsBound( CAP_INTERNAL_METHOD_NAME_RECORD[operation_name] ) && StartsWith( CAP_INTERNAL_METHOD_NAME_RECORD[operation_name].return_type, "morphism")))
                    
                    return false;
                    
                end;
                
                # arguments must be a list of arguments of the CAP operation
                if (!(IsList( arguments ) && Length( arguments ) == Length( CAP_INTERNAL_METHOD_NAME_RECORD[operation_name].filter_list )))
                    
                    return false;
                    
                end;
                
            end;
            
            if (@not IsEqualForObjects( C, EvaluatedCell( Source( phi ) ), Source( EvaluatedCell( phi ) ) ))
                
                return false;
                
            end;
            
            if (@not IsEqualForObjects( C, EvaluatedCell( Target( phi ) ), Target( EvaluatedCell( phi ) ) ))
                
                return false;
                
            end;
            
            if (@not IsWellDefinedForMorphisms( C, EvaluatedCell( phi ) ))
                
                return false;
                
            end;
            
            return true;
            
        end, OperationWeight( C, "IsWellDefinedForMorphisms" ) );
        
    end;
    
    AddIsEqualForMorphisms( D,
      function( D, phi, psi )
        
        if (HasGenesisOfCell( phi ) == HasGenesisOfCell( psi ))
            if (HasGenesisOfCell( phi ))
                return GenesisOfCellOperation( phi ) == GenesisOfCellOperation( psi ) &&
                       IsEqualForCells( GenesisOfCellArguments( phi ), GenesisOfCellArguments( psi ) );
            else
                return IsEqualForMorphismsOnMor( C, EvaluatedCell( phi ), EvaluatedCell( psi ) );
            end;
        end;
        
        return false;
        
    end, OperationWeight( C, "IsEqualForMorphisms" ) );
    
    AddIsEqualForCacheForObjects( D,
      function( D, a, b )
        
        return IsEqualForObjects( D, a, b );
        
    end, OperationWeight( C, "IsEqualForMorphisms" ) );
    
    AddIsEqualForCacheForMorphisms( D,
      function( D, phi, psi )

        return IsEqualForMorphismsOnMor( D, phi, psi );

    end );
    
    if (CanCompute( C, "IsCongruentForMorphisms" ))
        
        if (print)
            Display( "IsCongruentForMorphisms" );
        end;
        
        ##
        AddIsCongruentForMorphisms( D,
          function( D, phi, psi )
            
            return IsCongruentForMorphisms( UnderlyingCategory( D ), EvaluatedCell( phi ), EvaluatedCell( psi ) );
            
        end, OperationWeight( C, "IsCongruentForMorphisms" ) );
        
    end;
    
    if (CanCompute( C, "MultiplyWithElementOfCommutativeSemiringForMorphisms" ))
        
        if (print)
            Display( "MultiplyWithElementOfCommutativeSemiringForMorphisms" );
        end;
        
        ##
        AddMultiplyWithElementOfCommutativeSemiringForMorphisms( D,
          function( D, r, phi )
            
            return MorphismConstructor( D, Source( phi ), PairGAP( "MultiplyWithElementOfCommutativeSemiringForMorphisms", [ D, r, phi ] ), Target( phi ) );
            
        end, OperationWeight( C, "MultiplyWithElementOfCommutativeSemiringForMorphisms" ) );
        
    end;
    
    if (HasRangeCategoryOfHomomorphismStructure( C ))
        
        if (print)
            list = [ "BasisOfExternalHom",
                      "CoefficientsOfMorphism",
                      "DistinguishedObjectOfHomomorphismStructure",
                      "HomomorphismStructureOnObjects",
                      "HomomorphismStructureOnMorphismsWithGivenObjects",
                      "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects",
                      "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism",
                      ];
            
            for func in list
                if (CanCompute( C, func ))
                    Display( func );
                end;
            end;
            Display( "" );
        end;
        
        if (CanCompute( C, "BasisOfExternalHom" ))
            AddBasisOfExternalHom( D,
              function( D, a, b )
                local show, count, result;
                
                show = D.show_evaluation;
                
                count = D.evaluations + 1;
                
                D.evaluations = count;
                
                if (show)
                    Print( count, ".", FillWithCharacterAfterDecimalNumber( count, ' ', 7 ), ListWithIdenticalEntries( Log2Int( count ), ' ' ), "-> evaluating in ", D.shortname, ": ", "BasisOfExternalHom", "\n" );
                else
                    @Info( InfoLazyCategory, 2, count, ".", FillWithCharacterAfterDecimalNumber( count, ' ', 7 ), ListWithIdenticalEntries( Log2Int( count ), ' ' ), "-> evaluating in ", D.shortname, ": ", "BasisOfExternalHom" );
                end;
                
                result = List( BasisOfExternalHom( UnderlyingCategory( D ), EvaluatedCell( a ), EvaluatedCell( b ) ),
                                mor -> AsMorphismInLazyCategory( D, a, mor, b ) );
                
                if (show)
                    Print( count, ".", FillWithCharacterAfterDecimalNumber( count, ' ', 7 ), ListWithIdenticalEntries( Log2Int( count ), ' ' ), "<- evaluated in ", D.shortname, ": ", "BasisOfExternalHom", "\n" );
                else
                    @Info( InfoLazyCategory, 2, count, ".", FillWithCharacterAfterDecimalNumber( count, ' ', 7 ), ListWithIdenticalEntries( Log2Int( count ), ' ' ), "<- evaluated in ", D.shortname, ": ", "BasisOfExternalHom" );
                end;
                
                return result;
                
            end, OperationWeight( C, "BasisOfExternalHom" ) );
            
        end;
        
        if (CanCompute( C, "CoefficientsOfMorphism" ))
            AddCoefficientsOfMorphism( D,
              function( D, alpha )
                local show, count, result;
                
                show = D.show_evaluation;
                
                count = D.evaluations + 1;
                
                D.evaluations = count;
                
                if (show)
                    Print( count, ".", FillWithCharacterAfterDecimalNumber( count, ' ', 7 ), ListWithIdenticalEntries( Log2Int( count ), ' ' ), "-> evaluating in ", D.shortname, ": ", "CoefficientsOfMorphism", "\n" );
                else
                    @Info( InfoLazyCategory, 2, count, ".", FillWithCharacterAfterDecimalNumber( count, ' ', 7 ), ListWithIdenticalEntries( Log2Int( count ), ' ' ), "-> evaluating in ", D.shortname, ": ", "CoefficientsOfMorphism" );
                end;
                
                result = CoefficientsOfMorphism(
                                  UnderlyingCategory( D ),
                                  EvaluatedCell( alpha ) );
                
                if (show)
                    Print( count, ".", FillWithCharacterAfterDecimalNumber( count, ' ', 7 ), ListWithIdenticalEntries( Log2Int( count ), ' ' ), "<- evaluated in ", D.shortname, ": ", "CoefficientsOfMorphism", "\n" );
                else
                    @Info( InfoLazyCategory, 2, count, ".", FillWithCharacterAfterDecimalNumber( count, ' ', 7 ), ListWithIdenticalEntries( Log2Int( count ), ' ' ), "<- evaluated in ", D.shortname, ": ", "CoefficientsOfMorphism" );
                end;
                
                return result;
                
            end, OperationWeight( C, "CoefficientsOfMorphism" ) );
            
        end;
        
        HC = RangeCategoryOfHomomorphismStructure( C );
        
        if (cache == false)
            DeactivateCachingOfCategory( HC );
        end;
        
        if (lazify_range_of_hom_structure && (@not IsLazyCategory( HC )))
            
            HC = LazyCategory( HC; lazify_range_of_hom_structure = false );
            
            SetRangeCategoryOfHomomorphismStructure( D, HC );
            
            if (CanCompute( C, "DistinguishedObjectOfHomomorphismStructure" ))
                AddDistinguishedObjectOfHomomorphismStructure( D,
                  function( D )
                    
                    return ObjectConstructor( HC, PairGAP( "DistinguishedObjectOfHomomorphismStructure", [ D ] ) );
                    
                end, OperationWeight( C, "DistinguishedObjectOfHomomorphismStructure" ) );
            end;
            
            if (CanCompute( C, "HomomorphismStructureOnObjects" ))
                AddHomomorphismStructureOnObjects( D,
                  function( D, a, b )
                    
                    return ObjectConstructor( HC, PairGAP( "HomomorphismStructureOnObjects", [ D, a, b ] ) );
                    
                end, OperationWeight( C, "HomomorphismStructureOnObjects" ) );
            end;
            
            if (CanCompute( C, "HomomorphismStructureOnMorphismsWithGivenObjects" ))
                AddHomomorphismStructureOnMorphismsWithGivenObjects( D,
                  function( D, s, alpha, beta, r )
                    
                    return MorphismConstructor( HC, s, PairGAP( "HomomorphismStructureOnMorphismsWithGivenObjects", [ D, s, alpha, beta, r ] ), r );
                    
                end, OperationWeight( C, "HomomorphismStructureOnMorphismsWithGivenObjects" ) );
            end;
            
            if (CanCompute( C, "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects" ))
                AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( D,
                  function( D, distinguished_object, alpha, range )
                    
                    return MorphismConstructor( HC, distinguished_object, PairGAP( "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects", [ D, distinguished_object, alpha, range ] ), range );
                    
                end, OperationWeight( C, "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects" ) );
            end;
            
            if (CanCompute( C, "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism" ))
                AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( D,
                  function( D, a, b, iota )
                    
                    return MorphismConstructor( D, a, PairGAP( "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism", [ D, a, b, iota ] ), b );
                    
                end, OperationWeight( C, "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism" ) );
            end;
            
        else
            
            SetRangeCategoryOfHomomorphismStructure( D, HC );
            
            if (CanCompute( C, "DistinguishedObjectOfHomomorphismStructure" ))
                AddDistinguishedObjectOfHomomorphismStructure( D,
                  function( D )
                    
                    return DistinguishedObjectOfHomomorphismStructure( UnderlyingCategory( D ) );
                    
                end, OperationWeight( C, "DistinguishedObjectOfHomomorphismStructure" ) );
            end;
            
            if (CanCompute( C, "HomomorphismStructureOnObjects" ))
                AddHomomorphismStructureOnObjects( D,
                  function( D, a, b )
                    
                    return HomomorphismStructureOnObjects( UnderlyingCategory( D ), EvaluatedCell( a ), EvaluatedCell( b ) );
                    
                end, OperationWeight( C, "HomomorphismStructureOnObjects" ) );
            end;
            
            if (CanCompute( C, "HomomorphismStructureOnMorphismsWithGivenObjects" ))
                AddHomomorphismStructureOnMorphismsWithGivenObjects( D,
                  function( D, s, alpha, beta, r )
                    
                    return HomomorphismStructureOnMorphismsWithGivenObjects( UnderlyingCategory( D ), s, EvaluatedCell( alpha ), EvaluatedCell( beta ), r );
                    
                end, OperationWeight( C, "HomomorphismStructureOnMorphismsWithGivenObjects" ) );
            end;
            
            if (CanCompute( C, "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects" ))
                AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( D,
                  function( D, distinguished_object, alpha, range )
                    
                    return InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( UnderlyingCategory( D ), distinguished_object, EvaluatedCell( alpha ), range );
                    
                end, OperationWeight( C, "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects" ) );
            end;
            
            if (CanCompute( C, "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism" ))
                AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( D,
                  function( D, a, b, iota )
                    
                    return AsMorphismInLazyCategory( a, InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( UnderlyingCategory( D ), EvaluatedCell( a ), EvaluatedCell( b ), iota ), b );
                    
                end, OperationWeight( C, "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism" ) );
            end;
            
        end;
        
    end;
    
    Finalize( D );
    
    return D;
    
end ) );

##
@InstallMethod( /,
        "for an object and a lazy category",
        [ IsObject, IsLazyCategory ],
        
  function( data, C )
    
    return ( data / UnderlyingCategory( C ) ) / C;
    
end );

##
@InstallMethod( /,
        "for a CAP category object and a lazy category",
         [ IsCapCategoryObject, IsLazyCategory ],
        
  function( object, cat )
    
    if (@not IsIdenticalObj( CapCategory( object ), UnderlyingCategory( cat ) ))
        TryNextMethod( );
    end;
    
    return AsObjectInLazyCategory( cat, object );
    
end );

##
@InstallMethod( /,
        "for a CAP category morphism and a lazy category",
        [ IsCapCategoryMorphism, IsLazyCategory ],
        
  function( morphism, cat )
    
    if (@not IsIdenticalObj( CapCategory( morphism ), UnderlyingCategory( cat ) ))
        TryNextMethod( );
    end;
    
    return AsMorphismInLazyCategory( cat, morphism );
    
end );

##
@InstallMethod( /,
        "for a string and a lazy category",
        [ IsString, IsLazyCategory ],
        
  function( name, lazy_cat )
    local C;
    
    C = UnderlyingCategory( lazy_cat );
    
    return C[name] / lazy_cat;
    
end );

#= comment for Julia
INSTALL_DOT_METHOD( IsLazyCategory );
# =#

##
@InstallMethod( EmbeddingFunctorOfUnderlyingCategory,
        "for a lazy category",
        [ IsLazyCategory ],
        
  function( lazy_cat )
    local E;
    
    E = CapFunctor( "Embedding functor into lazy category", UnderlyingCategory( lazy_cat ), lazy_cat );
    
    AddObjectFunction( E, objC -> AsObjectInLazyCategory( lazy_cat, objC ) );
    
    AddMorphismFunction( E, ( source, morC, range ) -> AsMorphismInLazyCategory( source, morC, range ) );
    
    return E;
    
end );

##################################
##
## Visualize
##
##################################

##
@InstallGlobalFunction( AreEqualForLazyCells,
  function( a, b )
    local length;
    
    if (IsList( a ) && @not IsList( b ))
        return false;
    elseif (@not IsList( a ) && IsList( b ))
        return false;
    elseif (IsList( a ) && IsList( b ))
        length = Length( a );
        if (@not length == Length( b ))
            return false;
        end;
        return ForAll( (1):(length), i -> AreEqualForLazyCells( a[i], b[i] ) );
    elseif (@not IsIdenticalObj( CapCategory( a ), CapCategory( b ) ))
        return false;
    elseif (!( ( IsCapCategoryObject( a ) && IsCapCategoryObject( b ) ) || ( IsCapCategoryMorphism( a ) && IsCapCategoryMorphism( b ) ) ))
        return false;
    end;
    
    return IsEqualForCells( a, b );
    
end );

##
@InstallMethod( PositionsOfParentsOfALazyCell,
        [ IsList, IsCellInLazyCategory ],
        
  function( nodes, node )
    local parents;
    
    if (@not HasGenesisOfCell( node ))
        return [ ];
    end;
    
    parents = GenesisOfCellArguments( node );
    
    parents = Filtered( parents, parent -> IsCellInLazyCategory( parent ) || IsList( parent ) );
    
    return List( parents, parent -> PositionProperty( nodes, a -> AreEqualForLazyCells( parent, a ) ) );
    
end );

##
@InstallMethod( PositionsOfParentsOfALazyCell,
        [ IsList, IsList ],
        
  function( nodes, node )
    
    return List( node, parent -> PositionProperty( nodes, a -> AreEqualForLazyCells( parent, a ) ) );
    
end );

##################################
##
## View & Display
##
##################################

##
@BindGlobal( "LAZY_CATEGORIES_DISPLAY_STRING_OF_GENESIS",
  function( c )
    local cell_arguments;
    
    cell_arguments = GenesisOfCellArguments( c );
    
    if (Length( cell_arguments ) > 1 && IsLazyCategory( cell_arguments[1] ))
        cell_arguments = cell_arguments[(2):(Length( cell_arguments ))];
    end;
    
    return @Concatenation(
            GenesisOfCellOperation( c ), "( ",
            JoinStringsWithSeparator( List( cell_arguments, StringView ), ", " ),
            " )" );
    
end );

##
@InstallMethod( DisplayString,
        "for a cell in a lazy category",
        [ IsCellInLazyCategory ],
        
  function( c )
    
    if (HasGenesisOfCell( c ))
        
        return LAZY_CATEGORIES_DISPLAY_STRING_OF_GENESIS( c );
        
    end;
    
    #= comment for Julia
    TryNextMethod( );
    # =#
    
    return @Concatenation( "<A cell in ", Name( CapCategory( c ) ), ">" );
    
end );

##
@InstallMethod( ViewString,
        "for an object in a lazy category",
        [ IsObjectInLazyCategory ],
        
  function( a )
    
    if (HasEvaluatedCell( a ))
        return @Concatenation( "<An evaluated object in ", Name( CapCategory( a ) ), ">" );
    end;
    
    #= comment for Julia
    TryNextMethod( );
    # =#
    
    return @Concatenation( "<An object in ", Name( CapCategory( a ) ), ">" );
    
end );

##
@InstallMethod( ViewString,
        "for a morphism in a lazy category",
        [ IsMorphismInLazyCategory ],
        
  function( phi )
    
    if (HasEvaluatedCell( phi ))
        return @Concatenation( "<An evaluated morphism in ", Name( CapCategory( phi ) ), ">" );
    end;
    
    #= comment for Julia
    TryNextMethod( );
    # =#
    
    return @Concatenation( "<A morphism in ", Name( CapCategory( phi ) ), ">" );
    
end );

##
@InstallMethod( DisplayString,
        "for an object in a lazy category",
        [ IsObjectInLazyCategory ],
        
  function( a )
    
    if (HasEvaluatedCell( a ))
        return @Concatenation( DisplayString( EvaluatedCell( a ) ), "\nAn evaluated object given by the above data" );
    end;
    
    if (HasGenesisOfCell( a ))
        return LAZY_CATEGORIES_DISPLAY_STRING_OF_GENESIS( a );
    end;
    
    #= comment for Julia
    TryNextMethod( );
    # =#
    
    return ViewString( a );
    
end );

##
@InstallMethod( DisplayString,
        "for a morphism in a lazy category",
        [ IsMorphismInLazyCategory ],
        
  function( phi )
    
    if (HasEvaluatedCell( phi ))
        return @Concatenation( DisplayString( EvaluatedCell( phi ) ), "\nAn evaluated morphism given by the above data" );
    end;
    
    if (HasGenesisOfCell( phi ))
        return LAZY_CATEGORIES_DISPLAY_STRING_OF_GENESIS( phi );
    end;
    
    #= comment for Julia
    TryNextMethod( );
    # =#
    
    return ViewString( phi );
    
end );
