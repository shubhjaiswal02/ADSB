% main.m
% Main script to read data from Stratux ADS-B receiver

% Define the IP address and port number
ipAddress = '192.168.10.1';
portNumber = 30003;

% Create a TCP/IP object
t = tcpip(ipAddress, portNumber);

% Set properties
set(t, 'InputBufferSize', 30000); % Adjust buffer size as needed

% Open the connection
fopen(t);

% Check if the connection is open
if strcmp(get(t, 'Status'), 'open')
    disp('Connection established successfully');
else
    error('Failed to establish connection');
end

% Initialize a structure to store flight data
flightData = struct();

% Continuously read data from the Stratux receiver
while true
    % Check if data is available
    if get(t, 'BytesAvailable') > 0
        % Read data from the receiver
        data = fscanf(t);
        dataArr = regexp(data, ',', 'split');
        
        % Extract the relevant fields
        if length(dataArr) >= 8
            targetID = dataArr{5};
            newAlt = dataArr{6};
            newLat = dataArr{7};
            newLong = dataArr{8};
            
            % Check if the targetID already exists
            if isfield(flightData, targetID)
                % Get the existing data
                oldData = flightData.(targetID);
            else
                % Initialize new data
                oldData = struct('Alt', '', 'Lat', '', 'Long', '');
            end
            
            % Display changes only if the data has changed
            if ~strcmp(newAlt, oldData.Alt)
                fprintf('Flight %s Alt changed: %s -> %s\n', targetID, oldData.Alt, newAlt);
                oldData.Alt = newAlt;
            end
            if ~strcmp(newLat, oldData.Lat)
                fprintf('Flight %s Lat changed: %s -> %s\n', targetID, oldData.Lat, newLat);
                oldData.Lat = newLat;
            end
            if ~strcmp(newLong, oldData.Long)
                fprintf('Flight %s Long changed: %s -> %s\n', targetID, oldData.Long, newLong);
                oldData.Long = newLong;
            end
            
            % Update the structure with the new data
            flightData.(targetID) = oldData;
        end
    end
    
    % Pause for a short period to avoid overwhelming the CPU
    pause(0.1);
end

% Close the connection when done
fclose(t);
delete(t);
clear t;
