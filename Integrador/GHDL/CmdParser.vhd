----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/01/2024 04:37:44 PM
-- Design Name: 
-- Module Name: CmdParser - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Recibe comandos por UART y los interpreta
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

entity CmdParser is
    Generic( POWER_SEL_WIDTH: NATURAL:=7);    -- Ancho en bits del selector de PWM
    Port (  piCMDPClk : in STD_LOGIC;
            piCMDPRst : in STD_LOGIC;
            piCMDPEna : in STD_LOGIC;
            piCMDPUaRx : in STD_LOGIC;   -- Puerto rx
            poCMDPRDirM1 : out STD_LOGIC;
            poCMDPRDirM2 : out STD_LOGIC;
            poCMDPRPowerM1 : out STD_LOGIC_VECTOR(POWER_SEL_WIDTH-1 downto 0);
            poCMDPRPowerM2 : out STD_LOGIC_VECTOR(POWER_SEL_WIDTH-1 downto 0)
    );
end CmdParser;

architecture A_CmdParser of CmdParser is

signal rxcmd: STD_LOGIC_VECTOR(7 downto 0);
signal rxdata: STD_LOGIC_VECTOR(15 downto 0);

begin
    

instUart: entity work.UaRx(A_UaRx)
    generic map(DIV => 10417) 
    port map(piUaRxClk => piCMDPClk, piUaRxRst => piCMDPRst, piUaRxEna => piCMDPEna, piUaRxRx => piCMDPUaRx, poUaRxC => piCPRxClk, poUaRxData => piCPRxRx);

instCommProtRx: entity work.CommProtRx(A_CommProtRx)
    generic map(HEADER_CHAR => 67, TRAILER_CHAR => 90) 
    port map(piCPRxClk => poUaRxC, piCPRxRst => piCMDPRst, piCPRxEna => piCMDPEna, piCPRxRx => poUaRxData, poCPRxCmd => rxcmd, poCPRxData => rxdata);


end A_CmdParser;

