----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/03/2024 06:08:52 PM
-- Design Name: 
-- Module Name: MyHexDecoder_TB - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity MyHexDecoder_TB is
end entity MyHexDecoder_TB;


architecture Behavioral of MyHexDecoder_TB is
    component MyHexDecoder is    
    port ( 
        piData: in std_logic_vector(3 downto 0);
        poHexValue: out std_logic_vector(6 downto 0)
    );
     end component MyHexDecoder;
     
     signal D : std_logic_vector(3 downto 0);
     signal H : std_logic_vector(6 downto 0);
           
begin
    instMyHexDecoder: MyHexDecoder
        Port map ( piData => D,
                   poHexValue => H
                   );
    process
    begin
        for i in 0 to 15 loop
			D <= std_logic_vector(TO_UNSIGNED(i, 4));
			wait for 10 ns;
		end loop;
    wait;
    end process;                   
     
end architecture Behavioral;
