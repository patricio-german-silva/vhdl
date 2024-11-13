----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/08/2024 04:04:23 PM
-- Design Name: 
-- Module Name: Uart_TB - Behavioral
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

entity Uart_TB is
--  Port ( );
end Uart_TB;

architecture Behavioral of Uart_TB is
   component Uart is
    Generic ( DIV: NATURAL:= 10417); -- 100Mhz/DIV -> 9600 baud
    Port (  piUartClk : in STD_LOGIC; -- Clock de entrada
            piUartRst : in STD_LOGIC; -- Reset
    
            piUartRxEna : in STD_LOGIC; -- RX Enable
            piUartTxEna : in STD_LOGIC; -- TX Enable

            piUartRx : in STD_LOGIC;    -- Puerto RX
            poUartRxC: out STD_LOGIC; -- Receive complete - Hay datos para leer en el buffer poUartRxData 
            poUartRxData : out STD_LOGIC_VECTOR (8-1 downto 0);

            poUartTx : out STD_LOGIC;    -- Puerto TX
            piUartTxRdy : in STD_LOGIC;   -- Transmit ready - Los datos en piUartTxData estan listos para ser enviados
            poUartTxC : out STD_LOGIC;   -- Transmit Complete - Los datos en piUartTxData fueron enviados
            piUartTxData : in STD_LOGIC_VECTOR (8-1 downto 0)
    );
   end component Uart;

   signal clk, rst, rxena, txena, rx, rxc, tx, txrdy, txc: STD_LOGIC;
   signal txdata, rxdata: STD_LOGIC_VECTOR(8-1 downto 0);
   constant data: STD_LOGIC_VECTOR(8-1 downto 0) := "10101010";
begin

       instUart: Uart
       generic map(DIV => 4)
       Port map ( piUartClk => clk,
            piUartRst => rst ,
            piUartRxEna => rxena,
            piUartTxEna => txena ,
            piUartRx => rx,
            poUartRxC => rxc,
            poUartRxData => rxdata,
            poUartTx => tx,
            piUartTxRdy => txrdy,
            poUartTxC => txc,
            piUartTxData => txdata);

   pClk: process
	begin
		clk <= '1';
		wait for 10 ns;
		clk <= '0';
		wait for 10 ns;
	end process;	


    process
    begin
       rst <= '1';
       rxena <= '0';
       rx <= '1';
       wait for 33 ns;
       rst <= '0';
       rxena <= '1';

       wait for 33 ns;
       rx <= '0';
       wait for 20 ns;

       for i in 0 to 7 loop
         rx <= data(i);
         wait for 40 ns;
       end loop;

       rx <= '1';
       wait for 30 ns;

    wait;
    end process;

end Behavioral;
