function [ gaussian ] = NegGaussian( hsize, sigma )
    
    ind = -floor(hsize / 2) : floor(hsize / 2);
    [u, v] = meshgrid(ind, ind);
    % Gaussian function
    gaussian = -(exp(-(u.^2 + v.^2) / sigma^2));
    
    % to normalize the gaussian
    %%gaussian = -gaussian / sum(gaussian(:));
    
end

