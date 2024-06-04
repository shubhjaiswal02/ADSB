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

% Continuously read data from the Stratux receiver
while true
    % Check if data is available
    if get(t, 'BytesAvailable') > 0
        % Read data from the receiver
        data = fscanf(t);
        
        % Process the data to extract key-value pairs
        dataStruct = parseAVRData(data);
        
        % Display specific keys if they exist
        if isfield(dataStruct, 'Reg')
            reg = dataStruct.Reg;
        else
            reg = '';
        end
        
        if isfield(dataStruct, 'Lat')
            lat = dataStruct.Lat;
        else
            lat = NaN;
        end
        
        if isfield(dataStruct, 'Lng')
            lng = dataStruct.Lng;
        else
            lng = NaN;
        end
        
        if isfield(dataStruct, 'Alt')
            alt = dataStruct.Alt;
        else
            alt = NaN;
        end
        
        fprintf('Reg: %s, Lat: %.6f, Lng: %.6f, Alt: %.2f\n', reg, lat, lng, alt);
        
        % Optional: add your own logic to use other keys here
    end
    
    % Pause for a short period to avoid overwhelming the CPU
    pause(0.1);
end

% Close the connection when done
fclose(t);
delete(t);
clear t;
