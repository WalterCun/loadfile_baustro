import 'package:loadfile_baustro/core/structs/templates.dart';

/* ****************************************************************************
                               CONFIGURATIONS
* ****************************************************************************/
final cltHDR = TemplatesFiles(
    tree: ['Configuraciones'],
    name: 'CLT',
    ext: 'HDR',
    content: '''#HDR1="{nameShop}"
#HDR2="{direction}"
#HDR3="TELEFONO: {phone}"
#CIUDAD="{city}"
#RUC="{ruc}"''');

final cltIAD = TemplatesFiles(
    tree: ['Configuraciones'],
    name: 'CLT',
    ext: 'IAD',
    content: '''{activateIva}IAD0="1IVA:,{tipoProcesoIva},{tipoValorIva},{baseIva},{valueIva:d}*"
{activatePropina}IAD1="2PROPINA:,{tipoProcesoPropina},{tipoValorPropina},{basePropina},{valuePropina:3d}*"
{activateServicio}IAD2="3SERVICIO:,{tipoProcesoServicio},{tipoValorServicio},{baseServicio},{valueServicio:3d}*"
{activateInteres}IAD3="4INTERES,{tipoProcesoInteres},{tipoValorInteres},{baseInteres},*"
{activateMontoFijo}IAD4="5MONTOFJ:,{tipoProcesoMontoFijo},{tipoValorMontoFijo},{baseMontoFijo},{valueMontoFijo:3d}*"''');

final g03Variables = TemplatesFiles(
    tree: ['Configuraciones'],
    name: 'G03_VARIABLES',
    ext: 'VAR',
    content: '''#ST=0001
#LABEL=CEDULA
#FLAG_LABEL=0
LOTE=0001
#COPIAS=2
#SIGNO=\$US
PORTIP=7001
#TELPRITRN=10.16.0.59
#TELSECTRN=10.16.0.59
#TELPRITRN2=10.16.0.59
#TELSECTRN2=10.16.0.59
PORTIP2=7001
#ATO=35
#CTO=20
#TIMEOUTRANS=120
TLSACTIVE=1
*CON_CERTMUT=1
#MOD_PINPAD=0
CONIVA0=1
DISPIVA0="BASE IVA 0"
DISPBASE="BASE IVA 12"
#TRACK1=0
MULTRANSFLAG=0
#ML=0
#LONG_CAMPO=10
#LONGMIN_CAMPO=10
#LPT=0
CIERREPROG=0
FBATCH=0
GIRO=5533
#TPDU=00028000
#NII=005
NIVEL_BATERIA=20
BEEP=1
AESACT=1
#APW=123
#CM=840
#LM=2
PAIS=ECUADOR
CERTPSS=Admin1236
MENU_TIMEOUT=30
SS_TRANSITION=5 
BANNER_TEXT=POS DATAEXPRESS
MAX_INPUT_LENGTH=10
MONTO_MINIMO=1
#KL=00110
MSGFIRMA=L;B;0;2;1;FIRMA _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
MSGNOMBRETH=_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
LEYENDADUPLICADO=* DUPLICADO *
LEYENDA_ORIGINAL=- ORIGINAL -
LEYENDA_COPIA=- COPIA # -
FRM_PUBLICIDAD=.png
MSG_NO_FIRMA=C;B;1;2;1;- NO REQUIERE FIRMA -
*SMPW=166831
PANEL_FIRMA=0
IS_OFFLINE=1
RESENDOFF=1
PAUSAREENV=2
NUMREENV=1
#PRETCP=1
#LOG=1''');
