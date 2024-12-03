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
use IEEE.NUMERIC_STD.ALL;

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
            poUaRxData : out STD_LOGIC_VECTOR (8-1 downto 0);
            poUaRxBR : out STD_LOGIC;
            poUaRxRx : out STD_LOGIC
    );
   end component UaRx;

   signal clk, rst, ena, rx, rxc, br, rxo: STD_LOGIC;
   signal data: STD_LOGIC_VECTOR(8-1 downto 0);
   signal test: STD_LOGIC_VECTOR(7 downto 0);
begin

       instUaRx: UaRx
       generic map(RxDIV => 100000000/9600)
       Port map ( piUaRxClk => clk,
            piUaRxRst => rst,
            piUaRxEna => ena,
            piUaRxRx => rx,
            poUaRxC => rxc,
            poUaRxData => data,
            poUaRxBR => br,
            poUaRxRx => rxo);

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
       wait for 200 ns;
       
       rx <= '1';
       rst <= '0';
       ena <= '1';
       test <= std_logic_vector(TO_UNSIGNED(85, 8));
       wait for 345 us;

       rx <= '0';
       wait for 104 us;
       for i in 0 to 7 loop
           rx <= test(i);
           wait for 104 us;
       end loop;
       rx <= '1';

       test <= std_logic_vector(TO_UNSIGNED(195, 8));
       wait for 104 us;
       rx <= '0';
       wait for 104 us;
       for i in 0 to 7 loop
           rx <= test(i);
           wait for 104 us;
       end loop;
       rx <= '1';
       wait for 300 us;
       wait;

    end process;

end Behavioral;
