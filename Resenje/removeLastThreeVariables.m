function [ oDataSet ] = removeLastThreeVariables( dataSet )


oDataSet=dataSet(:,[1:7 11:17 21:27 31:37]);
end

