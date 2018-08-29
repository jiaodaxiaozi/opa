%> @file
%>  Algorithm 14.1: Gauss-Newton method. Implementation of algorithm 14.1 of \cite Bier15-book
%> 
%> @note Tested with \ref runGaussNewton.m
%> @note Tested with \ref runNeuralNetwork.m
%>
%> @author Michel Bierlaire
%> @date Sat Mar 21 16:51:49 2015
%> @ingroup Algorithms
%> @ingroup chap14

%> Applies Gauss-Newton algorithm  to solve \f[\min_x f(x)= \frac{1}{2} g(x)^T g(x)\f] where \f$g:\mathbb{R}^n\to\mathbb{R}^m\f$. 
%> @param obj the name of the Octave function defining g(x) and its gradient matrix. It should return a vector of size m and a matrix of size n x m.
%> @param x0 the starting point
%> @param eps  algorithm stops if \f$\|\nabla g(x) g(x)\| \leq \varepsilon \f$. 
%> @param maxiter maximum number of iterations (Default: 100)
%> @return [solution,iteres,niter] 
%> @return solution: local minimum of the function
%> @return iteres: sequence of iterates generated by the algorithm. It contains n+2 columns. Columns 1:n contains the value of the current iterate. Column n+1 contains the value of the objective function. Column n+2 contains the value of the norm of the gradient. It contains maxiter rows, but only the first niter rows are meaningful.
%> @return niter: total number of iterations
function [solution,iteres,niter] = gaussNewton(obj,x0,eps,maxiter=100)
  iteres = zeros(1+ maxiter,4) ;
  n = size(x0,1) ;
  xk = x0 ;
  [g,gradg] = feval(obj,xk)  ;
  deriv = gradg * g  ;
  iteres(1,:) = [xk'  g'*g  norm(deriv) ] ;
  k = 0 ;
  do 
    dk = - gradg * gradg' \ gradg * g ;
    xk = xk + dk ;
    [g,gradg] = feval(obj,xk)  ;
    deriv = gradg * g ;
    k=k+1 ; 
    iteres(k+1,:) = [xk'  g'*g  norm(deriv) ] ;

  until (norm(deriv) <= eps || k >= maxiter)
  solution = xk ;
  niter = k ;
endfunction