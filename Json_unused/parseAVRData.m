function dataStruct = parseAVRData(data)
    % This function parses the incoming JSON data and extracts the required fields.
    % The input is a JSON-formatted string and the output is a structure with fields
    % 'Reg', 'Lat', 'Lng', and 'Alt'.

    % Initialize the structure with default values
    dataStruct.Reg = '';
    dataStruct.Lat = NaN;
    dataStruct.Lng = NaN;
    dataStruct.Alt = NaN;

    % Use regular expressions to extract key-value pairs from the JSON string
    regExpr = '"Reg"\s*:\s*"([^"]*)"';
    latExpr = '"Lat"\s*:\s*([\d\.-]+)';
    lngExpr = '"Lng"\s*:\s*([\d\.-]+)';
    altExpr = '"Alt"\s*:\s*([\d\.-]+)';

    % Extract 'Reg'
    tokens = regexp(data, regExpr, 'tokens');
    if ~isempty(tokens)
        dataStruct.Reg = tokens{1}{1};
    end

    % Extract 'Lat'
    tokens = regexp(data, latExpr, 'tokens');
    if ~isempty(tokens)
        dataStruct.Lat = str2double(tokens{1}{1});
    end

    % Extract 'Lng'
    tokens = regexp(data, lngExpr, 'tokens');
    if ~isempty(tokens)
        dataStruct.Lng = str2double(tokens{1}{1});
    end

    % Extract 'Alt'
    tokens = regexp(data, altExpr, 'tokens');
    if ~isempty(tokens)
        dataStruct.Alt = str2double(tokens{1}{1});
    end
end
