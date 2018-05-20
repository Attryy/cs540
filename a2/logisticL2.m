function [model] = logisticL2(X,y,lambda)

% Add bias variable
[n,d] = size(X);
X = [ones(n,1) X];
d = d+1;

% Initial values of regression parameters
w = zeros(d,1);

% Optimizaion parameters
maxPasses = 500;
progTol = 1e-4;
%L = .25*max(diag(X'*X)) + lambda;
L = .25*(diag(X'*X)) + lambda;
w_old = w;
Xw = (X*w);

for t = 1:maxPasses*d 
    
    % Choose variable to update 'j'
    j = randi(d);
    % j = sampleDiscrete(L/sum(L));
   % Compute partial derivative 'g_j'
    yXw= y.*(Xw);
    sigmoid = 1./(1+exp(-yXw));
    g_j= -(y.*(1-sigmoid))'*X(:,j) + lambda*w(j);
    
    % Update variable
    w(j) = w(j) - (1/L(j))*g_j;
    Xw = Xw- (1/L(j))*X(:,j)*g_j;
 
    % Check for lack of progress after each "pass"
    if mod(t,d) == 0
        change = norm(w-w_old,inf);
        fprintf('Passes = %d, function = %.4e, change = %.4f\n',t/d,logisticL2_loss(w,X,y,lambda),change);
        if change < progTol
            fprintf('Parameters changed by less than progTol on pass\n');
            break;
        end
        w_old = w;
    end
end


model.w = w;
model.predict = @predict;
end

function [yhat] = predict(model,Xhat)
[t,d] = size(Xhat);
Xhat = [ones(t,1) Xhat];
w = model.w;
yhat = sign(Xhat*w);
end


