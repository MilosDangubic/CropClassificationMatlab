% skripta za vizuelno upoznavanje sa podacima
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
load('test_Slika_Landsat8_30_187_028');

% prikaz razlicitih kombinacija kanala

% standardna RGB slika 
for i = 1:4
    blue_band = data(:,:,2+(i-1)*10);
    green_band = data(:,:,3+(i-1)*10);
    red_band = data(:,:,4+(i-1)*10);

    [image_truecolor] = prikaz_RGB_slike(blue_band, green_band, red_band);
    fig = figure('Name', sprintf('Slika br. %d od 4 u vremenskoj seriji', i));
    imshow(image_truecolor, []); 
    pause;
    close(fig);
end

% istaknut NIR kanal
for i = 1:4
    blue_band = data(:,:,2+(i-1)*10);
    green_band = data(:,:,3+(i-1)*10);
    red_band = data(:,:,5+(i-1)*10);

    [image_truecolor] = prikaz_RGB_slike(blue_band, green_band, red_band);
    fig = figure('Name', sprintf('Slika br. %d od 4 u vremenskoj seriji', i));
    imshow(image_truecolor, []); 
    pause;
    close(fig);
end

% istaknut Cirrus kanal
for i = 1:4
    blue_band = data(:,:,2+(i-1)*10);
    green_band = data(:,:,3+(i-1)*10);
    red_band = data(:,:,8+(i-1)*10);

    [image_truecolor] = prikaz_RGB_slike(blue_band, green_band, red_band);
    fig = figure('Name', sprintf('Slika br. %d od 4 u vremenskoj seriji', i));
    imshow(image_truecolor, []); 
    pause;
    close(fig);
end


% istaknut Thermal 1 kanal
for i = 1:4
    blue_band = data(:,:,2+(i-1)*10);
    green_band = data(:,:,3+(i-1)*10);
    red_band = data(:,:,9+(i-1)*10);

    [image_truecolor] = prikaz_RGB_slike(blue_band, green_band, red_band);
    fig = figure('Name', sprintf('Slika br. %d od 4 u vremenskoj seriji', i));
    imshow(image_truecolor, []); 
    pause;
    close(fig);
end


% slika sa prikazom samo termalnih kanala (obratiti paznju da je rezolucija slike
% znacajno losija jer je prostorna rezolucija TIRS senzora 100 m, a ne 30 m kao kod
% ostalih kanala.)

for i = 1:4
    blue_band = data(:,:,10+(i-1)*10);
    green_band = data(:,:,10+(i-1)*10);
    red_band = data(:,:,9+(i-1)*10);

    [image_truecolor] = prikaz_RGB_slike(blue_band, green_band, red_band);
    fig = figure('Name', sprintf('Slika br. %d od 4 u vremenskoj seriji', i));
    imshow(image_truecolor, []); 
    pause;
    close(fig);
end

% detekcija cirus oblaka, samo Cirrus kanal (trag na slici 3 je od mlaznog aviona)
for i = 1:4
    blue_band = data(:,:,8+(i-1)*10);
    green_band = data(:,:,8+(i-1)*10);
    red_band = data(:,:,8+(i-1)*10);

    [image_truecolor] = prikaz_RGB_slike(blue_band, green_band, red_band);
    fig = figure('Name', sprintf('Slika br. %d od 4 u vremenskoj seriji', i));
    imshow(image_truecolor, []); 
    pause;
    close(fig);
end

% samo NIR kanal - obratiti paznju na vodu u kanalima (kanal u 
% gornjem i levom delu slike), koja apsorbuje zracenje u ovom delu spektra
% i senke oblaka. Na povrsinama na kojima nema biljne mase odziv je manji.

for i = 1:4
    blue_band = data(:,:,5+(i-1)*10);
    green_band = data(:,:,5+(i-1)*10);
    red_band = data(:,:,5+(i-1)*10);

    [image_truecolor] = prikaz_RGB_slike(blue_band, green_band, red_band);
    fig = figure('Name', sprintf('Slika br. %d od 4 u vremenskoj seriji', i));
    imshow(image_truecolor, []); 
    pause;
    close(fig);
end
