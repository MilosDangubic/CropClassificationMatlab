% jedan moguci nacin za prikaz RGB kanala sat. slike - ne i najbolji

function [image_truecolor] = prikaz_RGB_slike(blue_band, green_band, red_band)
    blue_band = blue_band/max(blue_band(:));
    green_band = green_band/max(green_band(:));
    red_band = red_band/max(red_band(:));

    blue_band = imadjust(blue_band,stretchlim(blue_band, [0.01 0.99]), [0;1], 0.7);
    green_band = imadjust(green_band,stretchlim(green_band, [0.01 0.99]), [0;1], 0.7);
    red_band = imadjust(red_band,stretchlim(red_band, [0.015 0.995]), [0;1], 0.7);

    image_truecolor = cat(3, red_band, green_band, blue_band);
end

