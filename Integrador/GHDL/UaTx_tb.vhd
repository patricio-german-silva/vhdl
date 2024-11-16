----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/08/2024 04:04:23 PM
-- Design Name: 
-- Module Name: UaTx_TB - Behavioral
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

entity UaTx_TB is
--  Port ( );
end UaTx_TB;

architecture Behavioral of UaTx_TB is
   component UaTx is
    Generic ( TxDIV: NATURAL:= 10417); -- 100Mhz/DIV -> 9600 baud
    Port (  piUaTxClk : in STD_LOGIC; -- Clock de entrada
            piUaTxRst : in STD_LOGIC; -- Reset
            piUaTxEna : in STD_LOGIC; -- TX Enable

            poUaTxTx : out STD_LOGIC;    -- Puerto TX
            piUaTxDataRdy : in STD_LOGIC;   -- Transmit ready - Los datos en piUaTxData estan listos para ser enviados
            poUaTxC : out STD_LOGIC;   -- Transmit Complete - Los datos en piUaTxData fueron enviados
            piUaTxData : in STD_LOGIC_VECTOR (8-1 downto 0)
    );
   end component UaTx;

   signal clk, rst, ena, txdrdy, tx, txc: STD_LOGIC;
   signal data: STD_LOGIC_VECTOR(8-1 downto 0);
begin

       instUaTx: UaTx
       generic map(txDIV => 4)
       Port map ( piUaTxClk => clk,
            piUaTxRst => rst,
            piUaTxEna => ena,
            poUaTxTx => tx,
            poUaTxC => txc,
            piUaTxDataRdy => txdrdy,
            piUaTxData => data);

   pClk: process
	begin
		clk <= '1';
		wait for 1 ns;
		clk <= '0';
		wait for 1 ns;
	end process;	


    process
    begin
       rst <= '1';
       ena <= '0';
       wait for 13 ns;
       rst <= '0';
       ena <= '1';

       wait for 13 ns;
       data <= "00110011";
       txdrdy <= '1';
       wait for 13 ns;
       txdrdy <= '0';
       wait until rising_edge(txc);
       data <= "10101010";
       txdrdy <= '1';
       wait for 13 ns;
       txdrdy <= '0';

       wait;

    end process;

end Behavioral;
