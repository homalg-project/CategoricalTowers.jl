# SPDX-License-Identifier: GPL-2.0-or-later
# Locales: Locales, frames, coframes, meet semi-lattices of locally closed subsets, and Boolean algebras of constructible sets
#
# Implementations
#

##
@InstallMethod( -,
        "for a constructible object and the zero integer",
        [ IsConstructibleObject, IsInt ],
        
  function( A, B )
    
    if (!( HasIsZero( B ) && IsZero( B ) ))
        TryNextMethod( );
    end;
    
    return A;
    
end );

##
@InstallMethod( AdditiveInverseMutable,
        "for a constructible object",
        [ IsConstructibleObject ],
        
  function( A )
    
    return TerminalObject( CapCategory( A ) ) - A;
    
end );

##
@InstallMethod( NormalizeObject,
        "for a constructible object",
        [ IsConstructibleObject ],
        
  function( A )
    
    List( A, NormalizeObject );
    
    return A;
    
end );

##
@InstallMethod( StandardizeObject,
        "for a constructible object",
        [ IsConstructibleObject ],
        
  function( A )
    
    List( A, StandardizeObject );
    
    return A;
    
end );

##
@InstallMethod( Closure,
        "for a constructible object",
        [ IsConstructibleObject ],
        
  function( A )
    local H;
    
    H = UnderlyingCategory( CapCategory( A ) );
    
    if (HasIsCocartesianCoclosedCategory( H ) && IsCocartesianCoclosedCategory( H ))
        return Coproduct( List( A, Closure ) );
    end;
    
    TryNextMethod( );
    
end );

##
@InstallMethod( IsClosedSubobject,
        "for a constructible object",
        [ IsConstructibleObject ],
        
  function( A )
    
    return AreIsomorphicForObjectsIfIsHomSetInhabited( A, ClosureAsConstructibleObject( A ) );
    
end );

##
@InstallMethod( IsClosed,
        "for a constructible object",
        [ IsConstructibleObject ],
        
  IsClosedSubobject );

##
@InstallMethod( IsOpen,
        "for a constructible object",
        [ IsConstructibleObject ],
        
  function( A )
    
    return IsClosed( -A );
    
end );

##
@InstallMethod( IsLocallyClosed,
        "for a constructible object",
        [ IsConstructibleObject ],
        
  function( A )
    
    return IsClosed( Closure( A ) - A );
    
end );

##
@InstallMethod( LocallyClosedPart,
        "for a constructible object",
        [ IsConstructibleObject ],
        
  function( A )
    local C;
    
    C = Closure( A );
    
    if (IsClosed( A ))
        return C;
    end;
    
    return C - Closure( C - A );
    
end );

##
@InstallMethod( CanonicalObjectOp,
        "for a constructible object",
        [ FilterIntersection( IsConstructibleObject, IsLocallyClosed ) ],
        
  LocallyClosedPart );

##
@InstallMethod( CanonicalObjectOp,
        "for a constructible object",
        [ IsConstructibleObject ],
        
  function( A )
    local C, LCP;
    
    if (IsInitial( A ))
        return InitialObject( CapCategory( A ) );
    end;
    
    C = LocallyClosedPart( A );
    
    if (HasIsLocallyClosed( A ) && IsLocallyClosed( A ))
        return C;
    end;
    
    A = A - C;
    
    while @not IsInitial( A )
        
        LCP = LocallyClosedPart( A );
        
        C = C + LCP;
        
        A = A - LCP;
        
    end;
    
    return C;
    
end );

##
@InstallMethod( CanonicalObject,
        "for a constructible object",
        [ IsConstructibleObject ],
        
  function( A )
    
    A = ShallowCopy( List( A ) );
    
    A[1] = CanonicalObjectOp( A[1] );
    
    return Iterated( A, function( C, D ) return CanonicalObjectOp( C + D ); end );
    
end );

##
@InstallMethod( FactorizeObject,
        "for a constructible object",
        [ IsConstructibleObject ],
        
  function( A )
    
    A = List( A, FactorizeObject );
    
    A = UnionOfMultipleDifferences( A );
    
    SetFactorizeObject( A, A );
    
    return A;
    
end );

##
@InstallMethod( Dimension,
        "for a constructible object",
        [ IsConstructibleObject ],
        
  function( A )
    
    return Dimension( Closure( A ) );
    
end );

##
@InstallMethod( DegreeAttr,
        "for a constructible object",
        [ IsConstructibleObject ],
        
  function( A )
    
    return DegreeAttr( Closure( A ) );
    
end );

##
@InstallMethod( Degree,
        "for a constructible object",
        [ IsConstructibleObject ],
        
  DegreeAttr );


##
@InstallMethod( Length,
        "for a constructible object",
        [ IsConstructibleObject ],
        
  C -> Length( List( C ) ) );

##
@InstallMethod( getindex,
        "for a constructible object and a positive integer",
        [ IsConstructibleObject, IsPosInt ],
        
  function( A, pos )
    
    return List( A )[pos];
    
end );

##
@InstallMethod( ListOp,
        "for a constructible object as a union of formal multiple differences and a function",
        [ IsConstructibleObjectAsUnionOfMultipleDifferences, IsFunction ],
        
  function( A, f )
    
    return List( List( A ), f );
    
end );

#= comment for Julia
##
@InstallMethod( Iterator,
        "for a constructible object",
        [ IsConstructibleObject ],
        
  A -> Iterator( List( A ) ) );
# =#

##
@InstallMethod( ForAllOp,
        "for a constructible object and a function",
        [ IsConstructibleObject, IsFunction ],
        
  function( A, f )
    
    return ForAll( List( A ), f );
    
end );

##
@InstallMethod( ForAnyOp,
        "for a constructible object and a function",
        [ IsConstructibleObject, IsFunction ],
        
  function( A, f )
    
    return ForAny( List( A ), f );
    
end );

##
@InstallMethod( ViewString,
        "for a constructible object",
        [ IsConstructibleObject ],

  function( A )
    local n, str, i;
    
    A = List( A );
    
    n = Length( A );

    if (n == 0)
        return "∅";
    end;
    
    str = "( ";
    
    Append( str, ViewString( A[1]; Locales_number = "1" ) );
    
    for i in (2):(n)
        Append( str, " ) ∪ ( " );
        Append( str, ViewString( A[i]; Locales_number = StringGAP( i ) ) );
    end;
    
    Append( str, " )" );
    
    return str;
    
end );

##
@InstallMethod( StringGAP,
        "for a constructible object",
        [ IsConstructibleObject ],
        
  ViewString );

##
@InstallMethod( DisplayString,
        "for a constructible object",
        [ IsConstructibleObject ],

  function( A )
    local n, display, s, i;
    
    A = List( A );
    
    n = Length( A );
    
    if (n == 0)
        return "( ∅\n\n\\ ∅ )\n";
    end;
    
    s = DisplayString( A[1] );
    if (Length( s ) > 0 && s[Length( s )] == '\n')
        s = s[(1):(Length( s ) - 1)];
    end;
    display = @Concatenation( "( ", s, " )" );
    
    for i in (2):(n)
        Append( display, "\n\n∪\n\n" );
        s = DisplayString( A[i] );
        if (Length( s ) > 0 && s[Length( s )] == '\n')
            s = s[(1):(Length( s ) - 1)];
        end;
        Append( display, @Concatenation( "( ", s, " )" ) );
    end;
    
    Append( display, "\n" );
    
    return display;
    
end );
