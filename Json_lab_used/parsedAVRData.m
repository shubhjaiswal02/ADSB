function dataStruct = parseAVRData(data)
    % This function parses the incoming JSON data and extracts the required fields.
    % The input is a JSON-formatted string and the output is a structure with fields
    % 'Reg', 'Lat', 'Lng', and 'Alt'.

    % Parse JSON data using JSONlab
    dataStruct = loadjson(data);

    % Extract the necessary fields and handle missing fields
    if ~isfield(dataStruct, 'Reg')
        dataStruct.Reg = '';
    end
    if ~isfield(dataStruct, 'Lat')
        dataStruct.Lat = NaN;
    end
    if ~isfield(dataStruct, 'Lng')
        dataStruct.Lng = NaN;
    end
    if ~isfield(dataStruct, 'Alt')
        dataStruct.Alt = NaN;
    end
end
