skripta_za_vizuelno_upoznavanje_sa_podacima;
clear;
clc;
%load('skup_Za_Obuku_Landsat8_30_187_6Klasa');
load('test_Slika_Landsat8_30_187_028');

for ii=1:10
   ii=1;
%%%%%%%%%%% UCITAVANJE PODATAKA ZA KROSVALIDACIJU %%%%%%%%%%%%%%%%%%    
    trainFilePath=sprintf('podaci_spremni za_krosvalidaciju_sa_10_podskupova/_train_%d',ii);
    testFilePath=sprintf('podaci_spremni za_krosvalidaciju_sa_10_podskupova/_test_%d',ii);
    load(trainFilePath);
    load(testFilePath);
  
  
    %%%%%%%%% EXTRACT DATA FOR DIFERENT IMAGES %%%%%%%%%%
    %trainData=removeLastThreeVariables(train_data_values);
   %testData=removeLastThreeVariables(test_data_values);
    %%%%%%%%%%%%%%%% NORMALIZE DATA PER IMAGE %%%%%%%%%%%%%%%%%%%%%
    trainDataImage1=train_data_values(:,1:10);
    trainDataImage2=train_data_values(:,11:20);
    trainDataImage3=train_data_values(:,21:30);
    trainDataImage4=train_data_values(:,31:40);
    
    nTrainDataImage1=normalizeData(trainDataImage1);
    nTrainDataImage2=normalizeData(trainDataImage2);
    nTrainDataImage3=normalizeData(trainDataImage3);
    nTrainDataImage4=normalizeData(trainDataImage4);
    
    testDataImage1=test_data_values(:,1:10);
    testDataImage2=test_data_values(:,11:20);
    testDataImage3=test_data_values(:,21:30);
    testDataImage4=test_data_values(:,31:40);
    nTestDataImage1=normalizeData(testDataImage1);
    nTestDataImage2=normalizeData(testDataImage2);
    nTestDataImage3=normalizeData(testDataImage3);
    nTestDataImage4=normalizeData(testDataImage4);
    
    
    nTrainData=[nTrainDataImage1 nTrainDataImage2 nTrainDataImage3 nTrainDataImage4];
    nTestData=[nTestDataImage1 nTestDataImage2 nTestDataImage3 nTestDataImage4];

%

%%%%%%%%%%%%% KNN %%%%%%%%%%%%%%%%

%%%%IZDVAJANJE POSLEDJA 3 KANALA %%%%%%%%%%%%%%%
%train_data_values=removeLastThreeVariables(train_data_values);
%test_data_values=removeLastThreeVariables(test_data_values);

KNN=fitcknn(nTrainData,train_data_labels);

KNN.NumNeighbors=4;
outputLabelKNN=KNN.predict(nTestData);
confKNN=confusionmat(test_data_labels,outputLabelKNN);
nDataAccKNN4(ii)=trace(confKNN)/sum(sum(confKNN));

end
avgNDataAccKNN4=sum(nDataAccKNN4)/size(nDataAccKNN4,2);
save('nDataAccKNN4.mat','nDataAccKNN4');
save('avgNDataAccKNN4.mat','avgNDataAccKNN4');

%%%%%%%%%%%% UCITAVANJE SLIKE ZA VIZUELNI PRIKAZ KLASIFIKACIJE


load('test_Slika_Landsat8_30_187_028');
S=size(data);
testData= reshape(data,[S(1)*S(2),S(3)]);


testDataValues=testData;

testDataImage1=testDataValues(:,1:7);


testDataImage2=testDataValues(:,11:17);


testDataImage3=testDataValues(:,21:27);


testDataImage4=testDataValues(:,31:37);


testDataValue=[testDataImage1 testDataImage2 testDataImage3 testDataImage4];


%%%%%%%%%%% NORMALIZACIJA SKUPA ZA OBUKU %%%%%%%%%%%%%%%%%%%%
load('skup_Za_Obuku_Landsat8_30_187_6Klasa');

pixelValuesImage1=pixelValues(:,1:7);

pixelValuesImage2=pixelValues(:,11:17);

pixelValuesImage3=pixelValues(:,21:27);


pixelValuesImage4=pixelValues(:,31:37);


pixelValues=[pixelValuesImage1 pixelValuesImage2 pixelValuesImage3 pixelValuesImage4];

tKNN=fitcknn(pixelValues,pixelID);

tKNN.NumNeighbors=3;
ToutputLabelKNN=tKNN.predict(testDataValue);








