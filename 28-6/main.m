% main_combined.m
% Main script to read data from Stratux ADS-B receiver using both TCP and UDP

% Define the IP addresses and port numbers
ipAddressTCP = '192.168.10.1';
portNumberTCP = 30003;
ipAddressUDP = '0.0.0.0'; % Listen to all incoming UDP packets
portNumberUDP = 49002;

% Create a TCP/IP object for TCP data
global tcpObj;
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

% Create a UDP object for UDP data
global udpObj;
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

% Loop to read data from TCP and UDP
try
    while true
        readData(tcpObj, udpObj);
        pause(0.1); % Short pause to avoid overwhelming the CPU
    end
catch ME
    disp(['Error: ', ME.message]);
end

% Close the connections
fclose(tcpObj);
delete(tcpObj);
clear global tcpObj;

fclose(udpObj);
delete(udpObj);
clear global udpObj;

disp('Finished reading TCP and UDP data');
