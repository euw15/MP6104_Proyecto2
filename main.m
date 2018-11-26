close all;
clc;
clear;
pkg load communications;
fileName = "a.bin";
inputAudioName = "fisica20s_22KHz.wav";
outAudioName = "out.wav";

V = 5;
A_Mu = 88;
bitsPorBanda = [2,2,2,2];
inputAudio = codificador(inputAudioName, fileName, A_Mu, V, bitsPorBanda);
bandaFinal = decodificador(fileName, outAudioName);

sizeInicial = lstat(inputAudioName)(1).size;
sizeFinal = lstat(fileName)(1).size;

porcentajeCompresion = sizeFinal/sizeInicial*100

