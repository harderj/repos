
%load players
path = pwd;
if strcmp(path(1),'/')  % mac
    addpath([path '/Players/Jacob']);
    addpath([path '/Players/Asger']);
    addpath([path '/Players/Anders/']);
else                    % windows
    addpath([path '\Players\Jacob']);
    addpath([path '\Players\Asger']);
    addpath([path '\Players\Anders']);
end