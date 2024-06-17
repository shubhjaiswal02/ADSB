function [reg, lat] = parseAVRData(data)
    % This function parses the incoming data and extracts the registration number and latitude.
    % The input is a string and the output is the registration number and latitude.

    % Use regular expressions to extract the required information
    regExpr = 'MSG, (\w+),';
    latExpr = ',(\d+),';

    % Extract the registration number
    regMatch = regexp(data, regExpr, 'tokens');
    if ~isempty(regMatch)
        reg = regMatch{1}{1};
    else
        reg = '';
    end

    % Extract the latitude
    latMatch = regexp(data, latExpr, 'tokens');
    if ~isempty(latMatch)
        lat = str2double(latMatch{1}{1});
    else
        lat = NaN;
    end
end
