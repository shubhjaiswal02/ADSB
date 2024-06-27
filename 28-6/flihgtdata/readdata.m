% Function to read and display TCP and UDP data
function readData(tcpObj, udpObj)
    global flightData;
    
    if get(tcpObj, 'BytesAvailable') > 0
        dataTCP = fscanf(tcpObj);
        processPacket(dataTCP);
    end

    if get(udpObj, 'BytesAvailable') > 0
        dataUDP = fscanf(udpObj);
        processPacket(dataUDP);
    end
end

% Function to process and update flight data
function processPacket(data)
    global flightData;
    
    dataArr = regexp(data, ',', 'split');
    if length(dataArr) < 9
        return;
    end
    
    flightNumber = dataArr{5}; % Flight number
    lat = dataArr{7};          % Latitude
    long = dataArr{8};         % Longitude
    alt = dataArr{9};          % Altitude

    if ~isfield(flightData, flightNumber)
        flightData.(flightNumber) = struct('Lat', NaN, 'Long', NaN, 'Alt', NaN);
    end

    if ~isempty(lat)
        flightData.(flightNumber).Lat = lat;
    end
    if ~isempty(long)
        flightData.(flightNumber).Long = long;
    end
    if ~isempty(alt)
        flightData.(flightNumber).Alt = alt;
    end
    
    displayFlightData(flightNumber);
end

% Function to display flight data
function displayFlightData(flightNumber)
    global flightData;
    
    data = flightData.(flightNumber);
    disp(['Flight Number: ', flightNumber, ...
          ', Latitude: ', data.Lat, ...
          ', Longitude: ', data.Long, ...
          ', Altitude: ', data.Alt]);
end
