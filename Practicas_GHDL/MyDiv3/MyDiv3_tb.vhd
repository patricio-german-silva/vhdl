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
entity MyDiv3_TB is
      -- generic / port / local declatations
end entity MyDiv3_TB;


-- ARCHITECTURE DECLARATION ------------------------------------------------------------------------
architecture Behavioral of MyDiv3_TB is
     component MyDiv3 is
--         Generic ( N: natural
--                 );
              
    port ( 
        piBCD: in std_logic_vector(3 downto 0);
        poOUT: out std_logic_vector(2 downto 0)  
    );
     end component MyDiv3;
     
     signal A : std_logic_vector(3 downto 0);
     signal B : std_logic_vector(2 downto 0);
           
begin
    insMyDiv3: MyDiv3
--         Generic map ( N => 2 )
        Port map ( piBCD => A,
                   poOUT => B
                   );
    
    process
    begin

    A <= "0000";
    wait for 10 ns;
    A <= "0001";
    wait for 10 ns;
    A <= "0010";
    wait for 10 ns;
    A <= "0011";
    wait for 10 ns;
    A <= "0100";
    wait for 10 ns;
    A <= "0101";
    wait for 10 ns;
    A <= "0110";
    wait for 10 ns;
    A <= "0111";
    wait for 10 ns;
    A <= "1000";
    wait for 10 ns;
    A <= "1001";
    wait for 10 ns;
    A <= "1010";
    wait for 10 ns;
    A <= "1011";
    wait for 10 ns;
    A <= "1100";
    wait for 10 ns;
    A <= "1101";
    wait for 10 ns;
    A <= "1110";
    wait for 10 ns;
    A <= "1111";
    wait for 10 ns;
    A <= "0000";
    wait;
    end process;                   
     
end architecture Behavioral;

