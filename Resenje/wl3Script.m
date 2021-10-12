
%load('skup_Za_Obuku_Landsat8_30_187_6Klasa');
load('test_Slika_Landsat8_30_187_028');

for ii=1:10
ii=4;
%%%%%%%%%%% UCITAVANJE PODATAKA ZA KROSVALIDACIJU %%%%%%%%%%%%%%%%%%    
    trainFilePath=sprintf('podaci_spremni za_krosvalidaciju_sa_10_podskupova/_train_%d',ii);
    testFilePath=sprintf('podaci_spremni za_krosvalidaciju_sa_10_podskupova/_test_%d',ii);
    load(trainFilePath);
    load(testFilePath);
  
  
    %%%%%%%%% EXTRACT DATA FOR DIFERENT IMAGES %%%%%%%%%%
    trainData=removeLastThreeVariables(train_data_values);
    testData=removeLastThreeVariables(test_data_values);
    %%%%%%%%%%%%%%%% NORMALIZE DATA PER IMAGE %%%%%%%%%%%%%%%%%%%%%
   


KNN=fitcknn(trainData,train_data_labels);

KNN.NumNeighbors=3;
outputLabelKNN=KNN.predict(testData);
confKNN=confusionmat(test_data_labels,outputLabelKNN);
wl3DataAccKNN4(ii)=trace(confKNN)/sum(sum(confKNN));

end
for ii=1:size(confKNN,1)
          TFN(ii)=0;
          TFP(ii)=0;
          k=1;
          TTN(ii)=0;
          TTP(ii)=0;
   for jj=1:size(confKNN,2)
       if ii~=jj
      TFN(ii)= TFN(ii)+confKNN(ii,jj);
      TFP(ii)=TFP(ii)+confKNN(jj,ii);
       end
       if k~=ii || jj~=k
          TTN(ii)=TTN(ii)+confKNN(k,jj);
       end
       if ii==jj
          TTP(ii)=TTP(ii)+confKNN(ii,jj) 
           
       end
       k=k+1;
   end
end
jj=1;
for jj=1:ii
    
   Preciznost(jj)= TTP(jj)/(TTP(jj)+TFP(jj));
   Osetljivost(jj)=TTP(jj)/(TTP(jj)+TFN(jj));
   Specificnost(jj)=TTN(jj)/(TTN(jj)+TFP(jj));
   StopaLaznihPozitiva(jj)=TFP(jj)/(TFP(jj)+TTN(jj));
    
end


avgWl3DataAccKNN4=sum(wl3DataAccKNN4)/size(wl3DataAccKNN4,2);
save('wl3DataAccKNN4.mat','wl3DataAccKNN4');
save('avgWl3DataAccKNN4.mat','avgWl3DataAccKNN4');

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


zz=1;


    for jj=1:size(data,2)
        
       
       for ii=1:size(data,1)
           temp=ToutputLabelKNN(zz,1);
           
  
           
           if temp==0
               
                data(ii,jj,4)=1000;
               
               data(ii,jj,3)=0;
               data(ii,jj,2)=1000;
               
           end
           
           if temp==1
               data(ii,jj,3)=1000;
              
              
               
           end
           
           
           if temp==2
                   
                  data(ii,jj,2)=1000 ;
                   
           end
              
           if temp==3
               data(ii,jj,4)=1000;
               
               data(ii,jj,3)=500;
               data(ii,jj,2)=100;
               
           end
           
           if temp==6
              data(ii,jj,4)=0;
               
               data(ii,jj,3)=0;
               data(ii,jj,2)=0; 
               
               
           end
           
          
            zz=zz+1;
           end
            
       end
   
    
        
    
      
    
   blue_band = data(:,:,2);
    green_band = data(:,:,3);
    red_band = data(:,:,4);

    [image_truecolor] = prikaz_RGB_slike(blue_band, green_band, red_band);
    fig = figure('Name', sprintf('Slika br. 1 od 4 u vremenskoj seriji'));
    imshow(image_truecolor, []); 
    pause;
    close(fig);

  







