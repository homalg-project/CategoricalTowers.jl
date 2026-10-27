# SPDX-License-Identifier: GPL-2.0-or-later
# LazyCategories: Construct an equivalent lazy category out of a CAP category
#
# Implementations
#

##
@InstallMethod( SetLabel,
        "for a lazy category cell and a julia object",
        [ IsCellInLazyCategory, IsJuliaObject ],

  function( c, str )
    
    SetLabel( c, JuliaToGAP( IsString, str ) );
    
end );

##
@InstallMethod( Visualize,
        "for a cell in a lazy category",
        [ IsCellInLazyCategory ],
        
  function( c )
    
    if (IsRunningInJupyter( ))
        
        return Julia.Base.display(
                       Julia.Base.MIME( GAPToJulia( "image/svg+xml" ) ),
                       GAPToJulia( DotToSVG( DotVertexLabelledDigraph( c ) ) ) );
        
    elseif (IsRunningInPluto( ))
        
        JuliaEvalString( "import PlutoUI" );
        
        return Julia.PlutoUI.Show(
                       Julia.Base.MIME( GAPToJulia( "image/svg+xml" ) ),
                       GAPToJulia( DotToSVG( DotVertexLabelledDigraph( c ) ) ) );
        
    end;
    
    TryNextMethod( );
    
end );
