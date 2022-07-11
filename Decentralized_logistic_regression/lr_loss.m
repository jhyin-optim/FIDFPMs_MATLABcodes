% the regularized decentralized logistic regression
% $\min \frac{1}{m}\sum_{i=1}^m \log(1+ \exp(-b_ia_i^Tx)) + \lambda\|x\|^2/2$
function out = lr_loss(A,b,m,x,lambda )

Ax = A*x;
Atran = A';
expba = exp(-b.*Ax);
%% f = sum(log(1 + expba))/m + lambda*norm(x)^2/2; %%
% compute the gradient of the objective function at point x

% %% F(x)=\frac{1}{m}\sum_{i=1}^m a_i(b_i-b_i/(1+\exp(b_ia_i^Tx)))+\lambda  x
% out = Atran*(b - b./(1+expba))/m + lambda *x;
%% F(x)=\frac{1}{m}\sum_{i=1}^m -b_i*exp(-b_ia_i^Tx)a_i/(1+\exp(-b_ia_i^Tx))+\lambda x
out = Atran*(b./(1+expba) - b)/m + lambda *x;
end