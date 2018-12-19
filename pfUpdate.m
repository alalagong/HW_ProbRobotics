function [particles, weights, mu, sigma, ...
	  predParticles, predWeights, predMu, predSigma, pOfZ] = pfUpdate( particles, weights, numParticles, ...
						  u, alphas, ...
						  z, beta, ...
						  markerId, FIELDINFO)
% PF Update step
%
% INPUTS:
%  particles    - particles at time t-1
%  sigma        - particle weights at time t-1
%  numParticles - number of particles
%  u            - control at time t
%  alphas       - motion model noise
%  z            - observation at time t
%  beta         - observation noise variance
%  markerId     - ID of the marker we see at time t (get observation from)
%  FIELDINFO    - Field details for observation function
%
% OUTPUTS:
%  particles    - particles at time t
%  weights      - particle weights at time t
%  mu           - state mean at time t
%  sigma        - state covar at time t 
%  predParticles- predicted particles from PF prediction step
%  predWeights  - predicted particle weights from PF prediction step
%  predMu       - state mean from EKF prediction step
%  predSigma    - state covar from EKF prediction step
%  pOfZ         - observation likelihood
% You should almost certainly leave the header the way it is.  In particular, you need to compute all return values.

% TODO: Remove this line
% [mu, sigma, predParticles, predWeights, predMu, predSigma, pOfZ] = deal([]);

% ----------------------------------------------------------------
% ----------------------------------------------------------------
% Prediction step
% ----------------------------------------------------------------
% ---------redParticles(n,:) = -------------------------------------------------------
for n = 1:numParticles
    predParticles(n,:) = sampleOdometry(u, particles(n,:), alphas);
    zHat(n,:) = observation(predParticles(n,:), FIELDINFO, markerId);
    pOfZs(n,:) = likelihood(beta,minimizedAngle( z(1) - zHat(n,1) ));
end
[predMu,predSigma] = meanAndVariance(predParticles', numParticles);

% some stuff goes here

% ----------------------------------------------------------------
% ----------------------------------------------------------------
% Correction step
% ----------------------------------------------------------------
% ----------------------------------------------------------------

predWeights = weights.*pOfZs;
predWeights = predWeights./sum(predWeights);

[particles, weights] = resample(predParticles, predWeights);
[mu,sigma] = meanAndVariance(particles', size(particles,1));

pOfZ = mean(pOfZs);
% more stuff goes here

