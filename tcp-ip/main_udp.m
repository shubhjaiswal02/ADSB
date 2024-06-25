% main_udp.m
% Main script to read UDP data from Stratux ADS-B receiver

% Define the IP address and port number
ipAddressUDP = '0.0.0.0'; % Listen to all incoming UDP packets
portNumberUDP = 49002;

% Create a UDP object for UDP data
udpObj = udp(ipAddressUDP, 'LocalPort', portNumberUDP);

% Set properties for UDP
set(udpObj, 'InputBufferSize', 30000); % Adjust buffer size as needed

% Open the UDP connection
fopen(udpObj);

% Check if the UDP connection is open
if strcmp(get(udpObj, 'Status'), 'open')
    disp('UDP connection established successfully');
else
    error('Failed to establish UDP connection');
end

% Continuously read data from the Stratux receiver
while true
    % Check if UDP data is available
    if get(udpObj, 'BytesAvailable') > 0
        % Read data from the UDP receiver
        dataUDP = fscanf(udpObj);
        
        % Display the received UDP data
        fprintf('UDP Data: %s\n', dataUDP);
    end
    
    % Pause for a short period to avoid overwhelming the CPU
    pause(0.1);
end

% Close the connection when done
fclose(udpObj);
delete(udpObj);
clear udpObj;
