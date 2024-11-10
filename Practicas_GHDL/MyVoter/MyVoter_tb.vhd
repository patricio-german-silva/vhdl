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
entity MyVoter_TB is
      -- generic / port / local declatations
end entity MyVoter_TB;


-- ARCHITECTURE DECLARATION ------------------------------------------------------------------------
architecture Behavioral of MyVoter_TB is
     component MyVoter is
--         Generic ( N: natural
--                 );
              
    port ( 
        piX: in std_logic;
        piY: in std_logic;
        piZ: in std_logic;
        poOUT: out std_logic
    );
     end component MyVoter;
     
     signal X : std_logic;
     signal Y : std_logic;
     signal Z : std_logic;
     signal O : std_logic;
           
begin
    instMyVoter: MyVoter
--         Generic map ( N => 2 )
        Port map ( piX => X,
                   piY => Y,
                   piZ => Z,
                   poOUT => O
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
    X <='0';
    Y <='0';
    Z <='0';
    wait for 10 ns;
    X <='0';
    Y <='0';
    Z <='1';
    wait for 10 ns;
    X <='0';
    Y <='1';
    Z <='0';
    wait for 10 ns;
    X <='0';
    Y <='1';
    Z <='1';
    wait for 10 ns;
    X <='1';
    Y <='0';
    Z <='0';
    wait for 10 ns;
    X <='1';
    Y <='0';
    Z <='1';
    wait for 10 ns;
    X <='1';
    Y <='1';
    Z <='0';
    wait for 10 ns;
    X <='1';
    Y <='1';
    Z <='1';
    wait for 10 ns;
    X <='0';
    Y <='0';
    Z <='0';
    wait;
    end process;                   
     
end architecture Behavioral;

