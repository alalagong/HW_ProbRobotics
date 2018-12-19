function [newParticles, newWeights] = resample( particles, weights)
% Given the current particles and weights, sample new particles and weights
% Use the low variance sampler from class.
% INPUTS:
%  particles    - current set of particles
%  weights      - weights for each particle
% 
% OUTPUTS:
% newParticles  - resampled particles (as many as the number of input
%                 particles)
% newWeights    - updated weights for the particles

% do some stuff here
num = size(particles,1);

c = weights(1);
i = 1;
% 
% % make sure to use the low variance sampler from class
% r = (1/num).*rand;
% for m = 1:num
%     U = r + (m - 1) * (1/num);
%     while U > c
%         i = i + 1;
%         c = c + weights(i);
%         if i>num-1
%             i = 0;
%         end
%     end
%     if i == 0
%         i=num;
%     end
%     newParticles(m,:) = particles(i,:);
% end
% 
% if size(newParticles,1) ~= num
%     fprintf('size of newParticles exist error');
%     return;
% end
%     
% newWeights = ones(num,1);
% newWeights = 1/num * newWeights;


% do some modification to increase num of particle\
increase_num = 1;
r = (1/num+increase_num).*rand;
for m = 1:num+increase_num
    U = r + (m - 1) * (1/(num+increase_num));
    while U > c
        i = i + 1;
        c = c + weights(i);
        if i>num-1
            i = 0;
        end
    end
    if i == 0
        newParticles(m,:) = particles(num,:);
    else
        newParticles(m,:) = particles(i,:);
    end
    
    
end

if size(newParticles,1) <= num
    fprintf('size of newParticles exist error');
    return;
end
    
newWeights = ones(num+increase_num,1);
newWeights = 1/(num+increase_num) * newWeights;
