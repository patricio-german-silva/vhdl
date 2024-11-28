----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/08/2024 04:04:23 PM
-- Design Name: 
-- Module Name: UaRx_TB - Behavioral
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

entity UaRx_TB is
--  Port ( );
end UaRx_TB;

architecture Behavioral of UaRx_TB is
   component UaRx is
    Generic ( RxDIV: NATURAL:= 10417); -- 100Mhz/DIV -> 9600 baud
    Port (  piUaRxClk : in STD_LOGIC; -- Clock de entrada
            piUaRxRst : in STD_LOGIC; -- Reset
            piUaRxEna : in STD_LOGIC; -- RX Enable
            piUaRxRx : in STD_LOGIC;    -- Puerto RX
            poUaRxC: out STD_LOGIC; -- Receive complete - Hay datos para leer en el buffer poUaRxData 
            poUaRxData : out STD_LOGIC_VECTOR (8-1 downto 0)
    );
   end component UaRx;
  
   
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
    
    
   signal clk, rst, ena, rx, rxc, tx, txr, txc: STD_LOGIC;
   signal data, datatx: STD_LOGIC_VECTOR(8-1 downto 0);
   signal test: STD_LOGIC_VECTOR(29 downto 0);
begin

       instUaRx: UaRx
       generic map(RxDIV => 5)
       Port map ( piUaRxClk => clk,
            piUaRxRst => rst,
            piUaRxEna => ena,
            piUaRxRx => rx,
            poUaRxC => rxc,
            poUaRxData => data);

       instUaTx: UaTx
       generic map(TxDIV => 5)
       Port map ( piUaTxClk => clk,
            piUaTxRst => rst,
            piUaTxEna => ena,
            poUaTxTx => tx,
            piUaTxDataRdy => txr,
            poUaTxC => txc,
            poUaTxData => datatx);
            
   pClk: process
	begin
		clk <= '1';
		wait for 1 ns;
		clk <= '0';
		wait for 1 ns;
	end process;	


    process
    begin
       rx <= '1';
       rst <= '0';
       ena <= '1';
       test <= "101010101010101010101010101010";
       wait for 13 ns;

       
       for i in 0 to 29 loop
           rx <= test(i);
           wait for 10 ns;
       end loop;
       rx <= '0';
       wait for 100 ns;
       wait;

    end process;

end Behavioral;
