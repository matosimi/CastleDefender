mads cd_sap1.asm -o:cd_sap1.xex
mads cd_sap2.asm -o:cd_sap2.xex
copy /b cd_sap1.txt+cd_sap1.xex "Castle Defender.sap"
copy /b cd_sap2.txt+cd_sap2.xex "Castle Defender Ingame.sap"
pause
