----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/08/2024 04:04:23 PM
-- Design Name: 
-- Module Name: Uart_tb - Behavioral
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

entity Uart_tb is
--  Port ( );
end Uart_tb;

architecture Behavioral of Uart_tb is

   component Uart is
   Generic ( DIV: NATURAL:= 10417); -- 100Mhz/DIV -> 9600 baud
   Port (  piUartClk : in STD_LOGIC; -- Clock de entrada
           piUartRst : in STD_LOGIC; -- Reset
   
           piUartRxEna : in STD_LOGIC; -- RX Enable
           piUartTxEna : in STD_LOGIC; -- TX Enable

           piUartRx : in STD_LOGIC;    -- Puerto RX
           poUartRxC: out STD_LOGIC; -- Receive complete - Hay datos para leer en el buffer poUartRxData 
           poUartRxData : out STD_LOGIC_VECTOR (8-1 downto 0);

           piUartTxDataRdy : in STD_LOGIC;   -- Transmit ready - Los datos en piUartTxData estan listos para ser enviados
           piUartTxData : in STD_LOGIC_VECTOR (8-1 downto 0);
           poUartTx : out STD_LOGIC;    -- Puerto TX
           poUartTxC : out STD_LOGIC   -- Transmit Complete - Los datos en piUartTxData fueron enviados
   );
   end component;


   signal clk, rst, rxena, txena, rx, rxc, tx, txc, txrdy: STD_LOGIC;
   signal input, data: STD_LOGIC_VECTOR(8-1 downto 0);
   constant brt: time := 145 ns;
begin

       instUart: Uart
       generic map(DIV => 15)
       Port map ( piUartClk => clk,
            piUartRst => rst,
            piUartRxEna => rxena,
            piUartTxEna => txena,
            piUartRx => rx,
            poUartRxC => rxc,
            poUartRxData => data,
            piUartTxDataRdy =>txrdy,
            piUartTxData => data,
            poUartTx => tx,
            poUartTxC => txc);


   pClk: process
	begin
		clk <= '1';
		wait for 5 ns;
		clk <= '0';
		wait for 5 ns;
	end process;	


    process
      variable value : NATURAL;
    begin
      rx <= '1';
      rst <= '0';
      rxena <= '1';
      txena <= '1';

      value := 1;
      input <= STD_LOGIC_VECTOR(TO_UNSIGNED(value, 8));
      for n in 0 to 4 loop
          wait for brt;
          rx <= '0';
          for i in 0 to 7 loop
              wait for brt;
              rx <= input(i);
          end loop;
          wait for brt;
          rx <= '1';
          value := value * 2 + 1;
          input <= STD_LOGIC_VECTOR(TO_UNSIGNED(value, 8));
       end loop;

--       rx <= '0';
--       input <= "10101010";
--       for i in 0 to 7 loop
--           wait for brt;
--           rx <= input(i);
--       end loop;
--       wait for brt;
--       rx <= '1';
--
--       wait for brtl;
--       rx <= '0';
--       input <= "11001100";
--       for i in 0 to 7 loop
--           wait for brt;
--           rx <= input(i);
--       end loop;
--       wait for brt;
--       rx <= '1';
--
--       wait for brtl;
--       rx <= '0';
--       input <= "00110011";
--       for i in 0 to 7 loop
--           wait for brt;
--           rx <= input(i);
--       end loop;
--       wait for brt;
--       rx <= '1';
--
--       wait for brtl;
--       rx <= '0';
--       input <= "00001111";
--       for i in 0 to 7 loop
--           wait for brt;
--           rx <= input(i);
--       end loop;
--       wait for brt;
--       rx <= '1';

       wait;

    end process;

    txrdy <= rxc;

end Behavioral;
