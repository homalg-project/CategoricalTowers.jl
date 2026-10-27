# SPDX-License-Identifier: GPL-2.0-or-later
# LazyCategories: Construct an equivalent lazy category out of a CAP category
#
# Implementations
#

##
@InstallMethod( ListOfEvaluationNodes,
        "for a cell in a lazy category",
        [ IsCellInLazyCategory ],
        
  function( c )
    local node, nodes, queue, add_to_nodes, add_to_queue, parents, D;
    
    node = c;
    
    nodes = [ ];
    
    queue = [ node ];
    
    add_to_nodes =
      function( a )
        if (PositionProperty( nodes, b -> AreEqualForLazyCells( a, b ) ) == fail)
            Add( nodes, a );
        end;
    end;
    
    add_to_queue =
      function( a )
        if (PositionProperty( @Concatenation( nodes, queue ), b -> AreEqualForLazyCells( a, b ) ) == fail)
            Add( queue, a );
        end;
    end;
    
    while @not IsEmpty( queue )
        
        node = Remove( queue, 1 );
        
        add_to_nodes( node );
        
        if (IsList( node ))
            
            @Assert( 0, ForAll( node, IsCellInLazyCategory ) );
            
            Perform( node, add_to_queue );
            
        elseif (HasGenesisOfCell( node ))
            
            parents = GenesisOfCellArguments( node );
            
            parents = Filtered( parents, parent -> IsCellInLazyCategory( parent ) || IsList( parent ) );
            
            Perform( parents, add_to_queue );
            
        end;
        
    end;
    
    nodes = Reversed( nodes );
    
    D = List( nodes, node -> PositionsOfParentsOfALazyCell( nodes, node ) );
    
    D = Digraph( D );
    
    return nodes[DigraphTopologicalSort( D )];
    
end );

##
@InstallMethod( DigraphOfEvaluation,
        "for a cell in a lazy category",
        [ IsCellInLazyCategory ],

  function( c )
    local nodes, D;
    
    nodes = ListOfEvaluationNodes( c );
    
    D = List( nodes, node -> PositionsOfParentsOfALazyCell( nodes, node ) );
    
    D = Digraph( D );
    
    D = DigraphReverse( D );
    
    D.list_of_parents = [ ];
    
    Perform( (1):(Length( nodes )),
            function( i )
              local node, l, ints;
              
              node = nodes[i];
              
              if (HasGenesisOfCell( node ))
                  l = GenesisOfCellOperation( node );
                  l = CAP_INTERNAL_COMPACT_NAME_OF_CATEGORICAL_OPERATION( l );
                  ints = Filtered( GenesisOfCellArguments( node ), IsInt );
                  if (@not IsEmpty( ints ))
                      l = @Concatenation( l, "( ", JoinStringsWithSeparator( ints, ", " ), " )" );
                  end;
              elseif (IsCapCategoryCell( node ))
                  l = "primitive";
                  if (IsCapCategoryObject( node ))
                      l = @Concatenation( l, "\n", "object" );
                  elseif (IsCapCategoryMorphism( node ))
                      l = @Concatenation( l, "\n", "morphism" );
                  end;
                  GetLabel( node );
                  if (@IsBound( node.Label ))
                      l = @Concatenation( l, "\n<", node.Label, ">" );
                  end;
              elseif (IsList( node ))
                  l = @Concatenation( StringGAP( Length( node ) ), "-[ ... ]" );
              end;
              
              l = @Concatenation( "[", StringGAP( i ), "]\n", l );
              
              SetDigraphVertexLabel( D, i, l );
              
              D.list_of_parents[i] = PositionsOfParentsOfALazyCell( nodes, node );
              
          end );
          
    return D;
    
end );

##
@InstallMethod( DotVertexLabelledDigraph,
        "for a cell in a lazy category",
        [ IsCellInLazyCategory ],
        
  function( c )
    local D, str, i, j, list_of_parents, parents, l;
    
    D = DigraphOfEvaluation( c );
    
    # Copied from DotVertexLabeledDigraph() at Digraphs/gap/display.gi
    str = "//dot\n";
    
    Append( str, "digraph DigraphOfEvaluation[\n" );
    Append( str, "node [shape=rect]\n" );
    
    for i in DigraphVertices( D )
        Append( str, StringGAP(i) );
        Append( str, " [label=\"" );
        Append( str, StringGAP( DigraphVertexLabel( D, i ) ) );
        Append( str, "\"]\n" );
    end;
    
    list_of_parents = D.list_of_parents;
    
    for i in DigraphVertices( D )
        parents = list_of_parents[i];
        l = Length( parents );
        if (l > 1 && Length( SetGAP( parents ) ) > 1)
            for j in (1):(l)
                Append( str, @Concatenation( StringGAP(parents[j]), " -> ", StringGAP(i), " [label=\"", StringGAP(j), "\"]\n" ) );
            end;
        else
            for j in (1):(l)
                Append( str, @Concatenation( StringGAP(parents[j]), " -> ", StringGAP(i), "\n" ) );
            end;
        end;
    end;
    
    Append( str, "]\n" );
    
    return str;
    
end );

##
@InstallMethod( Visualize,
        "for a cell in a lazy category",
        [ IsCellInLazyCategory ],
        
  function( c )
    
    Splash( DotVertexLabelledDigraph( c ) );
    
end );
