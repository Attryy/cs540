% Clear variables and close figures
clear all
close all

% Load data
load nonLinear.mat % Loads {X,y,Xtest,ytest}
[n,d] = size(X);

%Ten-folds cross validation


% Find best value of RBF parameters,
%   training on the train set and validating on the validation set
  minErr = inf;
   for sigma = 2.^[-15:15]
       for lambda = 2.^[-15:15]
       indices=crossvalind('Kfold',n,10);
    for i =1:10
   Xtrain=X(indices~=i,:);
   ytrain=y(indices~=i);
   Xvalid=X(indices==i,:);
   yvalid=y(indices==i);
    
    % Train on the training set
    model = leastSquaresRBFL2(Xtrain,ytrain,lambda,sigma);
    
    % Compute the error on the validation set
    yhat = model.predict(model,Xvalid);
    validError (i)= sum((yhat - yvalid).^2)/(n/10);
    end
    
    % Keep track of the lowest validation error
    if mean(validError) < minErr
        minErr =mean( validError);
        bestSigma = sigma;
        bestlambda = lambda;
    end
    
       end
    
   end

fprintf('Value of sigma that achieved the lowest validation error was %.3e\n',bestSigma);
fprintf('Value of lambda that achieved the lowest validation error was %.3e\n',bestlambda);

% Now fit the model based on the full dataset.
fprintf('Refitting on full training set...\n');
model = leastSquaresRBFL2(X,y,bestlambda,bestSigma);

% Compute training error
yhat = model.predict(model,X);
trainError = sum((yhat - y).^2)/n;
fprintf('Training error = %.2f\n',trainError);

% Finally, report the error on the test set
t = size(Xtest,1);
yhat = model.predict(model,Xtest);
testError = sum((yhat - ytest).^2)/t;
fprintf('Test error = %.2f\n',testError);

figure(1);
plot(X,y,'b.');
title('Training Data');
hold on
Xhat = [min(X):.1:max(X)]'; % Choose points to evaluate the function
yhat = model.predict(model,Xhat);
plot(Xhat,yhat,'g');
ylim([-300 400]);
