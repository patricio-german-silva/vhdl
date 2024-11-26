library ieee;

-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
use ieee.std_logic_1164.all;

-- SIGNED and UNSIGNED types, and relevant functions
use ieee.numeric_std.all;

entity HexToSevSeg_TB is
end entity HexToSevSeg_TB;


architecture Behavioral of HexToSevSeg_TB is
    component HexToSevSeg is    
    port ( 
        piHTSSSEna: in std_logic;
        piHTSSSData: in std_logic_vector(3 downto 0);
        poHTSSSOutput: out std_logic_vector(6 downto 0)
    );
     end component HexToSevSeg;
     
     signal D : std_logic_vector(3 downto 0);
     signal H : std_logic_vector(6 downto 0);
     signal ena : std_logic;
           
begin
    instHexToSevSeg: HexToSevSeg
        Port map ( piHTSSSEna => ena,
                   piHTSSSData => D,
                   poHTSSSOutput => H
                   );
	

    process
    begin
        ena <='1';
		D <= "0001";
		wait for 100 ns;
        ena <='0';
		wait for 100 ns;
        ena <='1';
		D <= "1000";
		wait for 100 ns;
        ena <='0';
		wait for 100 ns;
		D <= "1111";
        ena <='1';
		wait for 100 ns;
        ena <='0';
		wait for 100 ns;
    wait;
    end process;                   
     
end architecture Behavioral;


