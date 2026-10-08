function graphsPage()
    % Planets ,nume si viteza de rotatie
    planets = {
        'Mercury', 1;
        'Venus', 0.2;
        'Earth', 1;
        'Mars', 0.8;
    };

    % vectorul de timp
    t = 0:0.1:20; % 20s

   


    graphFig = figure('Name', 'Graphs: Rotational Speeds', ...
        'Units', 'normalized', 'Position', [0.2, 0.2, 0.6, 0.7], ...
        'NumberTitle', 'off', 'Color', [0.9 0.9 1]);

    % Axes for plotting
    axesHandle = axes('Position', [0.1, 0.4, 0.8, 0.5]);
    hold on;

    % Initial plot handles for each planet
    plotHandles = gobjects(length(planets), 1);
    for i = 1:length(planets)
        rotationalSpeed = planets{i, 2};
        signal = rotationalSpeed * sin(2 * pi * t / 10);
        plotHandles(i) = plot(t, signal, 'DisplayName', planets{i, 1});
    end
    hold off;


  
    legend show;
    title('Rotational Speeds of Planets');
    xlabel('Time (s)');
    ylabel('Rotational Speed');
    grid on;


    % user input fields
    inputHandles = gobjects(length(planets), 1);
    for i = 1:length(planets)

        % labels for input
        uicontrol('Style', 'text', 'String', planets{i, 1}, ...
            'Units', 'normalized', ...
            'Position', [0.1, 0.3 - (i - 1) * 0.05, 0.2, 0.03], ...
            'BackgroundColor', [0.9 0.9 1], ...
            'ForegroundColor', '#330066', ...
            'FontName', 'Times New Roman', ...
            'FontWeight', 'Bold', ...
            'HorizontalAlignment', 'left');


        % input for rotational speed.
        inputHandles(i) = uicontrol('Style', 'edit', ...
            'String', num2str(planets{i, 2}), ... %val initiala
            'Units', 'normalized', ...
            'Position', [0.3, 0.3 - (i - 1) * 0.05, 0.2, 0.03], ...
            'BackgroundColor', '#ffffff', ...
            'ForegroundColor', '#000000', ...
            'FontName', 'Times New Roman', ...
            'FontWeight', 'Bold', ...
            'HorizontalAlignment', 'center');
    end

    % Update Graph-buton
    uicontrol('Style', 'pushbutton', 'String', 'Update Graph', ...
        'Units', 'normalized', ...
        'Position', [0.6, 0.05, 0.3, 0.05], ...
        'BackgroundColor', '#f3e6ff', ...
        'ForegroundColor', '#330066', ...
        'FontName', 'Times New Roman', ...
        'FontWeight', 'Bold', ...
        'Callback', @updateGraph);


    uicontrol('Style', 'pushbutton', 'String', 'Back to Main Menu', ...
        'Units', 'normalized', ...
        'Position', [0.1, 0.05, 0.3, 0.05], ...
        'BackgroundColor', '#f3e6ff', ...
        'ForegroundColor', '#330066', ...
        'FontName', 'Times New Roman', ...
        'FontWeight', 'Bold', ...
        'Callback', @backToMain);



   % Callback: Update Graph
function updateGraph(~, ~)
    % New rotational speeds - input fields
    for j = 1:length(planets)
        newSpeed = str2double(get(inputHandles(j), 'String')); % Convert input to number
        planets{j, 2} = newSpeed; % Update viteza planetei
    end


    % Update graph-new values
    for j = 1:length(planets)
        newSignal = planets{j, 2} * sin(2 * pi * t / 10);
        set(plotHandles(j), 'YData', newSignal); % Update YData of the plot
    end
end

    % Callback Back-Main Menu
    function backToMain(~, ~)
        close(graphFig);
        mainMenu();
    end
end