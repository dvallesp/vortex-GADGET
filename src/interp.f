***********************************************************************
      SUBROUTINE LININT52D_NEW(IX,JY,KZ,U,FUIN)
***********************************************************************
*     Linear interpolation of a l=1 cell from the base grid
************************************************************************

      IMPLICIT NONE

      INCLUDE 'vortex_parameters.dat'

      INTEGER II,JJ,KK,IX,JY,KZ
      real XX,YY,ZZ,SIGNO
      real FUIN, U(3,3,3)

      real DXX,DYY,DZZ,DXMAS,DYMAS,DZMAS,DXMIN,DYMIN,DZMIN
      real LIM,LIMA
      real DXCEN,DYCEN,DZCEN

      LIM=8.0

      II=-1
      JJ=-1
      KK=-1
      IF (MOD(IX,2).EQ.0) II=1
      IF (MOD(JY,2).EQ.0) JJ=1
      IF (MOD(KZ,2).EQ.0) KK=1

      DXX=0.0
      DYY=0.0
      DZZ=0.0

*     DU/DX
      DXMAS=U(3,2,2)-U(2,2,2)
      DXMIN=U(2,2,2)-U(1,2,2)
      DXCEN=0.5*(DXMAS+DXMIN)
      LIMA=ABS(U(3,2,2)-U(1,2,2))/
     &     MAX(1.E-30,ABS(MIN(U(3,2,2),U(1,2,2))))

      IF ((DXMIN*DXMAS).GT.0.0) THEN
       DXX=MIN(ABS(DXCEN),ABS(DXMIN),ABS(DXMAS))
       SIGNO=1.0
       IF (DXCEN.LT.0.0) SIGNO=-1.0
       DXX=DXX*SIGNO
      ELSE
       DXX=0.0
      END IF
      IF (LIMA.GT.LIM) DXX=0.0

*     DU/DY
      DYMAS=U(2,3,2)-U(2,2,2)
      DYMIN=U(2,2,2)-U(2,1,2)
      DYCEN=0.5*(DYMAS+DYMIN)
      LIMA=ABS(U(2,3,2)-U(2,1,2))/
     &     MAX(1.E-30,ABS(MIN(U(2,3,2),U(2,1,2))))

      IF ((DYMIN*DYMAS).GT.0.0) THEN
       DYY=MIN(ABS(DYCEN),ABS(DYMIN),ABS(DYMAS))
       SIGNO=1.0
       IF (DYCEN.LT.0.0) SIGNO=-1.0
       DYY=DYY*SIGNO
      ELSE
       DYY=0.0
      END IF
      IF (LIMA.GT.LIM) DYY=0.0

*     DU/DZ
      DZMAS=U(2,2,3)-U(2,2,2)
      DZMIN=U(2,2,2)-U(2,2,1)
      DZCEN=0.5*(DZMAS+DZMIN)
      LIMA=ABS(U(2,2,3)-U(2,2,1))/
     &     MAX(1.E-30,ABS(MIN(U(2,2,3),U(2,2,1))))

      IF ((DZMIN*DZMAS).GT.0.0) THEN
       DZZ=MIN(ABS(DZCEN),ABS(DZMIN),ABS(DZMAS))
       SIGNO=1.0
       IF (DZCEN.LT.0.0) SIGNO=-1.0
       DZZ=DZZ*SIGNO
      ELSE
       DZZ=0.0
      END IF
      IF (LIMA.GT.LIM) DZZ=0.0

      XX=0.25
      YY=0.25
      ZZ=0.25
      IF (II.LT.0) XX=-0.25
      IF (JJ.LT.0) YY=-0.25
      IF (KK.LT.0) ZZ=-0.25

      FUIN=U(2,2,2) + XX*DXX + YY*DYY + ZZ*DZZ

      RETURN
      END

***********************************************************************
      SUBROUTINE LININT52D_NEW_REAL(XX,YY,ZZ,RX,RY,RZ,U,FUIN)
***********************************************************************
*     Linear interpolation from refined levels
************************************************************************

      IMPLICIT NONE

      INCLUDE 'vortex_parameters.dat'

      INTEGER II,JJ,KK,IX,JY,KZ
      real XX,YY,ZZ,XXX,YYY,ZZZ,SIGNO
      real FUIN
      real U(3,3,3),RX(3),RY(3),RZ(3)

      real DXX,DYY,DZZ,DXMAS,DYMAS,DZMAS,DXMIN,DYMIN,DZMIN
      real LIM,LIMA
      real DXCEN,DYCEN,DZCEN

      LIM=8.0

      DXX=0.0
      DYY=0.0
      DZZ=0.0

*     DU/DX
      DXMAS=(U(3,2,2)-U(2,2,2))/(RX(3)-RX(2))
      DXMIN=(U(2,2,2)-U(1,2,2))/(RX(2)-RX(1))
      DXCEN=0.5*(DXMAS+DXMIN)

      LIMA=ABS(U(3,2,2)-U(1,2,2))/
     &     MAX(1.E-30,ABS(MIN(U(3,2,2),U(1,2,2))))

      IF ((DXMIN*DXMAS).GT.0.0) THEN
       DXX = ABS(DXCEN)
       SIGNO=1.0
       IF (DXCEN.LT.0.0) SIGNO=-1.0
       DXX=DXX*SIGNO
      ELSE
       DXX=0.0
      END IF
      IF (LIMA.GT.LIM) DXX=0.0

*     DU/DY
      DYMAS=(U(2,3,2)-U(2,2,2))/(RY(3)-RY(2))
      DYMIN=(U(2,2,2)-U(2,1,2))/(RY(2)-RY(1))
      DYCEN=0.5*(DYMAS+DYMIN)

      LIMA=ABS(U(2,3,2)-U(2,1,2))/
     &     MAX(1.E-30,ABS(MIN(U(2,3,2),U(2,1,2))))

      IF ((DYMIN*DYMAS).GT.0.0) THEN
       DYY = ABS(DYCEN)
       SIGNO=1.0
       IF (DYCEN.LT.0.0) SIGNO=-1.0
       DYY=DYY*SIGNO
      ELSE
       DYY=0.0
      END IF
      IF (LIMA.GT.LIM) DYY=0.0

*     DU/DZ
      DZMAS=(U(2,2,3)-U(2,2,2))/(RZ(3)-RZ(2))
      DZMIN=(U(2,2,2)-U(2,2,1))/(RZ(2)-RZ(1))
      DZCEN=0.5*(DZMAS+DZMIN)

      LIMA=ABS(U(2,2,3)-U(2,2,1))/
     &     MAX(1.E-30,ABS(MIN(U(2,2,3),U(2,2,1))))

      IF ((DZMIN*DZMAS).GT.0.0) THEN
       DZZ = ABS(DZCEN)
       SIGNO=1.0
       IF (DZCEN.LT.0.0) SIGNO=-1.0
       DZZ=DZZ*SIGNO
      ELSE
       DZZ=0.0
      END IF
      IF (LIMA.GT.LIM) DZZ=0.0

      XXX=XX-RX(2)
      YYY=YY-RY(2)
      ZZZ=ZZ-RZ(2)

      FUIN=U(2,2,2) + XXX*DXX + YYY*DYY + ZZZ*DZZ

      RETURN
      END

***********************************************************************
      SUBROUTINE CIC_INTERP(U,XX,YY,ZZ,RX,RY,RZ,FUIN)
***********************************************************************
*     Linear interpolation using 8 nearest neighbours.
************************************************************************
      IMPLICIT NONE

      INCLUDE 'vortex_parameters.dat'

      REAL U(2,2,2),XX,YY,ZZ,RX(2),RY(2),RZ(2),FUIN

      REAL BASX,BASY,BASZ

      BASX=(XX-RX(1))/(RX(2)-RX(1))
      BASY=(YY-RY(1))/(RY(2)-RY(1))
      BASZ=(ZZ-RZ(1))/(RZ(2)-RZ(1))

      FUIN=U(1,1,1)*(1.0-BASX)*(1.0-BASY)*(1.0-BASZ) +
     &     U(2,1,1)*BASX*(1.0-BASY)*(1.0-BASZ) +
     &     U(1,2,1)*(1.0-BASX)*BASY*(1.0-BASZ) +
     &     U(1,1,2)*(1.0-BASX)*(1.0-BASY)*BASZ +
     &     U(2,1,2)*BASX*(1.0-BASY)*BASZ +
     &     U(1,2,2)*(1.0-BASX)*BASY*BASZ +
     &     U(2,2,1)*BASX*BASY*(1.0-BASZ) +
     &     U(2,2,2)*BASX*BASY*BASZ

      RETURN 
      END 

