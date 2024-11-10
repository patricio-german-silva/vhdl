-- File:
-- Author:
-- Date:
-- Revision:
-- Description:

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.NUMERIC_BIT.ALL;


-- ENTITY DECLARATION ------------------------------------------------------------------------------
entity MySquare3_TB is
      -- generic / port / local declatations
end entity MySquare3_TB;


-- ARCHITECTURE DECLARATION ------------------------------------------------------------------------
architecture Behavioral of MySquare3_TB is
     component MySquare3 is

              
    port ( 
        piBits: in std_logic_vector(2 downto 0);
        poResult: out std_logic_vector(5 downto 0)
    );
     end component MySquare3;
     
     signal B : std_logic_vector(2 downto 0);
     signal R : std_logic_vector(5 downto 0);
           
begin
    instMySquare3: MySquare3
--         Generic map ( N => 2 )
        Port map ( piBits => B,
                   poResult => R
                   );
                    
    
    process
    begin

    B <= "000";
    wait for 10 ns;
    B <= "001";
    wait for 10 ns;
    B <= "010";
    wait for 10 ns;
    B <= "011";
    wait for 10 ns;
    B <= "100";
    wait for 10 ns;
    B <= "101";
    wait for 10 ns;
    B <= "110";
    wait for 10 ns;
    B <= "111";
    wait for 10 ns;
    B <= "000";
    wait;

    end process;                   
     
end architecture Behavioral;

