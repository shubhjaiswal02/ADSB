% main_combined.m
% Main script to read data from Stratux ADS-B receiver using both TCP and UDP

% Define the IP addresses and port numbers
ipAddressTCP = '192.168.10.1';
portNumberTCP = 30003;
ipAddressUDP = '0.0.0.0'; % Listen to all incoming UDP packets
portNumberUDP = 49002;

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

% Function to read and display TCP data
function readTCPData(~, ~, tcpObj)
    if get(tcpObj, 'BytesAvailable') > 0
        dataTCP = fscanf(tcpObj);
        dataArr = regexp(dataTCP, ',', 'split');
        disp(['TCP Data - Roll: ', dataArr{3}, ', Pitch: ', dataArr{4}]);
    end
end

% Function to read and display UDP data
function readUDPData(~, ~, udpObj)
    if get(udpObj, 'BytesAvailable') > 0
        dataUDP = fscanf(udpObj);
        dataArr = regexp(dataUDP, ',', 'split');
        disp(['UDP Data - Roll: ', dataArr{3}, ', Pitch: ', dataArr{4}]);
    end
end

% Create a timer for reading TCP data
tcpTimer = timer('ExecutionMode', 'fixedRate', 'Period', 0.1, ...
                 'TimerFcn', {@readTCPData, tcpObj});

% Create a timer for reading UDP data
udpTimer = timer('ExecutionMode', 'fixedRate', 'Period', 0.1, ...
                 'TimerFcn', {@readUDPData, udpObj});

% Start the timers
start(tcpTimer);
start(udpTimer);

% Run for a specified duration, then stop (example: 60 seconds)
pause(60);

% Stop and delete the timers
stop(tcpTimer);
delete(tcpTimer);
stop(udpTimer);
delete(udpTimer);

% Close the connections
fclose(tcpObj);
delete(tcpObj);
clear tcpObj;

fclose(udpObj);
delete(udpObj);
clear udpObj;

disp('Finished reading TCP and UDP data');
