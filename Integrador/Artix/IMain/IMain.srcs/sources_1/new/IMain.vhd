----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/01/2024 04:37:44 PM
-- Design Name: 
-- Module Name: IMain - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IMain is
    Port (  piIMClk : in STD_LOGIC;              --                                                    Port E3
            piIMRst : in STD_LOGIC;              --                                                         SW1
            piIMEna : in STD_LOGIC;              --                                                         SW0
            piIMRx : in STD_LOGIC;               --                                                    Port A9
            poIMTx : out STD_LOGIC;              --                                                    Port D10
            poIMRxTest : out STD_LOGIC;               --                                                    IO38 - T18
            poIMTxTest : out STD_LOGIC;              --                                                     IO37 - U17
            piIMSensors : in STD_LOGIC_VECTOR(3 downto 0);  -- Sensores fisicos                             BTN0 - BTN3
            poIMSevSeg : out STD_LOGIC_VECTOR(6 downto 0);  -- Al display de 7 segmentos                    IO32 - IO27
            poIMDot : out STD_LOGIC;                        -- Al punto del display de 7 segmentos -        IO26
            poIMPowerMD : out STD_LOGIC;                    -- Al pin Enable del L293D motor derecho -      IO41
            poIMDirMD : out STD_LOGIC_VECTOR(1 downto 0);   -- A los pin dir del L293D -                    LED4 y LED5
            poIMPowerMI : out STD_LOGIC;                    -- Al pin Enable del L293D motor izquierdo -    IO40
            poIMDirMI : out STD_LOGIC_VECTOR(1 downto 0);   -- A los pin dir del L293D -                    LED6 y LED7
            poIMStat : out STD_LOGIC                        -- Led de estado - BLink de 200ms en CMD In     LED0_R (G6)
    );
end IMain;

architecture A_IMain of IMain is

--  GLOBAL
signal clk, rst, ena : STD_LOGIC;

-- UaRX
signal rx, rxc : STD_LOGIC;
signal rxdata : STD_LOGIC_VECTOR(7 downto 0);

-- CommProtRx
signal cmdc : STD_LOGIC;
signal cmd : STD_LOGIC_VECTOR(7 downto 0);
signal data : STD_LOGIC_VECTOR(15 downto 0);

-- UaTx
signal tx, txc, txrdy : STD_LOGIC;

-- DecodeCmd
signal setMD, setMI, dirMD, dirMI, mode : STD_LOGIC;
signal powerMD, powerMI : STD_LOGIC_VECTOR(6 downto 0);

-- HBridgeCtrl
signal latchPoMD, latchPoMI : STD_LOGIC_VECTOR(6 downto 0);
signal latchDirMD, latchDirMI : STD_LOGIC;

-- ToDisplay
signal dispData : STD_LOGIC_VECTOR(3 downto 0);

-- Led status
signal ledstat : STD_LOGIC;

begin

    instUaRx: entity work.UaRx(A_UaRx)
        generic map(RxDIV => 10417) 
        --generic map(RxDIV => 5) 
        port map( piUaRxClk => clk, piUaRxRst => rst, piUaRxEna => ena, piUaRxRx => rx, poUaRxC => rxc, poUaRxData => rxdata);	

    instCommProtRx: entity work.CommProtRx(A_CommProtRx)
        generic map(HEADER_CHAR => 68, TRAILER_CHAR => 90, TIMEOUT => 10000000) 
        --generic map(HEADER_CHAR => 68, TRAILER_CHAR => 90, TIMEOUT => 1000) 
        port map( piCPRxClk => clk, piCPRxRst => rst, piCPRxEna => ena, piCPRxRdy => rxc, piCPRxRx => rxdata, poCPRxCmd => cmd, poCPRxData => data, poCPRxC => cmdc);	

    instUaTx: entity work.UaTx(A_UaTx)
        generic map(TxDIV => 10417) 
        --generic map(TxDIV => 5) 
        port map(piUaTxClk => clk, piUaTxRst => rst, piUaTxEna => ena, poUaTxTx => tx, piUaTxDataRdy => rxc, poUaTxC => txc, piUaTxData => rxdata );  -- loopback 
        --port map(piUaTxClk => clk, piUaTxRst => rst, piUaTxEna => ena, poUaTxTx => tx, piUaTxDataRdy => rxc, poUaTxC => txc, piUaTxData => "01010101" );  -- loopback 

    instDecodeCmd: entity work.DecodeCmd(A_DecodeCmd)
        generic map(POWER_SEL_WIDTH => 7, CTRL_PERIOD => 1000000) 
        --generic map(POWER_SEL_WIDTH => 7, CTRL_PERIOD => 100) 
        port map(piDCMDClk => clk, piDCMDRst => rst, piDCMDEna => ena, piDCMDCmdRdy => cmdc, piDCMDCmd => cmd, piDCMDData => data, piDCMDSensors => piIMSensors,
                 poDCMDSetMD => setMD, poDCMDDirSelMD => dirMD, poDCMDPowerSelMD => powerMD, poDCMDSetMI => setMI, poDCMDDirSelMI => dirMI, poDCMDPowerSelMI => powerMI, poDCMDMode => mode );	

    instHBridgeCtrlMD: entity work.HBridgeCtrl(A_HBridgeCtrl)
        generic map(POWER_SEL_WIDTH => 7, PWM_DIV => 100, PWM_PERIOD => 10000) 
        --generic map(POWER_SEL_WIDTH => 7, PWM_DIV => 100, PWM_PERIOD => 2) 
        port map( piHBCClk => clk, piHBCRst => rst, piHBCEna => ena, piHBCSet => setMD, piHBCDirSel => dirMD, piHBCPowerSel => powerMD,
                  poHBCDir => poIMDirMD, poHBCPower => poIMPowerMD, poHBCDirSel => latchDirMD, poHBCPowerSel => latchPoMD);

    instHBridgeCtrlMI: entity work.HBridgeCtrl(A_HBridgeCtrl)
        generic map(POWER_SEL_WIDTH => 7, PWM_DIV => 100, PWM_PERIOD => 10000) 
        --generic map(POWER_SEL_WIDTH => 7, PWM_DIV => 100, PWM_PERIOD => 2) 
        port map( piHBCClk => clk, piHBCRst => rst, piHBCEna => ena, piHBCSet => setMI, piHBCDirSel => dirMI, piHBCPowerSel => powerMI,
                  poHBCDir => poIMDirMI, poHBCPower => poIMPowerMI, poHBCDirSel => latchDirMI, poHBCPowerSel => latchPoMI);

    instToDisplay: entity work.ToDisplay(A_ToDisplay)
        generic map( POWER_SEL_WIDTH => 7, Max => 100000000) 
        --generic map( POWER_SEL_WIDTH => 7, Max => 100) 
        port map( piTDClk => clk, piTDRst => rst, piTDEna => ena, piTDPowerMD => latchPoMD, piTDPowerMI => latchPoMI, piTDMode => mode, poTDData => dispData, poTDDot => poIMDot);	

    instHexToSevSeg: entity work.HexToSevSeg(A_HexToSevSeg)
        port map( piHTSSSEna => ena, piHTSSSData => dispData, poHTSSSOutput => poIMSevSeg );	

    instComStatus: entity work.TTrigger(A_TTrigger)
        generic map( NBits => 20, Max => 500000) 
        --generic map( NBits => 20, Max => 50) 
        port map( piTTClk => clk, piTTEna => ena, piTTRst => cmdc, poTTO => ledstat);	


    clk <= piIMClk;
    rst <= piIMRst;
    ena <= piIMEna;
    rx <= piIMRx;
    poIMTx <= tx;
    poIMStat <= not ledstat;
    
    -- Test de UART
    poIMRxTest <= piIMRx;
    poIMTxTest <= tx;
    
end A_IMain;

