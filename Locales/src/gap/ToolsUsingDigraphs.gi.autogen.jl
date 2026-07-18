# SPDX-License-Identifier: GPL-2.0-or-later
# Locales: Locales, frames, coframes, meet semi-lattices of locally closed subsets, and Boolean algebras of constructible sets
#
# Implementations
#

#= comment for Julia

##
@InstallMethod( DigraphOfParents,
        "for a datastructure of a constructible object",
        [ IsDatastructureForConstructibleObjects ],
        
  function( C )
    local all, show_equal, nodes, parents, parents_with_multiplicity, D;
    
    all = ValueOption( "all" );
    show_equal = ValueOption( "show_equal" );
    
    if (all == true)
        nodes = C.all_nodes;
        parents = "all_parents";
    else
        nodes = C.act_nodes;
        parents = "act_parents";
    end;
    
    parents_with_multiplicity =
      function( a )
        local p, mult;
        
        p = a[parents];
        
        ## we do not expect multiplicity > 1 for inclusion arrows starting at negative nodes
        if (a.parity == false)
            return List( p, x -> IdenticalPosition( nodes, x ) );
        end;
        
        if (show_equal == false)
            mult = b -> [ IdenticalPosition( nodes, b ) ];
        else
            mult =
              function( b )
                local n;
                n = IdenticalPosition( nodes, b );
                if (IsHomSetInhabited( b, a ))
                    return [ n, n ];
                end;
                return [ n ];
            end;
        end;
        
        return @Concatenation( List( p, mult ) );
        
    end;
    
    D = List( nodes, parents_with_multiplicity );
    
    D = Digraph( D );
    
    Perform( (1):(Length( nodes )),
            function( i )
              local node, act, l;
              
              node = nodes[i];
              
              act = "";
              
              if (all == true && @not IdenticalPosition( C.act_nodes, node ) == fail)
                  act = "@";
              end;
              
              if (node.parity == true)
                  l = "+";
              else
                  l = "-";
              end;
              
              l = @Concatenation( act, StringGAP( node.number ), " (", l, StringGAP( Dimension( node.object ) ), ")" );
              
              SetDigraphVertexLabel( D, i, l );
              
          end );
    
    return D;
    
end );
    
##
@InstallMethod( DigraphOfChildren,
        "for a datastructure of a constructible object",
        [ IsDatastructureForConstructibleObjects ],
        
  function( C )
    local all, show_equal, nodes, children, children_with_multiplicity, D;
    
    all = ValueOption( "all" );
    show_equal = ValueOption( "show_equal" );
    
    if (all == true)
        nodes = C.all_nodes;
        children = "all_children";
    else
        nodes = C.act_nodes;
        children = "act_children";
    end;
    
    children_with_multiplicity =
      function( a )
        local p, mult;
        
        p = a[children];
        
        ## we do not expect multiplicity > 1 for reversed-inclusion arrows starting at positive nodes
        if (a.parity == true)
            return List( p, x -> IdenticalPosition( nodes, x ) );
        end;
        
        if (show_equal == false)
            mult = b -> [ IdenticalPosition( nodes, b ) ];
        else
            mult =
              function( b )
                local n;
                n = IdenticalPosition( nodes, b );
                if (IsHomSetInhabited( a, b ))
                    return [ n, n ];
                end;
                return [ n ];
            end;
        end;
        
        return @Concatenation( List( p, mult ) );
        
    end;
    
    D = List( nodes, children_with_multiplicity );
    
    D = Digraph( D );
    
    Perform( (1):(Length( nodes )),
            function( i )
              local node, act, l;
              
              node = nodes[i];
              
              act = "";
              
              if (all == true && @not IdenticalPosition( C.act_nodes, node ) == fail)
                  act = "@";
              end;
              
              if (node.parity == true)
                  l = "+";
              else
                  l = "-";
              end;
              
              l = @Concatenation( act, StringGAP( node.number ), " (", l, StringGAP( Dimension( node.object ) ), ")" );
              
              SetDigraphVertexLabel( D, i, l );
              
          end );
    
    return D;
    
end );
    
##
@InstallMethod( DotVertexLabelledDigraph,
        "for a datastructure of a constructible object",
        [ IsDatastructureForConstructibleObjects ],
        
  function( C )
    local D, out, str, i, j;
    
    D = DigraphOfParents( C );
    
    # Copied and modified from DotVertexLabeledDigraph() at Digraphs/gap/display.gi
    out   = OutNeighbours( D );
    str   = "//dot\n";
    
    Append( str, "digraph subobject_lattice[\n" );
    Append( str, "rankdir=\"TB\"\n" );
    Append( str, "minlen=0\n" );
    Append( str, "node [shape=circle width=0 height=0 fontsize=12 margin=0.01 fontname=\"DejaVu Serif,serif\"]\n" );
    Append( str, "edge [arrowsize=0.5]\n" );
    
    for i in DigraphVertices( D )
        Append( str, StringGAP( i ) );
        Append( str, " [label=\"" );
        Append( str, StringGAP( DigraphVertexLabel( D, i ) ) );
        Append( str, "\"]\n" );
    end;
    
  for i in DigraphVertices( D )
      for j in out[i]
          Append( str, @Concatenation( StringGAP( i ), " -> ", StringGAP( j ), "\n" ) );
      end;
  end;
  
  Append( str, "]\n" );
  
  return str;
  
end );

##
@InstallMethod( DigraphOfPoset,
        "for a proset",
        [ IsThinCategory && IsFiniteCategory ],
        
  function( P )
    local objects, offset, D;
    
    objects = SetOfObjectsOfCategory( P );
    
    offset = CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "offset", 1 );
    
    if (ValueOption( "use_vertex_labels" ) == true)
        D = Digraph( objects, IsHomSetInhabited );
    else
        D = Digraph( (offset):(offset + Length( objects ) - 1), ( i, j ) -> IsHomSetInhabited( objects[1-offset+i], objects[1-offset+j] ) );
    end;
    
    D = DigraphReflexiveTransitiveReduction( D );
    
    SetFilterObj( D, IsDigraphOfSubobjects );
    
    return D;
    
end );

##
@InstallMethod( Visualize,
        "for a datastructure of a constructible object",
        [ IsDatastructureForConstructibleObjects ],
        
  function( C )
    
    Splash( DotVertexLabelledDigraph( C ) );
    
end );

##
@InstallMethod( Visualize,
        "for a proset",
        [ IsThinCategory && IsFiniteCategory ],
        
  function( C )
    
    Splash( DotVertexLabelledDigraph( DigraphOfPoset( C ) ) );
    
end );

# =#
