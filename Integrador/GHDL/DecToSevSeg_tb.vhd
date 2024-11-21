library ieee;

-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
use ieee.std_logic_1164.all;

-- SIGNED and UNSIGNED types, and relevant functions
use ieee.numeric_std.all;

entity DecToSevSeg_TB is
end entity DecToSevSeg_TB;


architecture Behavioral of DecToSevSeg_TB is
    component DecToSevSeg is    
    Generic( D: NATURAL := 100000000);
    port ( 
        piDTSSSClk: in std_logic;
        piDTSSSData: in std_logic_vector(13 downto 0);
        poDTSSSOutput: out std_logic_vector(7 downto 0)
    );
     end component DecToSevSeg;
     
     signal D : std_logic_vector(13 downto 0);
     signal H : std_logic_vector(7 downto 0);
     signal clk : std_logic;
           
begin
    instDecToSevSeg: DecToSevSeg
        Generic map( D => 4)
        Port map ( piDTSSSClk => clk,
                   piDTSSSData => D,
                   poDTSSSOutput => H
                   );
	
    pClk: process
	begin
		clk <= '1';
		wait for 1 ns;
		clk <= '0';
		wait for 1 ns;
	end process;	
   

    process
    begin
		D(13 downto 7) <= std_logic_vector(TO_UNSIGNED(40, 7));
		D(6 downto 0) <= std_logic_vector(TO_UNSIGNED(44, 7));
		wait for 200 ns;
		D(13 downto 7) <= std_logic_vector(TO_UNSIGNED(66, 7));
		D(6 downto 0) <= std_logic_vector(TO_UNSIGNED(80, 7));
		wait for 200 ns;
    wait;
    end process;                   
     
end architecture Behavioral;


