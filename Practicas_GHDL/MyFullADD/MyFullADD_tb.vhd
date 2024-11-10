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
entity MyFullADD_TB is
      -- generic / port / local declatations
end entity MyFullADD_TB;


-- ARCHITECTURE DECLARATION ------------------------------------------------------------------------
architecture Behavioral of MyFullADD_TB is
     component MyFullADD is
--         Generic ( N: natural
--                 );
              
    port ( 
        piA: in std_logic;
        piB: in std_logic;
        piCi: in std_logic;
        poS: out std_logic;
        poCo: out std_logic
    );
     end component MyFullADD;
     
     signal A : std_logic;
     signal B : std_logic;
     signal Ci : std_logic;
     signal S : std_logic;
     signal Co : std_logic;
           
begin
    instMyFullADD: MyFullADD
--         Generic map ( N => 2 )
        Port map ( piA => A,
                   piB => B,
                   piCi => Ci,
                   poS => S,
                   poCo => Co
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
    Ci <='0';
    wait for 10 ns;
    A <='0';
    B <='0';
    Ci <='1';
    wait for 10 ns;
    A <='0';
    B <='1';
    Ci <='0';
    wait for 10 ns;
    A <='0';
    B <='1';
    Ci <='1';
    wait for 10 ns;
    A <='1';
    B <='0';
    Ci <='0';
    wait for 10 ns;
    A <='1';
    B <='0';
    Ci <='1';
    wait for 10 ns;
    A <='1';
    B <='1';
    Ci <='0';
    wait for 10 ns;
    A <='1';
    B <='1';
    Ci <='1';
    wait for 10 ns;
    A <='0';
    B <='0';
    Ci <='0';
    wait;
    end process;                   
     
end architecture Behavioral;

