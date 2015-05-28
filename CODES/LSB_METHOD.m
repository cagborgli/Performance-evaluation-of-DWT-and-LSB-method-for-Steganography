
clc;
clear all;
close all;



x = imread('landscape.jpg');         % cover message
y = imread('elephant.jpg');    % message image
%n = input('Enter the no of LSB bits to be subsituted- '); 
n=3;
S = uint8(bitor(bitand(x,bitcmp(2^n-1,8)),bitshift(y,n-8))); %Stego
E = uint8(bitand(255,bitshift(S,8-n))); %Extracted

origImg = double(y);   %message image
distImg = double(E);   %extracted image

[M N] = size(origImg);


error = origImg - distImg;
MSE = sum(sum(error .* error)) / (M * N);
if(MSE > 0)
    PSNR = 10*log10(M*N./MSE);
else
    PSNR = 99;
end
disp('PSNR of message image to extracted image is')
disp(abs(PSNR))
disp('MSE is')
disp(abs(MSE))


figure(1),
subplot(2,2,1);
imshow(rgb2gray(x));title('1.Cover image')
subplot(2,2,2);imshow(rgb2gray(y));title('2.secret image')
subplot(2,2,3);imshow(rgb2gray(abs(S)),[]);title('3.Stegnographic image')
subplot(2,2,4);imshow(rgb2gray(real(E)),[]); title('4.Extracted image')
%subplot(3,3,5);
%imhist(rgb2gray(y));
%subplot(3,3,6);
%imhist(rgb2gray(real(E)));
