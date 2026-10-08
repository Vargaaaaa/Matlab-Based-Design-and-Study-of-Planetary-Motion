function solarSystemSizeControl()


    % Planets nume, diametru initial (km), Color, Textura 
    planets = {
        'Mercury', 4879, [0.7 0.7 0.7], 'mercury.jpg';
        'Venus', 12104, [0.9 0.8 0.5], 'venus.jpg';
        'Earth', 12742, [0.4 0.8 1.0], 'earth.jpg';
        'Mars', 6779, [1.0 0.5 0.5], 'mars.jpg';
    };


    % Create the 3D representation figure
    solarFig = figure('Name', 'Solar System Representation', ...
        'Units', 'normalized', 'Position', [0.2, 0.2, 0.6, 0.7], ...
        'NumberTitle', 'off', 'Color', [0.0 0.0 0.2]); 
    hold on;
    axis equal;
    axis off;
    view(3);


     bgAxes = axes('Parent', solarFig, 'Units', 'normalized', ...
                  'Position', [0, 0, 1, 1]); % Cover the entire figure
    backgroundImage = imread('sky1.jpg'); % Replace with sky1
    imagesc(backgroundImage, 'Parent', bgAxes); % Display img
    set(bgAxes, 'YDir', 'reverse'); % Flip Y-axis sa nu apara invers
    set(bgAxes, 'HandleVisibility', 'off'); % No background interaction
    uistack(bgAxes, 'bottom'); %background axes to the back





    %initializez planetele
    numPlanets = size(planets, 1);
    planetHandles = gobjects(numPlanets, 1);

    for i = 1:numPlanets
        [x, y, z] = sphere(50);
        scaledRadius = planets{i, 2} / 10000; % Scale size for visualization

        % Apply texture to the planet
        texture = imread(planets{i, 4}); %pun textura pe ele
        planetHandles(i) = surface(scaledRadius * x + 3 * i, ...
                                   scaledRadius * y, ...
                                   scaledRadius * z, ...
                                   'FaceColor', 'texturemap', ...
                                   'EdgeColor', 'none', ...
                                   'CData', texture); % Apply texture
    end

    lighting phong;
    camlight;

    %Putting the same color as the main menu

    controlFig = figure('Name', 'Control Panel', ...
        'Units', 'normalized', 'Position', [0.8, 0.3, 0.2, 0.7], ...
        'NumberTitle', 'off', 'Color', [0.9 0.9 1]); 

    % Add sliders and labels for each planet
    for i = 1:numPlanets
        % Label for the planet
        uicontrol('Style', 'text', 'String', planets{i, 1}, ...
            'Units', 'normalized', ...
            'Position', [0.1, 0.9 - 0.1 * i, 0.4, 0.05], ...
            'BackgroundColor', [0.9 0.9 1], ...
            'ForegroundColor', '#330066', ...
            'FontName', 'Times New Roman', ...
            'FontSize', 14, 'FontWeight', 'bold');



        

        % Slider for adjusting size
        uicontrol('Style', 'slider', ...
            'Units', 'normalized', ...
            'Position', [0.5, 0.9 - 0.1 * i, 0.4, 0.05], ...
            'Min', planets{i, 2} * 0.5, 'Max', planets{i, 2} * 2, ...
            'Value', planets{i, 2}, ...
            'BackgroundColor', [0.9 0.9 1], ...
            'Callback', @(src, ~) updateSize(i, src.Value));
    end

    % Back to Main Menu Button
    uicontrol('Style', 'pushbutton', 'String', 'Back to Main Menu', ...
        'Units', 'normalized', ...
        'Position', [0.3, 0.05, 0.4, 0.1], ...
        'BackgroundColor', '#f3e6ff', ...
        'ForegroundColor', '#330066', ...
        'FontName', 'Times New Roman', ...
        'FontWeight', 'Bold', ...
        'Callback', @backToMainMenu);

    % Callback ptUpdate Planet Size
    function updateSize(index, newDiameter)

        % Update planet size in the 3D visualization
        scaledRadius = newDiameter / 10000;
        [x, y, z] = sphere(50);
        set(planetHandles(index), ...
            'XData', scaledRadius * x + 3 * index, ...
            'YData', scaledRadius * y, ...
            'ZData', scaledRadius * z);
        fprintf('%s: Diameter updated to %.2f km\n', planets{index, 1}, newDiameter);
    end

    % Callback Back to Main Menu
    function backToMainMenu(~, ~)

        if isvalid(controlFig)
            close(controlFig);
        end
        if isvalid(solarFig)
            close(solarFig);
        end
        mainMenu(); 
    end
end