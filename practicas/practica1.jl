# Practica 1

function suma_matrices(A, B)
    if size(A) != size(B)
        error("No puedo sumar matrices de dimensiones diferentes")
    end

    C = zeros(size(A))

    for i in 1:size(A, 1)
        for j in 1:size(A, 2)
            C[i,j] = A[i,j] + B[i,j]
        end
    end
    return C
end


# A = [1 2; 3 4]
# B = [2 2; 2 2]
# C = suma_matrices(A, B)
# println(C)


function producto_matrices(A, B)
    if size(A, 2) != size(B, 1)
        error("Tamaño de matrices incompatible")
    end

    C = zeros(size(A, 1), size(B, 2))

    for i in 1:size(C, 1)
        for j in 1:size(C, 2)
            for r in 1:size(A, 2)
                C[i,j] += A[i,r]*B[r,j]
            end
        end
    end

    return C
end

# using Random
# Random.seed!(0)
# a = rand(2000, 2000)
# @time producto_matrices(a, a)

function producto_matrices_p1(A, B)
    if size(A, 2) != size(B, 1)
        error("Tamaño de matrices incompatible")
    end

    C = zeros(size(A, 1), size(B, 2))

    Threads.@threads for i in 1:size(C, 1)
        for j in 1:size(C, 2)
            for r in 1:size(A, 2)
                C[i,j] += A[i,r]*B[r,j]
            end
        end
    end

    return C
end

function producto_matrices_p2(A, B)
    if size(A, 2) != size(B, 1)
        error("Tamaño de matrices incompatible")
    end

    C = zeros(size(A, 1), size(B, 2))

    for i in 1:size(C, 1)
        Threads.@threads for j in 1:size(C, 2)
            for r in 1:size(A, 2)
                C[i,j] += A[i,r]*B[r,j]
            end
        end
    end

    return C
end

function producto_matrices_p3(A, B)
    if size(A, 2) != size(B, 1)
        error("Tamaño de matrices incompatible")
    end

    C = zeros(size(A, 1), size(B, 2))

    Threads.@threads for i in 1:size(C, 1)
        Threads.@threads for j in 1:size(C, 2)
            for r in 1:size(A, 2)
                C[i,j] += A[i,r]*B[r,j]
            end
        end
    end

    return C
end

# esta es la mala
function producto_matrices_p4(A, B)
    if size(A, 2) != size(B, 1)
        error("Tamaño de matrices incompatible")
    end

    C = zeros(size(A, 1), size(B, 2))

    Threads.@threads for i in 1:size(C, 1)
        Threads.@threads for j in 1:size(C, 2)
            Threads.@threads for r in 1:size(A, 2)
                C[i,j] += A[i,r]*B[r,j]
            end
        end
    end

    return C
end
