function [ data ] = normalizeData( data )

%usizmaju se poslednje 3 kolone 
temp=data(:,size(data,2)-2:size(data,2));
maxVariable=max(temp);
minVariable=min(temp);

%multipliciramo vektor min i max da ako je npr bio 1 2 sad ce biti 1 2
                                                                  %1 2
                                                                  %1 2
                                                                   %itd da
                                                                   %bude
                                                                   %istih
                                                                   %dienzija
                                                                   %kao
                                                                   %temp
maxVariable=repmat(maxVariable,size(temp,1),1);
minVariable=repmat(minVariable,size(temp,1),1);

kolicnik=maxVariable-minVariable;

%normalizacija

ntemp=(temp-minVariable)./kolicnik;
data(:,size(data,2)-2:size(data,2))=ntemp;



end

