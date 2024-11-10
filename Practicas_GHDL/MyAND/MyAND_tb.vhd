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
entity MyAND_TB is
      -- generic / port / local declatations
end entity MyAND_TB;


-- ARCHITECTURE DECLARATION ------------------------------------------------------------------------
architecture Behavioral of MyAND_TB is
     component MyAND is
--         Generic ( N: natural
--                 );
              
    port ( 
        piA: in std_logic;
        piB: in std_logic;
        poOUT: out std_logic
    );
     end component MyAND;
     
     signal A : std_logic;
     signal B : std_logic;
     signal C : std_logic;
           
begin
    instMyAND: MyAND
--         Generic map ( N => 2 )
        Port map ( piA => A,
                   piB => B,
                   poOUT => C
                   );
                    
--     pCLK: process 
--     begin
--         CLK <= '1';
--         wait for 10 ns;
--         CLK <= '0';
--         wait for 10 ns;
--     end process pCLK; 
    
    process
    begin
--         ENA <= '0';
--         wait until falling_edge(CLK);
--         RST <= '1';
--         wait until falling_edge(CLK);
--         RST <= '0';
--         ENA <= '1';
--         wait for 85 ns;
--         ENA <= '0';
--         wait until falling_edge(CLK);
--         RST <= '1';
--         wait until falling_edge(CLK);
--         wait;
    A <='0';
    B <='0';
    wait for 10 ns;
    A <='0';
    B <='1';
    wait for 10 ns;
    A <='1';
    B <='0';
    wait for 10 ns;
    A <='1';
    B <='1';
    wait for 10 ns;
    A <='0';
    B <='0';
    wait;
    end process;                   
     
end architecture Behavioral;

