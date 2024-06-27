% Function to read and display TCP and UDP data
function readData(tcpObj, udpObj)
    if get(tcpObj, 'BytesAvailable') > 0
        dataTCP = fscanf(tcpObj);
        dataArrTCP = regexp(dataTCP, ',', 'split');
        if length(dataArrTCP) >= 4
            disp(['TCP Data - Roll: ', dataArrTCP{3}, ', Pitch: ', dataArrTCP{4}]);
        end
    end

    if get(udpObj, 'BytesAvailable') > 0
        dataUDP = fscanf(udpObj);
        dataArrUDP = regexp(dataUDP, ',', 'split');
        if length(dataArrUDP) >= 4
            disp(['UDP Data - Roll: ', dataArrUDP{3}, ', Pitch: ', dataArrUDP{4}]);
        end
    end
end
