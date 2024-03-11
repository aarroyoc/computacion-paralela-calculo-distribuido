function gemm_secuencial!(A, B, C)
    if size(A, 2) != size(B, 1)
        error("Tamaños de matrices incompatibles")
    end

    if size(C, 1) != size(A, 1) || size(C, 2) != size(B, 2)
        error("Tamaños de matrices incompatibles")
    end

    for i in 1:size(A, 1)
        for j in 1:size(B, 2)
            for r in 1:size(A, 2)
                C[i,j] += A[i,r]*B[r,j]
            end
        end
    end
end

using Distributed

Distributed.addprocs([("ubuntu@castilla.social", 4)], dir="/home/ubuntu", tunnel=true)

@everywhere begin
    import Pkg
    Pkg.add("DistributedArrays")
    using DistributedArrays
end

function gemm_distribuido(A, B, C) 
    if size(A, 2) != size(B, 1)
        error("Tamaños de matrices incompatibles")
    end

    if size(C, 1) != size(A, 1) || size(C, 2) != size(B, 2)
        error("Tamaños de matrices incompatibles")
    end

    AD = distribute(A, dist=(2, 1))
    BD = distribute(B, dist=(1, 2))
    CD = distribute(C, dist=(2, 2))

    range_r = 1:size(A, 2)

    @sync for w in Distributed.workers()
        @spawnat w begin
            local_C = CD[:L]
            (local_C_i, local_C_j) = localindices(CD)
            local_A = AD[local_C_i, :]
            local_B = BD[:,local_C_j]
            for i in 1:size(local_C, 1)
                for j in 1:size(local_C, 2)
                    for r in range_r
                        local_C[i, j] += local_A[i, r]*local_B[r, j]
                    end
                end
            end
        end
    end
    Array(CD)
end
            
            
    
