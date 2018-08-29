%> \file
%>  Algorithm 17.1:  projected gradient  Implementation of algorithm 17.1 of \cite Bier15-book
%>
%> @note Tested with \ref run1702.m
%>
%> @author Michel Bierlaire
%> @date Sun Mar 22 14:47:54 2015
%> @ingroup Algorithms
%> @ingroup chap17

%> Applies the projected gradient method to solve \f$\min_x f(x) \f$ subject to \f$Ax = b\f$
%> @param obj the name of the Octave function defining \f$f(x)\f$ and \f$\nabla f(x)\f$.
%> @param A matrix of the constraint
%> @param b right-hand side of the constraint
%> @param x0 starting point
%> @param eps algorithm stops if \f$\|d_k\| \leq \varepsilon \f$. 
%> @param gamma parameter > 0 (default: 1)
%> @param maxiter maximum number of iterations (default: 100)
%> @return [solution,iteres,niter] 
%> @return solution: local minimum of the function
%> @return iteres: sequence of iterates generated by the algorithm. It contains n+2 columns. Columns 1:n contains the value of the current iterate. Column n+1 contains the value of the objective function. Column n+2 contains the value of the norm of the gradient. It contains maxiter rows, but only the first niter rows are meaningful.
%> @return niter: total number of iterations
function [solution, iteres, niter] = projectedGradient(obj,A,b,x0,eps,gamma=1,maxiter=100)
  addpath("../chap11");
  xk = x0 ;
  n = size(x0) ;
  [f,g] = feval(obj,xk)   ;
  iteres = zeros(1+ maxiter,4) ;
  k = 0 ;
  do
    dk = qp(xk, eye(n,n), gamma*g, A, b-A*xk) ;
    iteres(k+1,:) = [xk' f  norm(dk) ] ;
    if (norm(dk) > eps)
      alpha = lineSearch(obj,xk,dk,1,1.0e-4,0.99,2,0)   ;
      xk = xk + alpha * dk ;
      [f,g] = feval(obj,xk);
      k=k+1 ; 
    endif
  until (norm(dk) <= eps || k >= maxiter)
  solution = xk ;
  niter = k+1 ;
endfunction
