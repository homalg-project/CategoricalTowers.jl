# SPDX-License-Identifier: GPL-2.0-or-later
# FunctorCategories: Categories of functors
#
# Implementations
#

##
@InstallMethod( DecomposeOnceByRandomEndomorphism,
        "for an object in a Hom-category",
        [ IsObjectInFunctorCategory ],
        
    @FunctionWithNamedArguments(
    [
        [ "random", true ],
    ],
    function ( CAP_NAMED_ARGUMENTS, F )
        local d, endbas, k, n, b, alpha, i, alpha2, keremb;
    
    d = Maximum( List( ValuesOfFunctor( F )[1], ObjectDatum ) );
    
    if (d == 0)
        return fail;
    end;
    
    endbas = ShallowCopy( BasisOfExternalHom( F, F ) );
    
    Add( endbas, ZeroMorphism( F, F ) );
    
    k = CommutativeSemiringOfLinearCategory( CapCategory( F ) );
    
    n = IntGAP( Log2( Float( d ) ) ) + 1;
    
    for b in Reversed( (2):(Length( endbas )) )
        
        if (random)
            alpha = endbas[b] + Random( k ) * endbas[b-1];
        else
            alpha = endbas[b] + endbas[b-1];
        end;
        
        SetFilterObj( alpha, IsMultiplicativeElementWithInverse );
        
        for i in (1):(n)
            alpha2 = PreCompose( alpha, alpha );
            if (IsCongruentForMorphisms( alpha, alpha2 ))
                break;
            end;
            alpha = alpha2;
        end;
        
        if (IsZero( alpha ))
            continue;
        end;
        
        keremb = KernelEmbedding( alpha );
        
        if (IsZero( keremb ))
            continue;
        end;
        
        return [ ImageEmbedding( alpha ), keremb ];
        
    end;
    
    return fail;
    
end ) );

##
@InstallMethod( WeakDirectSumDecomposition,
        "for an object in a Hom-category",
        [ IsObjectInFunctorCategory ],
        
    @FunctionWithNamedArguments(
    [
        [ "random", true ],
    ],
    function ( CAP_NAMED_ARGUMENTS, F )
        local queue, summands, eta, result;
    
    queue = [ IdentityMorphism( F ) ];
    
    summands = [ ];
    
    while @not IsEmpty( queue )
        
        eta = Remove( queue );
        
        result = DecomposeOnceByRandomEndomorphism( Source( eta ); random = random );
        
        if (result == fail)
            Add( summands, eta );
        else
            Append( queue, List( result, emb -> PreCompose( emb, eta ) ) );
        end;
        
    end;
    
    return summands;
    
end ) );
