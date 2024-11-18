library ieee;

-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
use ieee.std_logic_1164.all;

-- SIGNED and UNSIGNED types, and relevant functions
use ieee.numeric_std.all;

entity DecToSevSeg_TB is
end entity DecToSevSeg_TB;


architecture Behavioral of DecToSevSeg_TB is
    component DecToSevSeg is    
    port ( 
        piDTSSSData: in std_logic_vector(6 downto 0);
        poDTSSSOutput: out std_logic_vector(7 downto 0)
    );
     end component DecToSevSeg;
     
     signal D : std_logic_vector(6 downto 0);
     signal H : std_logic_vector(7 downto 0);
           
begin
    instDecToSevSeg: DecToSevSeg
        Port map ( piDTSSSData => D,
                   poDTSSSOutput => H
                   );
    process
    begin
        for i in 60 to 127 loop
			D <= std_logic_vector(TO_UNSIGNED(i, 7));
			wait for 5 ns;
		end loop;
    wait;
    end process;                   
     
end architecture Behavioral;


