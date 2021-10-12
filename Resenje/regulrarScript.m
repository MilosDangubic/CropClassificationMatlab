clear;
clc;
%load('skup_Za_Obuku_Landsat8_30_187_6Klasa');


for ii=1:10
   
%%%%%%%%%%% UCITAVANJE PODATAKA ZA KROSVALIDACIJU %%%%%%%%%%%%%%%%%%    
    trainFilePath=sprintf('podaci_spremni za_krosvalidaciju_sa_10_podskupova/_train_%d',ii);
    testFilePath=sprintf('podaci_spremni za_krosvalidaciju_sa_10_podskupova/_test_%d',ii);
    load(trainFilePath);
    load(testFilePath);
  
  


%%%%%%%%%%%%% KNN %%%%%%%%%%%%%%%%


KNN=fitcknn(train_data_values,train_data_labels);

KNN.NumNeighbors=1;
outputLabelKNN=KNN.predict(test_data_values);
confKNN=confusionmat(test_data_labels,outputLabelKNN);
dataAccKN1(ii)=trace(confKNN)/sum(sum(confKNN));

end
avgDataAccKNN4=sum(dataAccKNN4)/size(dataAccKNN4,2);
save('dataAccKNN4.mat','dataAccKNN4');
save('avgDataAccKNN4.mat','avgDataAccKNN4');



