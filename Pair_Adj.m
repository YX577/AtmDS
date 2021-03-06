function Po=Pair_Adj(Pi,Hi,Ti,varargin)
%% Check the inputs
narginchk(3,5);
ips=inputParser;
ips.FunctionName=mfilename;

addRequired(ips,'Pi',@(x) validateattributes(x,{'double','char'},{'nonempty'},mfilename,'Pi'));
addRequired(ips,'Hi',@(x) validateattributes(x,{'double','char'},{'nonempty'},mfilename,'Hi'));
addRequired(ips,'Ti',@(x) validateattributes(x,{'double','char'},{'nonempty'},mfilename,'Ti'));

addOptional(ips,'Ho',0,@(x) validateattributes(x,{'double','char'},{'nonempty'},mfilename,'Ho'));
addOptional(ips,'LR',-0.0065,@(x) validateattributes(x,{'double','char'},{'nonempty'},...
    mfilename,'LR'));

parse(ips,Pi,Hi,Ti,varargin{:});
Ho=ips.Results.Ho;
LR=ips.Results.LR;
clear ips varargin

%% Adjust air pressure
R=287.0; % Ideal gass constant J/kg*K
g=9.81; % Gravitational acceleration m/s2

Pi=readCls(Pi);
Hi=readCls(Hi);
Ti=readCls(Ti);
Ho=readCls(Ho);
LR=readCls(LR);
LR=imresize(LR,size(Pi),'bilinear');

dH=Ho-Hi;
clear Ho Hi
Po=Pi./exp(g*dH./(R*(Ti+LR.*dH/2)));
end

function v2d=readCls(vb)
if isa(vb,'char')
  v2d=matfile(vb);
  vb=cell2mat(who(v2d));
  eval(sprintf('v2d=v2d.%s;',vb));
else
  v2d=vb;
end
end
