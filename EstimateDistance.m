    clear all;
    clc;
    
    [sig2, fs] = audioread('D:\College\4th sem\SS Papers\Recordings\Line Array Samples\@2m\sample23_2again.wav');
    [sig1, fs2] = audioread('D:\College\4th sem\SS Papers\Recordings\Line Array Samples\@2m\sample23_1again.wav');
    [sig3, fs3] = audioread('D:\College\4th sem\SS Papers\Recordings\Line Array Samples\@2m\sample23_3again.wav');
    %%  rng('default')
    lev = 5;
    wname = 'sym8';
    [dnsig1,threshold_SURE] = wden(sig1,'rigrsure','h','mln',lev,wname);
    [dnsig2,threshold_SURE] = wden(sig2,'rigrsure','h','mln',lev,wname);
    [dnsig3,threshold_SURE] = wden(sig3,'rigrsure','h','mln',lev,wname);
    
    
    %% 
    S1 = size(dnsig1);
    S2 = size(dnsig2);
    S3 = size(dnsig3);
    
    %S1 = size(sig1);
    %S2 = size(sig2);
    %S3 = size(sig3);
    [MaxS,I] = max([S1, S2, S3]);
    
    if I==1
        dnsig2 = vertcat(dnsig2, zeros(length(dnsig1) - length(dnsig2),1));
        dnsig3 = vertcat(dnsig3, zeros(length(dnsig1) - length(dnsig3),1));
    elseif I==3
        dnsig1 = vertcat(dnsig1, zeros(length(dnsig2) - length(dnsig1),1));
        dnsig3 = vertcat(dnsig3, zeros(length(dnsig2) - length(dnsig3),1));
    elseif I==5
        dnsig2 = vertcat(dnsig2, zeros(length(dnsig3)-length(dnsig2),1));
        dnsig1 = vertcat(dnsig1, zeros(length(dnsig3)-length(dnsig1),1));
    end 
    dnsig3 = downsample(dnsig3,3,0);
    dnsig2 = downsample(dnsig2,3,0);
    dnsig1 = downsample(dnsig1,3,0);

%if I==1
%        sig2 = vertcat(sig2, zeros(length(sig1) - length(sig2),1));
%        sig3 = vertcat(sig3, zeros(length(sig1) - length(sig3),1));
%    elseif I==3
%        sig1 = vertcat(sig1, zeros(length(sig2) - length(sig1),1));
%        sig3 = vertcat(sig3, zeros(length(sig2) - length(sig3),1));
%    elseif I==5
%        sig2 = vertcat(sig2, zeros(length(sig3)-length(sig2),1));
%        sig1 = vertcat(sig1, zeros(length(sig3)-length(sig1),1));
%    end 
%    sig3 = downsample(sig3,3,0);
%    sig2 = downsample(sig2,3,0);
%    sig1 = downsample(sig1,3,0);
    
    %%    
     DL=max(abs(xcorr(dnsig3,dnsig2,fs)))
     DR=max(abs(xcorr(dnsig1,dnsig2,fs)))
     
     %DL=max(abs(xcorr(sig3,sig2,fs)))
     %DR=max(abs(xcorr(sig1,sig2,fs)))
     %DL = gccphat(sig3,sig2,fs);
     %DR = gccphat(sig1,sig2,fs);
    DistL = DL*343
    DistR = DR*343
    s=DistL+DistR;
    r=DistL/DistR;
    a=3;
    d=((-2*a*a)-(4*r*a*a)-(2*r*r*a*a)+(s*s)+(s*s*r*r))/(2*s*(1+r)*(1+r))
        
