library ieee;

-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
use ieee.std_logic_1164.all;

-- SIGNED and UNSIGNED types, and relevant functions
use ieee.numeric_std.all;

entity HexDecoder_TB is
end entity HexDecoder_TB;


architecture Behavioral of HexDecoder_TB is
    component HexDecoder is    
    port ( 
        piData: in std_logic_vector(3 downto 0);
        poHexValue: out std_logic_vector(6 downto 0)
    );
     end component HexDecoder;
     
     signal D : std_logic_vector(3 downto 0);
     signal H : std_logic_vector(6 downto 0);
           
begin
    instHexDecoder: HexDecoder
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

