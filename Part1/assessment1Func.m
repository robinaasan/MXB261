function array_values = assessment1Func(N, P, s, w)
% N is the number of particles
% P the starting point on the first row
% rest is the probabilitites
    %N = 500; % Number of particles 
    grid = zeros(99); %99x99 units for all the places

    for i = 1:N %loop particles
        y = 1;
        if P == 1
            x = 50;
        else
            x = round((99-1).*rand(1) + 1);
        end
        disp(x)
        particle_pos = zeros(99);
        particle_pos(y, x) = 1; %starts in the middle at the top
        while y < length(grid) %while no crash or bottom
            u = rand;
            if u <= s % patricle goes south
                disp(x);
                if grid(y+1, x) == 1 %if crash then stop
                    break
                end
                % if not collision
                y = y + 1;
            elseif s <= u && u <= w % patricle goes west
                if x - 1 < 1
                    x = 99;
                end
                if grid(y, x - 1) == 1 %position taken
                    continue %go to next iteration
                end
                x = x - 1;
            else % goes east
                if x+1 > 99
                    x = 1;
                end
                if grid(y, x+1) == 1 %position taken
                    continue
                end
                x = x + 1;
            end
            particle_pos(y, x) = 1; % new position for the particle
        end
        % particle reached bottom
        if grid(y, x) ~= 1
            grid(y, x) = 1;
        end
    end

    array_values = zeros(99, 1);
    for y = 1:length(grid)
        array_values(y) = sum(grid(:, y));
    end
    sum(array_values) %% make sure there are no errors, should 
    %be the same as N
end

