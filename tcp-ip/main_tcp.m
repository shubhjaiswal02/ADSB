% main_tcp.m
% Main script to read TCP data from Stratux ADS-B receiver

% Define the IP address and port number
ipAddressTCP = '192.168.10.1';
portNumberTCP = 30003;

% Create a TCP/IP object for TCP data
tcpObj = tcpip(ipAddressTCP, portNumberTCP);

% Set properties for TCP
set(tcpObj, 'InputBufferSize', 30000); % Adjust buffer size as needed

% Open the TCP connection
fopen(tcpObj);

% Check if the TCP connection is open
if strcmp(get(tcpObj, 'Status'), 'open')
    disp('TCP connection established successfully');
else
    error('Failed to establish TCP connection');
end

% Continuously read data from the Stratux receiver
while true
    % Check if TCP data is available
    if get(tcpObj, 'BytesAvailable') > 0
        % Read data from the TCP receiver
        dataTCP = fscanf(tcpObj);
        
        % Display the received TCP data
        fprintf('TCP Data: %s\n', dataTCP);
    end
    
    % Pause for a short period to avoid overwhelming the CPU
    pause(0.1);
end

% Close the connection when done
fclose(tcpObj);
delete(tcpObj);
clear tcpObj;
