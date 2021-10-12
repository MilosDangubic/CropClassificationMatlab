clear;
clc;
for ii=1:10
%%%%%%%%%%% UCITAVANJE PODATAKA ZA KROSVALIDACIJU %%%%%%%%%%%%%%%%%%    
    trainFilePath=sprintf('podaci_spremni za_krosvalidaciju_sa_10_podskupova/_train_%d',ii);
    testFilePath=sprintf('podaci_spremni za_krosvalidaciju_sa_10_podskupova/_test_%d',ii);
    load(trainFilePath);
    load(testFilePath);
  
  
   
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



KNN=fitcknn(nTrainData,train_data_labels);

KNN.NumNeighbors=3;
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

testDataImage1=testDataValues(:,1:10);
testDataImage1=normalizeData(testDataImage1);

testDataImage2=testDataValues(:,11:20);
testDataImage2=normalizeData(testDataImage2);

testDataImage3=testDataValues(:,21:30);
testDataImage3=normalizeData(testDataImage3);

testDataImage4=testDataValues(:,31:40);
testDataImage4=normalizeData(testDataImage4);

testDataValue=[testDataImage1 testDataImage2 testDataImage3 testDataImage4];


%%%%%%%%%%% NORMALIZACIJA SKUPA ZA OBUKU %%%%%%%%%%%%%%%%%%%%
load('skup_Za_Obuku_Landsat8_30_187_6Klasa');

pixelValuesImage1=pixelValues(:,1:10);
pixelValuesImage1=normalizeData(pixelValuesImage1);

pixelValuesImage2=pixelValues(:,11:20);
pixelValuesImage2=normalizeData(pixelValuesImage2);

pixelValuesImage3=pixelValues(:,21:30);
pixelValuesImage3=normalizeData(pixelValuesImage3);

pixelValuesImage4=pixelValues(:,31:40);
pixelValuesImage4=normalizeData(pixelValuesImage4);

pixelValues=[pixelValuesImage1 pixelValuesImage2 pixelValuesImage3 pixelValuesImage4];

tKNN=fitcknn(pixelValues,pixelID);

tKNN.NumNeighbors=3;
tOutputLabelKNN=tKNN.predict(testDataValue);
