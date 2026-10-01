# SPDX-License-Identifier: GPL-2.0-or-later
# FunctorCategories: Categories of functors
#
# Implementations
#

##
@BindGlobal( "QuiverOfCategoryOfReflexiveQuivers",
        UnderlyingQuiver( SimplicialCategoryTruncatedInDegree( 1 ) ) );

##
@InstallMethod( CreateReflexiveQuiver,
        "for a category of finite reflexive quivers and a quadruple",
        [ IsCategoryOfReflexiveQuivers, IsList ],
        
  function ( category_of_quivers, quadruple )
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    @Assert( 0,
            Length( quadruple ) == 4 &&
            IsList( quadruple[3] ) &&
            ForAll( quadruple[3], IsBigInt ) &&
            IsList( quadruple[4] ) &&
            ForAll( quadruple[4], IsList ) );
    
    return ObjectConstructor( category_of_quivers, quadruple );
    
end );

##
@InstallMethod( CreateReflexiveQuiver,
        "for a category of finite reflexive quivers, an integer, a list of integers, and a list of pairs of integers",
        [ IsCategoryOfReflexiveQuivers, IsBigInt, IsList, IsList ],
        
  function ( category_of_quivers, n, loops, arrows )
    local arr;
    
    if (ForAll( arrows, IsBigInt ))
        @Assert( 0, IsEvenInt( Length( arrows ) ) );
        arr = List( (1):(QuoInt( Length( arrows ), 2 )), i -> PairGAP( arrows[2 * i - 1], arrows[2 * i] ) );
    else
        arr = arrows;
    end;
    
    return CreateReflexiveQuiver( category_of_quivers,
                   @NTupleGAP( 4, n, BigInt( Length( arr ) ), loops, arr ) );
    
end );

##
@InstallMethod( CreateReflexiveQuiverMorphism,
        "for a category of finite reflexive quivers, two objects in a category of finite reflexive quivers, and a pair",
        [ IsCategoryOfReflexiveQuivers, IsObjectInCategoryOfReflexiveQuivers, IsList, IsObjectInCategoryOfReflexiveQuivers ],
        
  function ( category_of_quivers, source, images, range )
    
    return MorphismConstructor( category_of_quivers, source, images, range );
    
end );

##
@InstallMethod( CreateReflexiveQuiverMorphism,
        "for two objects in a category of finite reflexive quivers and two lists",
        [ IsObjectInCategoryOfReflexiveQuivers, IsList, IsList, IsObjectInCategoryOfReflexiveQuivers ],
        
  function ( source, images_of_vertices, images_of_arrows, range )
    
    return CreateReflexiveQuiverMorphism( CapCategory( source ), source, PairGAP( images_of_vertices, images_of_arrows ), range );
    
end );

##
@InstallMethod( CategoryOfReflexiveQuiversEnrichedOver,
        "for a category of sekelal finite sets",
        [ IsSkeletalCategoryOfFiniteSets ],
        
    @FunctionWithNamedArguments(
    [
        [ "no_precompiled_code", false ],
        [ "FinalizeCategory", true ],
    ],
    function ( CAP_NAMED_ARGUMENTS, category_of_skeletal_finsets )
    local name, category_filter, category_object_filter, category_morphism_filter,
          object_datum_type, object_constructor, object_datum,
          morphism_datum_type, morphism_constructor, morphism_datum,
          F, F_hat,
          modeling_tower_object_constructor, modeling_tower_object_datum,
          modeling_tower_morphism_constructor, modeling_tower_morphism_datum,
          Quivers;
    
    ##
    name = @Concatenation( "CategoryOfReflexiveQuiversEnrichedOver( ", Name( category_of_skeletal_finsets ), " )" );
    
    ##
    category_filter = IsCategoryOfReflexiveQuivers;
    category_object_filter = IsObjectInCategoryOfReflexiveQuivers;
    category_morphism_filter = IsMorphismInCategoryOfReflexiveQuivers;
    
    ##
    object_datum_type =
      CapJitDataTypeOfNTupleOf( 4,
              IsBigInt,
              IsBigInt,
              CapJitDataTypeOfListOf( IsBigInt ),
              CapJitDataTypeOfListOf(
                      CapJitDataTypeOfNTupleOf( 2,
                              IsBigInt,
                              IsBigInt ) ) );
    
    object_constructor =
        ( category_of_quivers, quadruple ) ->
            CreateCapCategoryObjectWithAttributes( category_of_quivers,
                DefiningQuadrupleOfReflexiveQuiverEnrichedOverSkeletalFinSets, quadruple );
    
    object_datum = ( Quivers, o ) -> DefiningQuadrupleOfReflexiveQuiverEnrichedOverSkeletalFinSets( o );
    
    ##
    morphism_datum_type =
      CapJitDataTypeOfNTupleOf( 2,
              CapJitDataTypeOfListOf( IsBigInt ),
              CapJitDataTypeOfListOf( IsBigInt ) );
    
    morphism_constructor =
        ( category_of_quivers, source, images, range ) ->
            CreateCapCategoryMorphismWithAttributes( category_of_quivers,
                source,
                range,
                DefiningPairOfReflexiveQuiverMorphismEnrichedOverSkeletalFinSets, images );
    
    morphism_datum = ( Quivers, m ) -> DefiningPairOfReflexiveQuiverMorphismEnrichedOverSkeletalFinSets( m );
    
    ## building the categorical tower:
    
    F = SimplicialCategoryTruncatedInDegree( 1; range_of_HomStructure = category_of_skeletal_finsets, FinalizeCategory = true );
    
    F = CallFuncListAtRuntime( CategoryFromDataTables, [ F ]; set_category_attribute_resolving_functions = true, FinalizeCategory = true );
    
    F_hat = FiniteCocompletion( F
                #= comment for Julia (FiniteCocompletion(-) does not yet support this named-arg)
               ; FinalizeCategory = true
                # =#
                );
    
    @Assert( 0, IsIdenticalObj( RangeCategoryOfHomomorphismStructure( F ), category_of_skeletal_finsets ) );
    
    ## from the raw object data to the object in the modeling category
    modeling_tower_object_constructor =
      function( Quivers, quadruple )
        local F_hat, PSh, sFinSets, V, A, loops, arrows, sources, targets;
        
        F_hat = ModelingCategory( Quivers );
        
        PSh = ModelingCategory( F_hat );
        
        sFinSets = Target( PSh );
        
        V = ObjectConstructor( sFinSets, quadruple[1] );
        
        A = ObjectConstructor( sFinSets, quadruple[2] );
        
        loops = MorphismConstructor( sFinSets, V, quadruple[3], A );
        
        arrows = quadruple[4];
        
        sources = MorphismConstructor( sFinSets, A, List( arrows, a -> a[1] ), V );
        
        targets = MorphismConstructor( sFinSets, A, List( arrows, a -> a[2] ), V );
        
        return ObjectConstructor( F_hat,
                       ObjectConstructor( PSh, PairGAP( [ V, A ], [ loops, sources, targets ] ) ) );
        
    end;
    
    ## from the object in the modeling category to the raw object data
    modeling_tower_object_datum =
      function( Quivers, obj )
        local F_hat, PSh, F, values_of_functor;
        
        F_hat = ModelingCategory( Quivers );
        
        PSh = ModelingCategory( F_hat );
        
        F = ObjectDatum( F_hat, obj );
        
        values_of_functor = ObjectDatum( PSh, F );
        
        return @NTupleGAP( 4, Cardinality( values_of_functor[1][1] ),
                       Cardinality( values_of_functor[1][2] ),
                       AsList( values_of_functor[2][1] ),
                       ListN( AsList( values_of_functor[2][2] ), AsList( values_of_functor[2][3] ), ( s, t ) -> PairGAP( s, t ) ) );
        
    end;
    
    ## from the raw morphism data to the morphism in the modeling category
    modeling_tower_morphism_constructor =
      function( Quivers, source, images, range )
        local F_hat, PSh, sFinSets, S, T, Sobj, Tobj;
        
        F_hat = ModelingCategory( Quivers );
        
        PSh = ModelingCategory( F_hat );
        
        sFinSets = Target( PSh );
        
        S = ObjectDatum( F_hat, source );
        T = ObjectDatum( F_hat, range );
        
        Sobj = ObjectDatum( PSh, S )[1];
        Tobj = ObjectDatum( PSh, T )[1];
        
        return MorphismConstructor( F_hat,
                       source,
                       MorphismConstructor( PSh,
                               S,
                               [ MorphismConstructor( sFinSets, Sobj[1], images[1], Tobj[1] ),
                                 MorphismConstructor( sFinSets, Sobj[2], images[2], Tobj[2] ) ],
                               T ),
                       range );
        
    end;
    
    ## from the morphism in the modeling category to the raw morphism data
    modeling_tower_morphism_datum =
      function( Quivers, mor )
        local F_hat, PSh, eta, values_on_all_objects;
        
        F_hat = ModelingCategory( Quivers );
        
        PSh = ModelingCategory( F_hat );
        
        eta = MorphismDatum( F_hat, mor );
        
        values_on_all_objects = MorphismDatum( PSh, eta );
        
        return PairGAP( AsList( values_on_all_objects[1] ), AsList( values_on_all_objects[2] ) );
        
    end;
    
    ##
    Quivers =
      ReinterpretationOfCategory( F_hat,
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
             ; FinalizeCategory = false );
    
    SetUnderlyingCategory( Quivers, F );
    
    Append( Quivers.compiler_hints.category_attribute_names,
            [ "UnderlyingCategory",
              ] );
    
    if (no_precompiled_code != true)
        ADD_FUNCTIONS_FOR_FinReflexiveQuiversPrecompiled( Quivers );
        ADD_FUNCTIONS_FOR_FinReflexiveQuiversAsCCCPrecompiled( Quivers );
    end;
    
    if (FinalizeCategory == true)
        Finalize( Quivers );
    end;
    
    return Quivers;
    
end ) );

##
@BindGlobal( "FinReflexiveQuivers",
         CategoryOfReflexiveQuiversEnrichedOver( SkeletalFinSets ) );

FinReflexiveQuivers.Name = "FinReflexiveQuivers";

##
@InstallMethod( CreateReflexiveQuiver,
        "for an integer, a list of integers, and a list of pairs of integers",
        [ IsBigInt, IsList, IsList ],
        
  function ( n, loops, arrows )
    
    return CreateReflexiveQuiver( FinReflexiveQuivers, n, loops, arrows );
    
end );

##
@InstallMethod( Loops,
        "for an object in a category of finite reflexive quivers",
        [ IsObjectInCategoryOfReflexiveQuivers ],
        
  function ( reflexive_quiver )
    
    return ObjectDatum( reflexive_quiver )[3];
    
end );

##
@InstallMethod( Arrows,
        "for an object in a category of finite reflexive quivers",
        [ IsObjectInCategoryOfReflexiveQuivers ],
        
  function ( reflexive_quiver )
    
    return ObjectDatum( reflexive_quiver )[4];
    
end );

##
@InstallMethod( Subobject,
        "for an object in a category of finite reflexive quivers and two lists",
        [ IsObjectInCategoryOfReflexiveQuivers, IsList, IsList ],
        
  function ( reflexive_quiver, images_of_vertices, images_of_arrows )
    local arrows, arrows_as_pairs, vertices, source, subreflexivequiver;
    
    arrows = DuplicateFreeList( images_of_arrows );
    
    arrows_as_pairs = Arrows( reflexive_quiver )[1 + arrows];
    
    vertices = AsList( reflexive_quiver.V )[1 + SetGAP( @Concatenation( images_of_vertices, @Concatenation( arrows_as_pairs ) ) )];
    
    source = CreateReflexiveQuiver( CapCategory( reflexive_quiver ),
                      Length( vertices ),
                      List( arrows_as_pairs, a -> -1 + [ SafePosition( vertices, a[1] ), SafePosition( vertices, a[2] ) ] ) );
    
    subreflexivequiver = CreateReflexiveQuiverMorphism( source, vertices, arrows, reflexive_quiver );
    
    @Assert( 2, IsMonomorphism( subreflexivequiver ) );
    SetIsMonomorphism( subreflexivequiver, true );
    
    return subreflexivequiver;
    
end );

##
@InstallMethod( Subobject,
        "for an object in a category of finite reflexive quivers and a list",
        [ IsObjectInCategoryOfReflexiveQuivers, IsList ],
        
  function ( reflexive_quiver, images_of_arrows )
    
    return Subobject( reflexive_quiver, [ ], images_of_arrows );
    
end );

##
@InstallMethod( EmbeddingOfUnderlyingCategory,
        "for a category of finite reflexive quivers",
        [ IsCategoryOfReflexiveQuivers ],
        
  function ( category_of_quivers )
    local Y, U;
    
    Y = YonedaEmbedding( UnderlyingCategory( category_of_quivers ) );
    
    U = CapFunctor( "UnwrappingFunctor", RangeOfFunctor( Y ), category_of_quivers );
    
    AddObjectFunction( U,
            F -> CreateReflexiveQuiver( category_of_quivers, @NTupleGAP( 4, Cardinality( F.C0 ), Cardinality( F.C1 ), AsList( F.id ), ListN( AsList( F.s ), AsList( F.t ), ( s, t ) -> PairGAP( s, t ) ) ) ) );
    
    AddMorphismFunction( U,
            ( source, eta, range ) -> CreateReflexiveQuiverMorphism( category_of_quivers, source, PairGAP( AsList( eta.C0 ), AsList( eta.C1 ) ), range ) );
    
    return PreCompose( Y, U );
    
end );

##
@InstallMethod( /,
        "for a string and a category of finite reflexive quivers",
        [ IsString, IsCategoryOfReflexiveQuivers ],
        
  function ( name, category_of_quivers )
    local F, Y, Yc;
    
    F = UnderlyingCategory( category_of_quivers );
    
    Y = EmbeddingOfUnderlyingCategory( category_of_quivers );
    
    if (name == "V")
        name = "C0";
    elseif (name == "A")
        name = "C1";
    elseif (name == "l")
        name = "id";
    end;
    
    Yc = CallFuncListAtRuntime( ApplyFunctor, [ Y, name / F ] );
    
    if (IsObjectInCategoryOfReflexiveQuivers( Yc ))
        
        SetIsProjective( Yc, true );
        
    elseif (IsMorphismInCategoryOfReflexiveQuivers( Yc ))
        
        if (CanCompute( category_of_quivers, "IsMonomorphism" ))
            IsMonomorphism( Yc );
        end;
        
        if (CanCompute( category_of_quivers, "IsSplitMonomorphism" ))
            IsSplitMonomorphism( Yc );
        end;
        
        if (CanCompute( category_of_quivers, "IsEpimorphism" ))
            IsEpimorphism( Yc );
        end;
        
        if (CanCompute( category_of_quivers, "IsSplitEpimorphism" ))
            IsSplitEpimorphism( Yc );
        end;
        
        ## IsIsomorphism == IsSplitMonomorphism and IsSplitEpimorphism
        ## we add this here in case the logic is deactivated
        if (CanCompute( category_of_quivers, "IsIsomorphism" ))
            IsIsomorphism( Yc );
        end;
        
    end;
    
    return Yc;
    
end );

##
@InstallMethod( /,
        "for a string and an object in a category of finite reflexive quivers",
        [ IsString, IsObjectInCategoryOfReflexiveQuivers ],
        
  function ( name, reflexive_quiver )
    local datum, n, m, loops, arrows;
    
    datum = ObjectDatum( reflexive_quiver );
    
    n = datum[1];
    
    m = datum[2];
    
    loops = datum[3];
    
    arrows = datum[4];
    
    if (name == "V" || name == "C0")
        return FinSet( n );
    elseif (name == "A" || name == "C1")
        return FinSet( Length( arrows ) );
    elseif (name == "s")
        return MapOfFinSets( FinSet( m ), List( arrows, a -> a[1] ), FinSet( n ) );
    elseif (name == "t")
        return MapOfFinSets( FinSet( m ), List( arrows, a -> a[2] ), FinSet( n ) );
    elseif (name == "id" || name == "l")
        return MapOfFinSets( FinSet( n ), loops, FinSet( m ) );
    end;
    
    Error( "the reflexive quiver has no component with the name \"", name, "\"\n" );
    
end );

##
@InstallMethod( /,
        "for a string and a morphism in a category of finite reflexive quivers",
        [ IsString, IsMorphismInCategoryOfReflexiveQuivers ],
        
  function ( name, mor )
    local datum;
    
    datum = MorphismDatum( mor );
    
    if (name == "V" || name == "C0")
        return MapOfFinSets( Source( mor ).V, datum[1], Target( mor ).V );
    elseif (name == "A" || name == "C1")
        return MapOfFinSets( Source( mor ).A, datum[2], Target( mor ).A );
    end;
    
    Error( "the reflexive quiver morphism has no component with the name \"", name, "\"\n" );
    
end );

#= comment for Julia
INSTALL_DOT_METHOD( IsCategoryOfReflexiveQuivers );
INSTALL_DOT_METHOD( IsObjectInCategoryOfReflexiveQuivers );
INSTALL_DOT_METHOD( IsMorphismInCategoryOfReflexiveQuivers );

##
MakeShowable( [ "image/svg+xml" ], IsObjectInCategoryOfReflexiveQuivers );
MakeShowable( [ "image/svg+xml" ], IsMorphismInCategoryOfReflexiveQuivers && IsMonomorphism );
# =#

##
@InstallMethod( DotVertexLabelledDigraph,
        "for an object in a category of finite reflexive quivers",
        [ IsObjectInCategoryOfReflexiveQuivers ],
        
  function ( reflexive_quiver )
    local str, loops, arrows, i, arrowhead;
    
    # Copied from DotVertexLabeledDigraph() at Digraphs/gap/display.gi
    str = "//dot\n";
    
    Append( str, "digraph quiver[\n" );
    Append( str, "rankdir=\"LR\"\n" );
    Append( str, "minlen=0\n" );
    Append( str, "node [shape=circle width=0 height=0 fontsize=12 margin=0.01 fontname=\"DejaVu Serif,serif\"]\n" );
    Append( str, "edge [arrowsize=0.5 fontsize=10 fontname=\"DejaVu Serif,serif\"]\n" );
    
    for i in AsList( reflexive_quiver.V )
        Append( str, StringGAP( i ) );
        Append( str, " [label=\"" );
        Append( str, StringGAP( i ) );
        Append( str, "\"]\n" );
    end;
    
    loops = Loops( reflexive_quiver );
    arrows = Arrows( reflexive_quiver );
    
    for i in AsList( reflexive_quiver.A )
        
        if (i in loops)
            arrowhead = "none";
        else
            arrowhead = "normal";
        end;
        
        ## https://graphviz.org/docs/attrs/fontsize/
        Append( str,
                @Concatenation(
                        StringGAP( arrows[1 + i][1] ),
                        " -> ",
                        StringGAP( arrows[1 + i][2] ),
                        " [label=\"",
                        StringGAP( i ),
                        "\" arrowhead=",
                        arrowhead,
                        "]\n" ) );
    end;
    
    Append( str, "]\n" );
    
    return str;
    
end );

##
@InstallMethod( DotVertexLabelledDigraph,
        "for a monomorphism in a category of finite reflexive quivers",
        [ IsMorphismInCategoryOfReflexiveQuivers ],
        
  function ( monomorphism )
    local reflexive_quiver, vertices, loops, arrows, str, arrows_as_pairs, i, arrowhead;
    
    @Assert( 0, IsMonomorphism( monomorphism ) );
    
    reflexive_quiver = Target( monomorphism );
    
    vertices = AsList( monomorphism.V );
    arrows = AsList( monomorphism.A );
    
    # Copied from DotVertexLabeledDigraph() at Digraphs/gap/display.gi
    str = "//dot\n";
    
    Append( str, "digraph subreflexivequiver[\n" );
    Append( str, "rankdir=\"LR\"\n" );
    Append( str, "minlen=0\n" );
    Append( str, "node [shape=circle width=0 height=0 fontsize=12 margin=0.01 fontname=\"DejaVu Serif,serif\"]\n" );
    Append( str, "edge [arrowsize=0.5 fontsize=10 fontname=\"DejaVu Serif,serif\"]\n" );
    
    for i in AsList( reflexive_quiver.V )
        Append( str, StringGAP( i ) );
        Append( str, " [label=\"" );
        Append( str, StringGAP( i ) );
        Append( str, "\"" );
        if (@not i in vertices)
            ## https://graphviz.org/doc/info/colors/
            Append( str, " fontcolor=\"azure3\"" );
            Append( str, " color=\"azure3\"" );
        end;
        Append( str, "]\n" );
    end;
    
    loops = Loops( reflexive_quiver );
    arrows_as_pairs = Arrows( reflexive_quiver );
    
    for i in AsList( reflexive_quiver.A )
        
        if (i in loops)
            arrowhead = "none";
        else
            arrowhead = "normal";
        end;
        
        ## https://graphviz.org/docs/attrs/fontsize/
        Append( str,
                @Concatenation(
                        StringGAP( arrows_as_pairs[1 + i][1] ),
                        " -> ",
                        StringGAP( arrows_as_pairs[1 + i][2] ),
                        " [label=\"",
                        StringGAP( i ),
                        "\" arrowhead=",
                        arrowhead ) );
        if (@not i in arrows)
            Append( str, " fontcolor=\"azure3\"" );
            Append( str, " color=\"azure3\"" );
        end;
        Append( str, "]\n" );
    end;
    
    Append( str, "]\n" );
    
    return str;
    
end );

##
@InstallMethod( SvgString,
        "for a cell in a category of finite reflexive quivers",
        [ IsCellInCategoryOfReflexiveQuivers ],
        
  function ( cell )
    
    return DotToSVG( DotVertexLabelledDigraph( cell ) );
    
end );

##
@InstallMethod( DisplayString,
        "for an object in a category of finite reflexive quivers",
        [ IsObjectInCategoryOfReflexiveQuivers ],
        
  function ( reflexive_quiver )
    local datum, loops, arrows, f;
    
    datum = ObjectDatum( reflexive_quiver );
    
    loops = datum[3];
    
    arrows = datum[4];
    
    f =
      function( i )
        
        if (-1 + i in loops)
            return @Concatenation( " ", StringGAP( -1 + i ), " = ", StringGAP( [ arrows[i][1] ] ) );
        end;
        
        return @Concatenation( " ", StringGAP( -1 + i ), " = ", StringGAP( arrows[i] ) );
    end;
    
    return @Concatenation( "( ", PrintString( FinSet( datum[1] ) ), ", [",
           JoinStringsWithSeparator( List( (1):(datum[2]), f ), ", " ), " ] )\n" );
    
end );

##
@InstallMethod( DisplayString,
        "for a morphism in a category of finite reflexive quivers",
        [ IsMorphismInCategoryOfReflexiveQuivers ],
        
  function ( mor )
    local F;

    F = UnderlyingCategory( CapCategory( mor ) );
    
    return @Concatenation(
            "Image of ", ViewString( F.C0 ), ":\n",
            DisplayString( mor.V ),
            "\nImage of ", ViewString( F.C1 ), ":\n",
            DisplayString( mor.A ),
            "\nA morphism in ", Name( CapCategory( mor ) ), " given by the above data\n" );
    
end );
