----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/08/2024 04:04:23 PM
-- Design Name: 
-- Module Name: DecodeCmd_TB - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DecodeCmd_TB is
--  Port ( );
end DecodeCmd_TB;

architecture Behavioral of DecodeCmd_TB is
   component DecodeCmd is
    Generic( POWER_SEL_WIDTH: NATURAL:=7);    -- Ancho en bits del selector de PWM
    Port (  piDCMDClk : in STD_LOGIC;
            piDCMDRst : in STD_LOGIC;
            piDCMDEna : in STD_LOGIC;
            piDCMDCmdRdy: in STD_LOGIC; -- Recibido nuevo comando
            piDCMDCmd : in STD_LOGIC_VECTOR(7 downto 0);
            piDCMDData : in STD_LOGIC_VECTOR (15 downto 0);
            piDCMDSensors: in STD_LOGIC_VECTOR(3 downto 0);
            poDCMDSetMD : out STD_LOGIC;
            poDCMDDirSelMD : out STD_LOGIC;
            poDCMDPowerSelMD: out STD_LOGIC_VECTOR (POWER_SEL_WIDTH-1 downto 0);
            poDCMDSetMI : out STD_LOGIC;
            poDCMDDirSelMI : out STD_LOGIC;
            poDCMDPowerSelMI: out STD_LOGIC_VECTOR (POWER_SEL_WIDTH-1 downto 0);
            poDCMDMode: out STD_LOGIC
    );
   end component DecodeCmd;

   signal clk, rst, ena, cmdrdy, setMD, setMI, dirMD, dirMI, mode: STD_LOGIC;
   signal cmd: STD_LOGIC_VECTOR(7 downto 0);
   signal data: STD_LOGIC_VECTOR(15 downto 0);
   signal poMD: STD_LOGIC_VECTOR(6 downto 0);
   signal poMI: STD_LOGIC_VECTOR(6 downto 0);
   signal sensors: STD_LOGIC_VECTOR(3 downto 0);
begin

       instDecodeCmd: DecodeCmd
       generic map(POWER_SEL_WIDTH => 7)
       Port map ( piDCMDClk => clk,
				    piDCMDRst => rst,
				    piDCMDEna => ena,
				    piDCMDCmdRdy => cmdrdy,
				    piDCMDCmd => cmd,
				    piDCMDData => data,
				    piDCMDSensors=> sensors,
				    poDCMDSetMD => setMD,
				    poDCMDDirSelMD => dirMD,
				    poDCMDPowerSelMD => poMD,
				    poDCMDSetMI => setMI,
				    poDCMDDirSelMI => dirMI,
				    poDCMDPowerSelMI => poMI,
				    poDCMDMode => mode
				    );

   pClk: process
	begin
		clk <= '1';
		wait for 5 ns;
		clk <= '0';
		wait for 5 ns;
	end process;	


    process
    begin
       rst <= '1';
       ena <= '0';
       cmdrdy <= '0';
       wait for 33 ns;
       rst <= '0';
       ena <= '1';
       wait until falling_edge(clk);
       cmdrdy <= '1';
       cmd <= "00000001";
       data <= "0000010100000101";
       wait until falling_edge(clk);
       cmdrdy <= '0';
       
       wait until falling_edge(clk);
       cmdrdy <= '1';
       cmd <= "00000010";
       data <= "0000001100000000";
       wait until falling_edge(clk);
       cmdrdy <= '0';

       wait until falling_edge(clk);
       cmdrdy <= '1';
       cmd <= "00000011";
       data <= "0000010100000101";
       wait until falling_edge(clk);
       cmdrdy <= '0';

       wait;

    end process;

end Behavioral;

