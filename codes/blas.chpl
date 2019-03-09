// . ~/startSingleLocale.sh
// module load gcc/7.3.0 openblas/0.3.4
// chpl blas.chpl -o blas -lopenblas

use LinearAlgebra;

// var A = Matrix([0.0, 1.0, 1.0],
//                [1.0, 0.0, 1.0],
//                [1.0, 1.0, 0.0]);
// var I = eye(3,3); // the identity matrix
// var B = A + I;

// var A = Matrix([2.0, 1.0],
//                [1.0, 2.0]);
// var (eigenvalues, eigenvectors) = eigvals(A, right=true);
// writeln(eigenvalues);
// writeln(eigenvectors);

// var A = Matrix(3,5);
// A = 2;
// var AA = A.dot(A.T);
// writeln(AA);

var A = Matrix([0.0, 1.0, 1.0],
               [1.0, 0.0, 1.0],
               [1.0, 1.0, 0.0]);
writeln(A.dot(A));
