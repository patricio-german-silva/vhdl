
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
create_project: 2

00:00:042

00:00:092	
507.9182	
198.832Z17-268h px� 
�
Command: %s
1870*	planAhead2�
�read_checkpoint -auto_incremental -incremental C:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/utils_1/imports/synth_1/IMain.dcpZ12-2866h px� 
�
;Read reference checkpoint from %s for incremental synthesis3154*	planAhead2m
kC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/utils_1/imports/synth_1/IMain.dcpZ12-5825h px� 
T
-Please ensure there are no constraint changes3725*	planAheadZ12-7989h px� 
a
Command: %s
53*	vivadotcl20
.synth_design -top IMain -part xc7a100tcsg324-1Z4-113h px� 
:
Starting synth_design
149*	vivadotclZ4-321h px� 
{
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2

xc7a100tZ17-347h px� 
k
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2

xc7a100tZ17-349h px� 
E
Loading part %s157*device2
xc7a100tcsg324-1Z21-403h px� 
[
$Part: %s does not have CEAM library.966*device2
xc7a100tcsg324-1Z21-9227h px� 

VNo compile time benefit to using incremental synthesis; A full resynthesis will be run2353*designutilsZ20-5440h px� 
�
�Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}2229*designutilsZ20-4379h px� 
o
HMultithreading enabled for synth_design using a maximum of %s processes.4828*oasys2
2Z8-7079h px� 
a
?Launching helper process for spawning children vivado processes4827*oasysZ8-7078h px� 
N
#Helper process launched with PID %s4824*oasys2
13372Z8-7075h px� 
�
%s*synth2{
yStarting RTL Elaboration : Time (s): cpu = 00:00:05 ; elapsed = 00:00:06 . Memory (MB): peak = 1379.797 ; gain = 448.195
h px� 
�
synthesizing module '%s'638*oasys2
IMain2e
aC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/IMain.vhd2
518@Z8-638h px� 
�
synthesizing module '%s'638*oasys2
UaRx2d
`C:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/UaRx.vhd2
468@Z8-638h px� 
L
%s
*synth24
2	Parameter RxDIV bound to: 10416 - type: integer 
h p
x
� 
�
synthesizing module '%s'638*oasys2
BaudRateGen2k
gC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/BaudRateGen.vhd2
398@Z8-638h px� 
I
%s
*synth21
/	Parameter NBits bound to: 14 - type: integer 
h p
x
� 
J
%s
*synth22
0	Parameter Max bound to: 10416 - type: integer 
h p
x
� 
K
%s
*synth23
1	Parameter First bound to: 5208 - type: integer 
h p
x
� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
BaudRateGen2
02
12k
gC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/BaudRateGen.vhd2
398@Z8-256h px� 
�
Esignal '%s' is read in the process but is not in the sensitivity list614*oasys2

synlatch2d
`C:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/UaRx.vhd2
748@Z8-614h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
UaRx2
02
12d
`C:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/UaRx.vhd2
468@Z8-256h px� 
�
synthesizing module '%s'638*oasys2

CommProtRx2j
fC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/CommProtRx.vhd2
508@Z8-638h px� 
O
%s
*synth27
5	Parameter HEADER_CHAR bound to: 68 - type: integer 
h p
x
� 
P
%s
*synth28
6	Parameter TRAILER_CHAR bound to: 90 - type: integer 
h p
x
� 
Q
%s
*synth29
7	Parameter TIMEOUT bound to: 10000000 - type: integer 
h p
x
� 
�
synthesizing module '%s'638*oasys2

TTrigger2h
dC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/TTrigger.vhd2
378@Z8-638h px� 
I
%s
*synth21
/	Parameter NBits bound to: 20 - type: integer 
h p
x
� 
M
%s
*synth25
3	Parameter Max bound to: 10000000 - type: integer 
h p
x
� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2

TTrigger2
02
12h
dC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/TTrigger.vhd2
378@Z8-256h px� 
�
Esignal '%s' is read in the process but is not in the sensitivity list614*oasys2
r_cmd2j
fC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/CommProtRx.vhd2
818@Z8-614h px� 
�
Esignal '%s' is read in the process but is not in the sensitivity list614*oasys2
r_data2j
fC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/CommProtRx.vhd2
818@Z8-614h px� 
�
Esignal '%s' is read in the process but is not in the sensitivity list614*oasys2

piCPRxRx2j
fC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/CommProtRx.vhd2
818@Z8-614h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2

CommProtRx2
02
12j
fC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/CommProtRx.vhd2
508@Z8-256h px� 
�
synthesizing module '%s'638*oasys2
UaTx2d
`C:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/UaTx.vhd2
488@Z8-638h px� 
L
%s
*synth24
2	Parameter TxDIV bound to: 10416 - type: integer 
h p
x
� 
�
synthesizing module '%s'638*oasys2
BaudRateGen__parameterized02k
gC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/BaudRateGen.vhd2
398@Z8-638h px� 
I
%s
*synth21
/	Parameter NBits bound to: 14 - type: integer 
h p
x
� 
J
%s
*synth22
0	Parameter Max bound to: 10416 - type: integer 
h p
x
� 
L
%s
*synth24
2	Parameter First bound to: 10416 - type: integer 
h p
x
� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
BaudRateGen__parameterized02
02
12k
gC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/BaudRateGen.vhd2
398@Z8-256h px� 
�
Esignal '%s' is read in the process but is not in the sensitivity list614*oasys2
txrdy2d
`C:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/UaTx.vhd2
898@Z8-614h px� 
�
Esignal '%s' is read in the process but is not in the sensitivity list614*oasys2

piUaTxData2d
`C:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/UaTx.vhd2
898@Z8-614h px� 
�
Esignal '%s' is read in the process but is not in the sensitivity list614*oasys2
latch2d
`C:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/UaTx.vhd2
898@Z8-614h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
UaTx2
02
12d
`C:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/UaTx.vhd2
488@Z8-256h px� 
�
synthesizing module '%s'638*oasys2
	DecodeCmd2i
eC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/DecodeCmd.vhd2
548@Z8-638h px� 
R
%s
*synth2:
8	Parameter POWER_SEL_WIDTH bound to: 7 - type: integer 
h p
x
� 
T
%s
*synth2<
:	Parameter CTRL_PERIOD bound to: 1000000 - type: integer 
h p
x
� 
�
synthesizing module '%s'638*oasys2
ModuleCounter2m
iC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/ModuleCounter.vhd2
378@Z8-638h px� 
I
%s
*synth21
/	Parameter NBits bound to: 20 - type: integer 
h p
x
� 
L
%s
*synth24
2	Parameter Max bound to: 1000000 - type: integer 
h p
x
� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
ModuleCounter2
02
12m
iC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/ModuleCounter.vhd2
378@Z8-256h px� 
�
Esignal '%s' is read in the process but is not in the sensitivity list614*oasys2
	piDCMDCmd2i
eC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/DecodeCmd.vhd2
878@Z8-614h px� 
�
Esignal '%s' is read in the process but is not in the sensitivity list614*oasys2

piDCMDData2i
eC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/DecodeCmd.vhd2
878@Z8-614h px� 
�
Esignal '%s' is read in the process but is not in the sensitivity list614*oasys2
auto2i
eC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/DecodeCmd.vhd2
878@Z8-614h px� 
�
Esignal '%s' is read in the process but is not in the sensitivity list614*oasys2
power2i
eC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/DecodeCmd.vhd2
878@Z8-614h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
	DecodeCmd2
02
12i
eC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/DecodeCmd.vhd2
548@Z8-256h px� 
�
synthesizing module '%s'638*oasys2
HBridgeCtrl2k
gC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/HBridgeCtrl.vhd2
518@Z8-638h px� 
R
%s
*synth2:
8	Parameter POWER_SEL_WIDTH bound to: 7 - type: integer 
h p
x
� 
L
%s
*synth24
2	Parameter PWM_DIV bound to: 100 - type: integer 
h p
x
� 
Q
%s
*synth29
7	Parameter PWM_PERIOD bound to: 10000 - type: integer 
h p
x
� 
�
synthesizing module '%s'638*oasys2
ModuleCounter__parameterized02m
iC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/ModuleCounter.vhd2
378@Z8-638h px� 
I
%s
*synth21
/	Parameter NBits bound to: 20 - type: integer 
h p
x
� 
J
%s
*synth22
0	Parameter Max bound to: 10000 - type: integer 
h p
x
� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
ModuleCounter__parameterized02
02
12m
iC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/ModuleCounter.vhd2
378@Z8-256h px� 
�
synthesizing module '%s'638*oasys2
PwmGen2f
bC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/PwmGen.vhd2
478@Z8-638h px� 
L
%s
*synth24
2	Parameter PWM_WIDTH bound to: 7 - type: integer 
h p
x
� 
H
%s
*synth20
.	Parameter ARR bound to: 100 - type: integer 
h p
x
� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
PwmGen2
02
12f
bC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/PwmGen.vhd2
478@Z8-256h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
HBridgeCtrl2
02
12k
gC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/HBridgeCtrl.vhd2
518@Z8-256h px� 
�
synthesizing module '%s'638*oasys2
	ToDisplay2i
eC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/ToDisplay.vhd2
488@Z8-638h px� 
R
%s
*synth2:
8	Parameter POWER_SEL_WIDTH bound to: 7 - type: integer 
h p
x
� 
M
%s
*synth25
3	Parameter Max bound to: 50000000 - type: integer 
h p
x
� 
�
synthesizing module '%s'638*oasys2	
Counter2g
cC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/Counter.vhd2
478@Z8-638h px� 
L
%s
*synth24
2	Parameter NBitsMax bound to: 28 - type: integer 
h p
x
� 
K
%s
*synth23
1	Parameter NBitsVal bound to: 3 - type: integer 
h p
x
� 
M
%s
*synth25
3	Parameter Max bound to: 50000000 - type: integer 
h p
x
� 
G
%s
*synth2/
-	Parameter NVal bound to: 6 - type: integer 
h p
x
� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2	
Counter2
02
12g
cC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/Counter.vhd2
478@Z8-256h px� 
�
Esignal '%s' is read in the process but is not in the sensitivity list614*oasys2
cv2i
eC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/ToDisplay.vhd2
588@Z8-614h px� 
�
Esignal '%s' is read in the process but is not in the sensitivity list614*oasys2
piTDPowerMD2i
eC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/ToDisplay.vhd2
588@Z8-614h px� 
�
Esignal '%s' is read in the process but is not in the sensitivity list614*oasys2
piTDPowerMI2i
eC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/ToDisplay.vhd2
588@Z8-614h px� 
�
Esignal '%s' is read in the process but is not in the sensitivity list614*oasys2

piTDMode2i
eC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/ToDisplay.vhd2
588@Z8-614h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
	ToDisplay2
02
12i
eC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/ToDisplay.vhd2
488@Z8-256h px� 
�
synthesizing module '%s'638*oasys2
HexToSevSeg2k
gC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/HexToSevSeg.vhd2
308@Z8-638h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
HexToSevSeg2
02
12k
gC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/HexToSevSeg.vhd2
308@Z8-256h px� 
�
synthesizing module '%s'638*oasys2
TTrigger__parameterized02h
dC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/TTrigger.vhd2
378@Z8-638h px� 
I
%s
*synth21
/	Parameter NBits bound to: 24 - type: integer 
h p
x
� 
M
%s
*synth25
3	Parameter Max bound to: 10000000 - type: integer 
h p
x
� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
TTrigger__parameterized02
02
12h
dC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/TTrigger.vhd2
378@Z8-256h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
IMain2
02
12e
aC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/IMain.vhd2
518@Z8-256h px� 
�
RFound unconnected internal register '%s' and it is trimmed from '%s' to '%s' bits.3455*oasys2

r_Data_reg2
162
122i
eC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/DecodeCmd.vhd2
918@Z8-3936h px� 
�
�Register %s in module %s is clocked by two different clocks in the same process. This may cause simulation mismatches and synthesis errors. Consider using different process statements 
4191*oasys2
poDCMDSetMD_reg2
	DecodeCmd2i
eC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/DecodeCmd.vhd2
938@Z8-5787h px� 
�
�Register %s in module %s is clocked by two different clocks in the same process. This may cause simulation mismatches and synthesis errors. Consider using different process statements 
4191*oasys2
poDCMDSetMI_reg2
	DecodeCmd2i
eC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/DecodeCmd.vhd2
948@Z8-5787h px� 
u
9Port %s in module %s is either unconnected or has no load4866*oasys2
	piDCMDEna2
	DecodeCmdZ8-7129h px� 
z
9Port %s in module %s is either unconnected or has no load4866*oasys2
piDCMDData[15]2
	DecodeCmdZ8-7129h px� 
z
9Port %s in module %s is either unconnected or has no load4866*oasys2
piDCMDData[14]2
	DecodeCmdZ8-7129h px� 
z
9Port %s in module %s is either unconnected or has no load4866*oasys2
piDCMDData[13]2
	DecodeCmdZ8-7129h px� 
z
9Port %s in module %s is either unconnected or has no load4866*oasys2
piDCMDData[12]2
	DecodeCmdZ8-7129h px� 
y
9Port %s in module %s is either unconnected or has no load4866*oasys2
piDCMDData[7]2
	DecodeCmdZ8-7129h px� 
y
9Port %s in module %s is either unconnected or has no load4866*oasys2
piDCMDData[6]2
	DecodeCmdZ8-7129h px� 
y
9Port %s in module %s is either unconnected or has no load4866*oasys2
piDCMDData[5]2
	DecodeCmdZ8-7129h px� 
y
9Port %s in module %s is either unconnected or has no load4866*oasys2
piDCMDData[4]2
	DecodeCmdZ8-7129h px� 
�
%s*synth2{
yFinished RTL Elaboration : Time (s): cpu = 00:00:07 ; elapsed = 00:00:08 . Memory (MB): peak = 1495.797 ; gain = 564.195
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
;
%s
*synth2#
!Start Handling Custom Attributes
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:07 ; elapsed = 00:00:08 . Memory (MB): peak = 1495.797 ; gain = 564.195
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 1 : Time (s): cpu = 00:00:07 ; elapsed = 00:00:08 . Memory (MB): peak = 1495.797 ; gain = 564.195
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0082

1495.7972
0.000Z17-268h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
>

Processing XDC Constraints
244*projectZ1-262h px� 
=
Initializing timing engine
348*projectZ1-569h px� 
�
Parsing XDC File [%s]
179*designutils2e
aC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/constrs_1/new/IMain.xdc8Z20-179h px� 
�
Finished Parsing XDC File [%s]
178*designutils2e
aC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/constrs_1/new/IMain.xdc8Z20-178h px� 
�
�Implementation specific constraints were found while reading constraint file [%s]. These constraints will be ignored for synthesis but will be used in implementation. Impacted constraints are listed in the file [%s].
233*project2c
aC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/constrs_1/new/IMain.xdc2
.Xil/IMain_propImpl.xdcZ1-236h px� 
H
&Completed Processing XDC Constraints

245*projectZ1-263h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002

00:00:002

1594.2272
0.000Z17-268h px� 
l
!Unisim Transformation Summary:
%s111*project2'
%No Unisim elements were transformed.
Z1-111h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
 Constraint Validation Runtime : 2

00:00:002
00:00:00.0092

1594.2272
0.000Z17-268h px� 

VNo compile time benefit to using incremental synthesis; A full resynthesis will be run2353*designutilsZ20-5440h px� 
�
�Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}2229*designutilsZ20-4379h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
Finished Constraint Validation : Time (s): cpu = 00:00:15 ; elapsed = 00:00:17 . Memory (MB): peak = 1594.227 ; gain = 662.625
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
D
%s
*synth2,
*Start Loading Part and Timing Information
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Loading part: xc7a100tcsg324-1
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Loading Part and Timing Information : Time (s): cpu = 00:00:15 ; elapsed = 00:00:17 . Memory (MB): peak = 1594.227 ; gain = 662.625
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
H
%s
*synth20
.Start Applying 'set_property' XDC Constraints
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished applying 'set_property' XDC Constraints : Time (s): cpu = 00:00:15 ; elapsed = 00:00:17 . Memory (MB): peak = 1594.227 ; gain = 662.625
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
h
3inferred FSM for state register '%s' in module '%s'802*oasys2
	state_reg2
UaRxZ8-802h px� 
n
3inferred FSM for state register '%s' in module '%s'802*oasys2
	state_reg2

CommProtRxZ8-802h px� 
h
3inferred FSM for state register '%s' in module '%s'802*oasys2
	state_reg2
UaTxZ8-802h px� 
�
RFound unconnected internal register '%s' and it is trimmed from '%s' to '%s' bits.3455*oasys2
avg_power_reg2
82
72i
eC:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/DecodeCmd.vhd2
1118@Z8-3936h px� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
z
%s
*synth2b
`                   State |                     New Encoding |                Previous Encoding 
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
y
%s
*synth2a
_                      s0 |                      00000000001 |                             0000
h p
x
� 
y
%s
*synth2a
_                      s1 |                      00000000010 |                             0001
h p
x
� 
y
%s
*synth2a
_                      s2 |                      00000000100 |                             0010
h p
x
� 
y
%s
*synth2a
_                      s3 |                      00000001000 |                             0011
h p
x
� 
y
%s
*synth2a
_                      s4 |                      00000010000 |                             0100
h p
x
� 
y
%s
*synth2a
_                      s5 |                      00000100000 |                             0101
h p
x
� 
y
%s
*synth2a
_                      s6 |                      00001000000 |                             0110
h p
x
� 
y
%s
*synth2a
_                      s7 |                      00010000000 |                             0111
h p
x
� 
y
%s
*synth2a
_                      s8 |                      00100000000 |                             1000
h p
x
� 
y
%s
*synth2a
_                      s9 |                      01000000000 |                             1001
h p
x
� 
y
%s
*synth2a
_                     s10 |                      10000000000 |                             1010
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
	state_reg2	
one-hot2
UaRxZ8-3354h px� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
z
%s
*synth2b
`                   State |                     New Encoding |                Previous Encoding 
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
y
%s
*synth2a
_                      s0 |                              000 |                              000
h p
x
� 
y
%s
*synth2a
_                      s1 |                              001 |                              001
h p
x
� 
y
%s
*synth2a
_                      s2 |                              010 |                              010
h p
x
� 
y
%s
*synth2a
_                      s3 |                              011 |                              011
h p
x
� 
y
%s
*synth2a
_                      s4 |                              100 |                              100
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
	state_reg2

sequential2

CommProtRxZ8-3354h px� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
z
%s
*synth2b
`                   State |                     New Encoding |                Previous Encoding 
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
y
%s
*synth2a
_                      s0 |                     000000000001 |                             0000
h p
x
� 
y
%s
*synth2a
_                      s1 |                     000000000010 |                             0001
h p
x
� 
y
%s
*synth2a
_                      s2 |                     000000000100 |                             0010
h p
x
� 
y
%s
*synth2a
_                      s3 |                     000000001000 |                             0011
h p
x
� 
y
%s
*synth2a
_                      s4 |                     000000010000 |                             0100
h p
x
� 
y
%s
*synth2a
_                      s5 |                     000000100000 |                             0101
h p
x
� 
y
%s
*synth2a
_                      s6 |                     000001000000 |                             0110
h p
x
� 
y
%s
*synth2a
_                      s7 |                     000010000000 |                             0111
h p
x
� 
y
%s
*synth2a
_                      s8 |                     000100000000 |                             1000
h p
x
� 
y
%s
*synth2a
_                      s9 |                     001000000000 |                             1001
h p
x
� 
y
%s
*synth2a
_                     s10 |                     010000000000 |                             1010
h p
x
� 
y
%s
*synth2a
_                     s11 |                     100000000000 |                             1011
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
	state_reg2	
one-hot2
UaTxZ8-3354h px� 
�
!inferring latch for variable '%s'327*oasys2
	latch_reg2d
`C:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/UaTx.vhd2
1018@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
	txrdy_reg2d
`C:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.srcs/sources_1/new/UaTx.vhd2
948@Z8-327h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:16 ; elapsed = 00:00:19 . Memory (MB): peak = 1594.227 ; gain = 662.625
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
:
%s
*synth2"
 Start RTL Component Statistics 
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Detailed RTL Component Info : 
h p
x
� 
(
%s
*synth2
+---Adders : 
h p
x
� 
F
%s
*synth2.
,	   2 Input   28 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   20 Bit       Adders := 3     
h p
x
� 
F
%s
*synth2.
,	   2 Input   14 Bit       Adders := 2     
h p
x
� 
F
%s
*synth2.
,	   2 Input    8 Bit       Adders := 2     
h p
x
� 
F
%s
*synth2.
,	   2 Input    7 Bit       Adders := 2     
h p
x
� 
F
%s
*synth2.
,	   2 Input    3 Bit       Adders := 1     
h p
x
� 
+
%s
*synth2
+---Registers : 
h p
x
� 
H
%s
*synth20
.	               28 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	               20 Bit    Registers := 3     
h p
x
� 
H
%s
*synth20
.	               16 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	               14 Bit    Registers := 2     
h p
x
� 
H
%s
*synth20
.	                8 Bit    Registers := 4     
h p
x
� 
H
%s
*synth20
.	                7 Bit    Registers := 7     
h p
x
� 
H
%s
*synth20
.	                4 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	                3 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	                1 Bit    Registers := 15    
h p
x
� 
'
%s
*synth2
+---Muxes : 
h p
x
� 
F
%s
*synth2.
,	   5 Input   16 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   2 Input   16 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	  12 Input   12 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   12 Bit        Muxes := 12    
h p
x
� 
F
%s
*synth2.
,	  11 Input   11 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   11 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	  11 Input    8 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   2 Input    8 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	   2 Input    7 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   2 Input    4 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   7 Input    4 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   4 Input    4 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   5 Input    3 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    3 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	   3 Input    2 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	  11 Input    1 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	   5 Input    1 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	  12 Input    1 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	   2 Input    1 Bit        Muxes := 18    
h p
x
� 
F
%s
*synth2.
,	   3 Input    1 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   4 Input    1 Bit        Muxes := 6     
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
=
%s
*synth2%
#Finished RTL Component Statistics 
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
6
%s
*synth2
Start Part Resource Summary
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
q
%s
*synth2Y
WPart Resources:
DSPs: 240 (col length:80)
BRAMs: 270 (col length: RAMB18 80 RAMB36 40)
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Finished Part Resource Summary
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
E
%s
*synth2-
+Start Cross Boundary and Area Optimization
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
H
&Parallel synthesis criteria is not met4829*oasysZ8-7080h px� 
u
9Port %s in module %s is either unconnected or has no load4866*oasys2
	piDCMDEna2
	DecodeCmdZ8-7129h px� 
z
9Port %s in module %s is either unconnected or has no load4866*oasys2
piDCMDData[15]2
	DecodeCmdZ8-7129h px� 
z
9Port %s in module %s is either unconnected or has no load4866*oasys2
piDCMDData[14]2
	DecodeCmdZ8-7129h px� 
z
9Port %s in module %s is either unconnected or has no load4866*oasys2
piDCMDData[13]2
	DecodeCmdZ8-7129h px� 
z
9Port %s in module %s is either unconnected or has no load4866*oasys2
piDCMDData[12]2
	DecodeCmdZ8-7129h px� 
y
9Port %s in module %s is either unconnected or has no load4866*oasys2
piDCMDData[7]2
	DecodeCmdZ8-7129h px� 
y
9Port %s in module %s is either unconnected or has no load4866*oasys2
piDCMDData[6]2
	DecodeCmdZ8-7129h px� 
y
9Port %s in module %s is either unconnected or has no load4866*oasys2
piDCMDData[5]2
	DecodeCmdZ8-7129h px� 
y
9Port %s in module %s is either unconnected or has no load4866*oasys2
piDCMDData[4]2
	DecodeCmdZ8-7129h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Cross Boundary and Area Optimization : Time (s): cpu = 00:00:21 ; elapsed = 00:00:25 . Memory (MB): peak = 1594.227 ; gain = 662.625
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�---------------------------------------------------------------------------------
Start ROM, RAM, DSP, Shift Register and Retiming Reporting
h px� 
l
%s*synth2T
R---------------------------------------------------------------------------------
h px� 
;
%s*synth2#
!
ROM: Preliminary Mapping Report
h px� 
Z
%s*synth2B
@+------------+---------------+---------------+----------------+
h px� 
[
%s*synth2C
A|Module Name | RTL Object    | Depth x Width | Implemented As | 
h px� 
Z
%s*synth2B
@+------------+---------------+---------------+----------------+
h px� 
[
%s*synth2C
A|HexToSevSeg | poHTSSSOutput | 32x7          | LUT            | 
h px� 
[
%s*synth2C
A+------------+---------------+---------------+----------------+

h px� 
�
%s*synth2�
�---------------------------------------------------------------------------------
Finished ROM, RAM, DSP, Shift Register and Retiming Reporting
h px� 
l
%s*synth2T
R---------------------------------------------------------------------------------
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
@
%s
*synth2(
&Start Applying XDC Timing Constraints
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Applying XDC Timing Constraints : Time (s): cpu = 00:00:27 ; elapsed = 00:00:31 . Memory (MB): peak = 1594.227 ; gain = 662.625
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
4
%s
*synth2
Start Timing Optimization
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2
}Finished Timing Optimization : Time (s): cpu = 00:00:29 ; elapsed = 00:00:33 . Memory (MB): peak = 1594.227 ; gain = 662.625
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
3
%s
*synth2
Start Technology Mapping
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2~
|Finished Technology Mapping : Time (s): cpu = 00:00:29 ; elapsed = 00:00:33 . Memory (MB): peak = 1594.227 ; gain = 662.625
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
-
%s
*synth2
Start IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
?
%s
*synth2'
%Start Flattening Before IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
B
%s
*synth2*
(Finished Flattening Before IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
6
%s
*synth2
Start Final Netlist Cleanup
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Finished Final Netlist Cleanup
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2x
vFinished IO Insertion : Time (s): cpu = 00:00:35 ; elapsed = 00:00:39 . Memory (MB): peak = 1594.227 ; gain = 662.625
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
=
%s
*synth2%
#Start Renaming Generated Instances
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Instances : Time (s): cpu = 00:00:35 ; elapsed = 00:00:39 . Memory (MB): peak = 1594.227 ; gain = 662.625
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
:
%s
*synth2"
 Start Rebuilding User Hierarchy
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Rebuilding User Hierarchy : Time (s): cpu = 00:00:35 ; elapsed = 00:00:39 . Memory (MB): peak = 1594.227 ; gain = 662.625
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Start Renaming Generated Ports
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Ports : Time (s): cpu = 00:00:35 ; elapsed = 00:00:39 . Memory (MB): peak = 1594.227 ; gain = 662.625
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
;
%s
*synth2#
!Start Handling Custom Attributes
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:35 ; elapsed = 00:00:39 . Memory (MB): peak = 1594.227 ; gain = 662.625
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
8
%s
*synth2 
Start Renaming Generated Nets
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Nets : Time (s): cpu = 00:00:35 ; elapsed = 00:00:39 . Memory (MB): peak = 1594.227 ; gain = 662.625
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Start Writing Synthesis Report
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
/
%s
*synth2

Report BlackBoxes: 
h p
x
� 
8
%s
*synth2 
+-+--------------+----------+
h p
x
� 
8
%s
*synth2 
| |BlackBox name |Instances |
h p
x
� 
8
%s
*synth2 
+-+--------------+----------+
h p
x
� 
8
%s
*synth2 
+-+--------------+----------+
h p
x
� 
/
%s*synth2

Report Cell Usage: 
h px� 
2
%s*synth2
+------+-------+------+
h px� 
2
%s*synth2
|      |Cell   |Count |
h px� 
2
%s*synth2
+------+-------+------+
h px� 
2
%s*synth2
|1     |BUFG   |     1|
h px� 
2
%s*synth2
|2     |CARRY4 |    43|
h px� 
2
%s*synth2
|3     |LUT1   |    38|
h px� 
2
%s*synth2
|4     |LUT2   |   102|
h px� 
2
%s*synth2
|5     |LUT3   |    41|
h px� 
2
%s*synth2
|6     |LUT4   |    86|
h px� 
2
%s*synth2
|7     |LUT5   |    43|
h px� 
2
%s*synth2
|8     |LUT6   |   134|
h px� 
2
%s*synth2
|9     |FDCE   |   181|
h px� 
2
%s*synth2
|10    |FDPE   |    16|
h px� 
2
%s*synth2
|11    |FDRE   |    99|
h px� 
2
%s*synth2
|12    |FDSE   |    15|
h px� 
2
%s*synth2
|13    |LD     |     9|
h px� 
2
%s*synth2
|14    |LDC    |     9|
h px� 
2
%s*synth2
|15    |IBUF   |     8|
h px� 
2
%s*synth2
|16    |OBUF   |    16|
h px� 
2
%s*synth2
+------+-------+------+
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Writing Synthesis Report : Time (s): cpu = 00:00:35 ; elapsed = 00:00:39 . Memory (MB): peak = 1594.227 ; gain = 662.625
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
a
%s
*synth2I
GSynthesis finished with 0 errors, 0 critical warnings and 13 warnings.
h p
x
� 
�
%s
*synth2�
Synthesis Optimization Runtime : Time (s): cpu = 00:00:26 ; elapsed = 00:00:37 . Memory (MB): peak = 1594.227 ; gain = 564.195
h p
x
� 
�
%s
*synth2�
�Synthesis Optimization Complete : Time (s): cpu = 00:00:35 ; elapsed = 00:00:39 . Memory (MB): peak = 1594.227 ; gain = 662.625
h p
x
� 
B
 Translating synthesized netlist
350*projectZ1-571h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0072

1594.2272
0.000Z17-268h px� 
T
-Analyzing %s Unisim elements for replacement
17*netlist2
61Z29-17h px� 
X
2Unisim Transformation completed in %s CPU seconds
28*netlist2
0Z29-28h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
Q
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02
0Z31-138h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002

00:00:002

1594.2272
0.000Z17-268h px� 
�
!Unisim Transformation Summary:
%s111*project2c
a  A total of 18 instances were transformed.
  LD => LDCE: 9 instances
  LDC => LDCE: 9 instances
Z1-111h px� 
V
%Synth Design complete | Checksum: %s
562*	vivadotcl2

f15b1166Z4-1430h px� 
C
Releasing license: %s
83*common2
	SynthesisZ17-83h px� 

G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
602
402
02
0Z4-41h px� 
L
%s completed successfully
29*	vivadotcl2
synth_designZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
synth_design: 2

00:00:402

00:00:452

1594.2272

1081.684Z17-268h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Write ShapeDB Complete: 2

00:00:002
00:00:00.0032

1594.2272
0.000Z17-268h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2]
[C:/Users/patri/OneDrive/Documentos/vhdl/Integrador/Artix/IMain/IMain.runs/synth_1/IMain.dcpZ17-1381h px� 
�
Executing command : %s
56330*	planAhead2U
Sreport_utilization -file IMain_utilization_synth.rpt -pb IMain_utilization_synth.pbZ12-24828h px� 
\
Exiting %s at %s...
206*common2
Vivado2
Thu Dec  5 19:06:04 2024Z17-206h px� 


End Record